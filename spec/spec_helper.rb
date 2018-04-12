require 'marvel_comics_api'
require 'pathname'
require 'json'
require 'hashie'
require 'fakeweb'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.syntax = :should
  end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

RSpec.configure do |config|

  def marvel_url(url)
    "http://gateway.marvel.com/v1/public/#{url}"
  end

  def marvel_comics_api_test_client
    client = MarvelComicsApi::API::Client.new(:public_key => '123456', :private_key => 'abcdef')
    client.stub(:ts).and_return('1')
    client.stub(:hash).and_return('d4f1bab013916a533ef31e3ad5fb0887')
    client
  end

  def json_response(filename)
    file = Pathname("./spec/fixtures/#{filename}")
    file.read
  end

  def stub_get(url, filename, options={})
    opts = {
      :body => json_response(filename),
      :content_type => 'application/json; charset=utf-8'
    }.merge(options)
    FakeWeb.register_uri(:get, marvel_url(url), opts)
  end
end
