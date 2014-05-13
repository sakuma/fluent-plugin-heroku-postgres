class Fluent::HerokuPostgresOutput < Fluent::BufferedOutput
  Fluent::Plugin.register_output('heroku_postgres', self)

  include Fluent::SetTimeKeyMixin
  include Fluent::SetTagKeyMixin

  attr_accessor :host, :port, :database, :username, :password

  config_param :heroku_postgres_url, :string

  config_param :key_names, :string, :default => nil # nil allowed for json format
  config_param :sql, :string, :default => nil
  config_param :table, :string, :default => nil
  config_param :columns, :string, :default => nil

  config_param :format, :string, :default => "raw" # or json

  attr_accessor :handler

  def initialize
    super
    require 'pg'
  end

  # We don't currently support mysql's analogous json format
  def configure(conf)
    super

    parse_heroku_postgres_url!

    if @format == 'json'
      @format_proc = Proc.new{|tag, time, record| record.to_json}
    else
      @key_names = @key_names.split(',')
      @format_proc = Proc.new{|tag, time, record| @key_names.map{|k| record[k]}}
    end

    if @columns.nil? and @sql.nil?
      raise Fluent::ConfigError, "columns or sql MUST be specified, but missing"
    end
    if @columns and @sql
      raise Fluent::ConfigError, "both of columns and sql are specified, but specify one of them"
    end
  end

  def start
    super
  end

  def shutdown
    super
  end

  def format(tag, time, record)
    [tag, time, @format_proc.call(tag, time, record)].to_msgpack
  end

  def client
    PG::Connection.new({
      :host => @host, :port => @port,
      :user => @username, :password => @password,
      :dbname => @database
    })
  end

  def write(chunk)
    handler = self.client
    handler.prepare("write", @sql)
    chunk.msgpack_each { |tag, time, data|
      handler.exec_prepared("write", data)
    }
    handler.close
  end

  private

  def parse_heroku_postgres_url!
    parsed_url = URI.parse(@heroku_postgres_url)
    @host = parsed_url.host
    @port = parsed_url.port
    @database = parsed_url.path.sub(/\//, '')
    @username = parsed_url.user
    @password = parsed_url.password
  end
end
