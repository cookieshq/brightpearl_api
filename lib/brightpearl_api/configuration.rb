require 'singleton'

module BrightpearlApi
  class Configuration
    include Singleton

    attr_accessor :datacenter, :account, :app_ref, :account_token

    def self.instance
      @@instance ||= new
    end

    def init(args = {})
      @datacenter = default_datacenter
      @account = default_account
      @app_ref = default_app_ref
      @account_token = default_account_token

      args.each_pair do |option, value|
        self.send("#{option}=", value)
      end
    end

    def valid?
      result = true
      [:datacenter, :account, :app_ref, :account_token].each do |value|
        result = false if self.send(value).blank?
      end
      result
    end

    def uri(path)
      "https://" + @datacenter + ".brightpearl.com/public-api/" + @account + path
    end

    # def auth_uri
    #   uri('/authorise').sub("/" + @version, "")
    # end

    private

    def default_datacenter
      ENV['BRIGHTPEARL_DATACENTER']
    end

    def default_account
      ENV['BRIGHTPEARL_ACCOUNT']
    end

    def default_app_ref
      ENV['BRIGHTPEARL_APP_REF']
    end

    def default_account_token
      ENV['BRIGHTPEARL_ACCOUNT_TOKEN']
    end
  end
end
