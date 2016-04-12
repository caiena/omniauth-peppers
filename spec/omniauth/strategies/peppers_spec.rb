require 'spec_helper'

describe OmniAuth::Strategies::Peppers do
  let(:access_token) { double('AccessToken', options: {}) }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', :parsed => parsed_response) }

  subject do
    OmniAuth::Strategies::Peppers.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  describe 'client options' do
    it 'has correct site' do
      expect(subject.options.client_options.site).to eq('http://peppers.caiena.net/api/v1')
    end

    it 'has correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('http://peppers.caiena.net/oauth/authorize')
    end

    it 'has correct token url' do
      expect(subject.options.client_options.token_url).to eq('http://peppers.caiena.net/oauth/access_token')
    end
  end

  describe '#raw_info' do
    it 'should use relative paths' do
      expect(access_token).to receive(:get).with('user').and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end
  end
end
