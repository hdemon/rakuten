require "rakuten/version"
require "faraday"
require 'faraday_middleware'

module Rakuten
  class BooksTotal
    def initialize(appId:, format: 'json', verbose: false)
      @appId = appId
      @format = format
      @verbose = verbose

      @connection = Faraday.new(url: 'https://app.rakuten.co.jp') do |faraday|
        faraday.adapter  Faraday.default_adapter
        faraday.response :json, :content_type => /\bjson$/
        faraday.response :logger if @verbose
      end
    end

    def fetch(title:, booksGenreId: '001', page: 1)
      @connection.get do |request|
        request.url '/services/api/BooksBook/Search/20130522'
        request.params['applicationId'] = @appId
        request.params['format'] = @format
        request.params['booksGenreId'] = booksGenreId
        request.params['title'] = title
        request.params['page'] = page
      end
    end
  end
end
