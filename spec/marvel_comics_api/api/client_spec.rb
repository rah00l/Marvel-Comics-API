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
end
