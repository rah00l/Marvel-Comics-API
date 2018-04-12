require 'digest'
require 'httparty'
require 'hashie'

require "marvel_comics_api/version"
require "marvel_comics_api/api/router"
require "marvel_comics_api/api/client"
require "marvel_comics_api/api/response"

module MarvelComicsApi
  def self.router(attrs = {})
    MarvelComicsApi::API::Router.new
  end
end
