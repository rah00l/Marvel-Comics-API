module MarvelComicsApi
  module API
    class Client
      include HTTParty
      base_uri 'http://gateway.marvel.com'

      attr_accessor :public_key, :private_key, :api_version, :router

      class InvalidClientError < StandardError; end

      def initialize(attrs)
        check_for_errors(attrs)
        @public_key = attrs.fetch(:public_key)
        @private_key = attrs.fetch(:private_key)
        @api_version = attrs.fetch(:api_version) { 'v1' }
        @router = attrs.fetch(:router) { MarvelComicsApi.router(:api_version => @api_version) }
      end

      def characters(query_params = {})
        response = self.class.get("/#{api_version}/#{router.characters_path}", :query => params(query_params))
        Response.new(response)
      end

      private
      def check_for_errors(attrs)
        [:public_key, :private_key].each do |key|
          raise InvalidClientError, "You need to provide a :#{key} param." unless attrs[key]
        end
      end

      def params(additional_params = {})
        base_hash = { :apikey => public_key, :ts => ts, :hash => request_hash }
        additional_params.merge(base_hash)
      end

      def request_hash
        Digest::MD5.hexdigest("#{ts}#{private_key}#{public_key}")
      end

      def ts
        begin
          Time.now.to_i
        end
      end
		end
	end
end
