require 'rails_helper'

describe ::Nlu do
  subject { described_class.new(url) }

  describe '#call' do
    context 'with valid url' do
      let(:url) { 'https://example.com' }
      let(:result) { subject.call }

      before do
        allow(::ParseSite.new(url)).to receive(:call)
        allow(subject).to receive(:get_response)
      end

      it 'analyzed  the site\'s content' do
        expect(subject.errors).to be_empty
        expect(result).to be_integer
      end
    end

    context 'with invalid url' do
      let(:url) { 'example invalid url' }
      let(:result) { subject.call }

      before do
        allow(::ParseSite.new(url)).to receive(:call)
        allow(subject).to receive(:get_response)
      end

      it 'analyzed  the site\'s content' do
        expect(result).to be_nil
      end
    end
  end
end
