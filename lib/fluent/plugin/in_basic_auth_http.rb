module Fluent
  class BasicAuthHttp < Fluent::HttpInput
    Plugin.register_input('basic_auth_http', self)

    def on_request(path_info, params)
      unless authenticate(params["HTTP_AUTHORIZATION"])
        return ['401 Unauthorized', {'Content-type'=>'text/plain'}, "401 Unauthorized\n"]
      end

      super
    end

    private

    def authenticate(value)
      return false unless value
      require 'base64'
      base64_str = value.split(' ', 2).last || ''
      Base64.decode64(base64_str) == "#{ENV['USERNAME']}:#{ENV['PASSWORD']}"
    end
  end
end
