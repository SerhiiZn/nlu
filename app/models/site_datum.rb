require 'uri'

# Contains url and parsed data from site
class SiteDatum < ApplicationRecord
  has_many :analizes

  def self.valid_url?(url)
    !URI.parse(url).host.nil?
  rescue URI::InvalidURIError
    false
  end
end
