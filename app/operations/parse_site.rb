# Tool for parsing site data
class ParseSite
  attr_accessor :url, :errors

  def initialize(url)
    @url = url
    @errors = []
  end

  def call
    check_url
    return unless errors.blank?
    get_text
    get_rank
    create_record
  end

  private

  def get_text
    doc = Nokogiri::HTML(site_body(url))
    doc.css('script', 'style').remove
    doc.xpath('//text()').find_all { |t| t.to_s.strip == '' }.map(&:remove)
    @text = doc.css('div', 'p').map(&:content).join(' ')
               .encode('UTF-8', invalid: :replace, undef: :replace)
  end

  def get_rank
    doc = Nokogiri::XML(site_body("http://data.alexa.com/data?cli=10&dat=s&url=#{url}"))
    @rank = doc.xpath('//REACH').first.get_attribute('RANK')
  end

  def site_body(url)
    Typhoeus.get(url, followlocation: true).body
  end

  def create_record
    data = SiteDatum.where(url: url).first_or_create
    data.update(rank: @rank, content: @text)
    data
  end

  def check_url
    return if SiteDatum.valid_url?(url)
    @errors << 'Please enter valid url'
  end
end
