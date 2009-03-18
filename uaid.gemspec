# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{uaid}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adam Williams"]
  s.date = %q{2009-03-18}
  s.description = %q{A small library useful to Rack-based Ruby applications for obtaining information about the user agent}
  s.email = %q{adam@thewilliams.ws}
  s.files = ["VERSION.yml", "lib/uaid", "lib/uaid/helper.rb", "lib/uaid/user_agent.rb", "lib/uaid.rb", "spec/helper_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/user_agent_spec.rb"]
  s.homepage = %q{http://github.com/fivepointssolutions/uaid}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A small library useful to Rack-based Ruby applications for obtaining information about the user agent}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
