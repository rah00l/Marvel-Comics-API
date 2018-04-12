require 'spec_helper'

describe MarvelComicsApi::API::Client do
  describe 'initialization' do
    it 'requires a :public_key to be set' do
      expect{ MarvelComicsApi::API::Client.new(:private_key => '12345') }.to raise_error(
        MarvelComicsApi::API::Client::InvalidClientError, "You need to provide a :public_key param."
      )
    end

    it 'requires a :private_key to be set' do
      expect{ MarvelComicsApi::API::Client.new(:public_key => '1234') }.to raise_error(
        MarvelComicsApi::API::Client::InvalidClientError, "You need to provide a :private_key param."
      )
    end

    context 'valid' do
      let(:client) { MarvelComicsApi::API::Client.new(:public_key => '1234', :private_key => 'abcd') }

      describe '#api_version' do
        it 'receives an :api_version optional param' do
          client = MarvelComicsApi::API::Client.new(
            :public_key => '1234', :private_key => 'abcd', :api_version => 'v1'
          )
          expect(client.api_version).to eq('v1')
        end

        it 'defaults to v1' do
          expect(client.api_version).to eq('v1')
        end
      end

      it 'is an instance of MarvelComicsApi::Client' do
        expect(client).to be_a(MarvelComicsApi::API::Client)
      end

      it 'has an API Router instance in its config' do
        expect(client.router).to_not be_nil
        expect(client.router).to be_a(MarvelComicsApi::API::Router)
      end
    end
  end

  context "private methods" do
    describe '#ts' do
      let(:client) { MarvelComicsApi::API::Client.new(:public_key => '1234', :private_key => 'abcd') }

      it 'calls Time.now' do
        Time.should_receive(:now)
        client.send(:ts)
      end

      it 'represents a timestamp converted to integer' do
        expect(client.send(:ts)).to be_a(Integer)
      end
    end

    describe '#params' do
      let(:client) { MarvelComicsApi::API::Client.new(:public_key => '1234', :private_key => 'abcd') }

      it 'passes required API params to all requests' do
        client.stub(:ts).and_return('1')
        expect(client.send(:params)).to eq(
          {:apikey => client.public_key, :ts => '1', :hash => 'ffd275c5130566a2916217b101f26150'}
        )
      end
    end
  end

  context "Character Endpoints" do
    let(:client) { marvel_comics_api_test_client }

    describe '#characters' do
      before do
        stub_get('characters?apikey=123456&ts=1&hash=d4f1bab013916a533ef31e3ad5fb0887', 'characters.json')
      end

      it 'returns a MarvelComicsApi::API::Response object' do
        expect(client.characters).to be_a(MarvelComicsApi::API::Response)
      end

      it 'Response object is populated with JSON from the characters endpoint' do
        expect(client.characters["status"]).to eq("Ok")
        expect(client.characters[:data][:results].size).to eq(20)
      end
    end
  end
end
