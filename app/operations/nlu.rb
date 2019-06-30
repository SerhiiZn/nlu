require 'json'
require 'ibm_watson/natural_language_understanding_v1'

# Communication with Watson and parsing responses
class Nlu
  include IBMWatson

  attr_accessor :url, :errors

  def initialize(url)
    @url = url
    @errors = []
  end

  def call
    get_data
    return unless errors.blank?
    configure_watson
    get_response
    save_result
  end

  private

  def get_data
    operation = ::ParseSite.new(url)
    @data = operation.call
    @errors = operation.errors
  end

  def configure_watson
    @watson = IBMWatson::NaturalLanguageUnderstandingV1.new(
      version: '2018-11-16',
      iam_apikey: Rails.application.secrets.watson_api_key,
      url: Rails.application.secrets.watson_url
    )
  end

  def get_response
    return @response = '' if @data.content.blank?
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
    }).result
  rescue IBMCloudSdkCore::ApiException => e
    @errors << e.to_s
  end

  def save_result
    return unless errors.blank?
    Analize.create(site_data: @data, result: @response).id
  end
end
