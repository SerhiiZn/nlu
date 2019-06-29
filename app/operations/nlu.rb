require 'json'
require 'ibm_watson/natural_language_understanding_v1'

# Communication with Watson and parsing responses
class Nlu
  include IBMWatson

  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def call
    get_data
    configure_watson
    get_response
    save_result
  end

  private

  def get_data
    @data = ::ParseSite.new(url).call
  end

  def configure_watson
    @watson = IBMWatson::NaturalLanguageUnderstandingV1.new(
      version: '2018-11-16',
      iam_apikey: Rails.application.secrets.watson_api_key,
      url: Rails.application.secrets.watson_url
    )
  end

  def get_response
    @response = @watson.analyze(text: @data.content, features: {
      entities: {
        emotion: true,
        sentiment: true,
        limit: 2
      },
      keywords: {
        emotion: true,
        sentiment: true,
        limit: 2
      }
    })
  end

  def save_result
    Analize.create(site_data: @data, result: @response.result)
  end
end
