require 'rails_helper'

RSpec.describe SiteDatum, type: :model do
  subject { described_class.valid_url?(url) }

  context 'with valid url' do
    let(:url) { 'https://example.com' }
    it { expect(subject).to be true }
  end

  context 'with invalid url' do
    let(:url) { 'example invalid url' }
    it { expect(subject).to be false }
  end
end
