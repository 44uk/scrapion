# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scrapion/version"

Gem::Specification.new do |s|
  s.name        = "scrapion"
  s.version     = Scrapion::VERSION
  s.authors     = ["yukku0423"]
  s.email       = ["yukku0423@gmail.com"]
  s.homepage    = "http://44uk.net"
  s.summary     = %q{Web Scraping Base Helper}
  s.description = %q{It is suitable for scraping from EC.}

  s.rubyforge_project = "scrapion"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "mechanize"
  # s.add_runtime_dependency "rest-client"
end
