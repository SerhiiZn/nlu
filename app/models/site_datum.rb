require 'uri'

# Contains url and parsed data from site
class SiteDatum < ApplicationRecord
  has_many :analizes, foreign_key: 'site_data_id'

  def self.valid_url?(url)
    !URI.parse(prepended_url(url)).host.nil?
  rescue URI::InvalidURIError
    false
  end

  def self.prepended_url(url)
    url.start_with?('https', 'https') ? url : "https://#{url}"
  end
end
