# frozen_string_literal: true

# BEGIN
require 'uri'

class Url
  attr_accessor :query_params

  extend Forwardable
  def_delegators :@uri, :scheme, :host, :port

  include Comparable

  def ==(other)
    (@uri.host == other.host) && (@uri.port == other.port) && (@query_params == other.query_params)
  end

  def initialize(url)
    @url = url
    @uri = URI(url)
    @query_params = @uri.query.nil? ? {} : parse_params(@uri)
  end

  def query_param(key, default = nil)
    @query_params.fetch(key, default)
  end

  private

  def parse_params(uri)
    uri.query.split('&').each_with_object({}) do |param, acc|
      key, value = param.split('=')
      acc[key.to_sym] = value
    end
  end
end
# END
