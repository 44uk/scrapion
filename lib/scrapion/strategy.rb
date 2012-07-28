module Scrapion
  class Strategy
    attr_writer :cache

    def initialize
      yield self if block_given?
    end

    # it must return Array
    def sources(page)
      raise "You must impliment this method by extends."
    end

    # it must return Hash
    def data(page)
      raise "You must impliment this method by extends."
    end

    def cache?
      @cache ||= false
    end
  end
end
