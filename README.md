====
Scrapion
====

Web scraping base library.

How to use
====

Make Strategy by extend base class and override methods.

    class HoeStrategy < Scrapion::Strategy
      def sources(page)
        # return Array which contain a uri
        # page is Mechanize::Page
        # example:
        # [
        #   'http://example.com/1',
        #   'http://example.com/2',
        # ]
      end

      def data(page)
        # return Hash which contain a data.
        # page is Mechanize::Page
        # example:
        # {
        #   :title => 'hoehoe',
        #   :topic => 'I'm hungry.',
        # }
      end
    end

Do scraping.

    s = Scrapion::Scraper.new {|s|                                                                                                  
      s.strategy   = HoeStrategy.new
    }

    s.add_list_source "http://example.com/list"
    s.extract_sources

    s.scrape_all do |data|
      # HoeStrategy#data  
    end

