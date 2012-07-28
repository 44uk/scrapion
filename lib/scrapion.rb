$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'mechanize'

require "scrapion/version"
require "scrapion/ext/object"
require "scrapion/strategy"

module Scrapion
  class Scraper
    attr_reader :sources, :list_sources, :strategy
    attr_accessor :delay_sec, :user_agent

    def initialize
      yield self if block_given?
    end

    def strategy=(s)
      @strategy = s if s.is_a?(Scrapion::Strategy)
      self
    end

    def add_list_source(uri)
      if uri.instance_of?(Array)
        uri.each do |a_uri|
          self.add_source(a_uri)
        end
      elsif uri =~ %r!^https?://! # allow only http/https protocols
        @list_sources ||= []
        @list_sources << uri
      end
      self
    end

    def add_source(uri)
      if uri.instance_of?(Array)
        uri.each do |a_uri|
          self.add_source(a_uri)
        end
      elsif uri =~ %r!^https?://! # allow only http/https protocols
        @sources ||= []
        @sources << uri
      end
      self
    end

    def clear_sources!
      @sources = []
      @list_sources = []
      self
    end

    def extract_sources
      raise "You must be set @list_sources." if @list_sources.nil?
      raise "No Strategy" if @strategy.nil?

      @agent ||= Mechanize.new {|a|
        a.user_agent_alias = @user_agent || Mechanize::AGENT_ALIASES.keys.sample
      }

      @list_sources.uniq!
      @list_sources.each do |list_source|
        page = @agent.get(list_source)
        self.add_source(
          @strategy.sources(page)
        )
      end
      self
    end

    def scrape(uri)
      @agent ||= Mechanize.new {|a|
        a.user_agent_alias = @user_agent || Mechanize::AGENT_ALIASES.keys.sample
      }

      page = @agent.get(uri)
      data = @strategy.data(page)
    end

    def scrape_all
      @sources.uniq!
      @sources.map do |source|
        sleep @delay_sec || 1
        source = self.scrape(source)
        if block_given?
          yield source
        end
        source
      end
    end
  end
end
