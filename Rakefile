require 'rubygems'
require 'rake'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s| 
  s.name = "abacus"
  s.version = "0.0.1"
  s.author = "Sandro Paganotti"
  s.email = "sandro.paganotti@gmail.com"
  s.homepage = "http://www.sandropaganotti.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "Abacus is an xdxf parser and semantic toolset for Ruby."
  s.files = FileList["{bin,lib}/**/*"].to_a
  s.require_path = "lib"
  s.test_files = FileList["{test}/**/*test.rb"].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.markdown"]
  s.executables << 'abacus'
  s.add_dependency("nokogiri", ">= 1.3.3")
  s.add_dependency("sqlite3-ruby", ">= 1.2.5")
  s.add_dependency("activerecord", ">= 2.3.5")
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end 
