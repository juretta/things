# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{things}
  s.version = "0.1.0"
  s.platform = %q{x86-darwin-9}

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stefan Saasen"]
  s.date = %q{2009-06-12}
  s.default_executable = %q{things}
  s.email = %q{s@juretta.com}
  s.executables = ["things"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/things",
     "lib/things.rb",
     "test/test_helper.rb",
     "test/things_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/juretta/things}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{things}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Command line access for the Things task management application (Mac).}
  s.test_files = [
    "test/test_helper.rb",
     "test/things_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
