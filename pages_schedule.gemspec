# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pages_schedule/version"

Gem::Specification.new do |s|
  s.name        = "pages_schedule"
  s.version     = PagesSchedule::VERSION
  s.authors     = ["Inge Jørgensen"]
  s.email       = ["inge@manualdesign.no"]
  s.homepage    = ""
  s.summary     = %q{Pages Schedule}
  s.description = %q{Pages Schedule}

  s.rubyforge_project = "."

  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rake", "~> 0.9.2"
  s.add_dependency "rails", "~> 3.2.13"
end
