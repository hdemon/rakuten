require "rakuten/version"
require "faraday"
require 'faraday_middleware'
require "pry"

module Rakuten
  SLEEP_SECOND_BETWEEN_REQUEST = 1

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

    def fetchAll(title:, booksGenreId: '001')
      first = fetch(title: title, booksGenreId: booksGenreId, page: 1)
      total_page_count = first.body["pageCount"]

      result = (2..total_page_count).each_with_object([]) do |page_count, memo|
        sleep SLEEP_SECOND_BETWEEN_REQUEST
        response = fetch(title: title, booksGenreId: booksGenreId, page: page_count)
        memo = memo.concat first.body["Items"]
      end

      first.body["Items"].concat result
    end
  end
end
