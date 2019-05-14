source ENV['GEM_SOURCE'] || "https://rubygems.org"

def location_for(place, version = nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [version, { :git => $1, :branch => $2, :require => false}].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false}]
  else
    [place, version, { :require => false}].compact
  end
end

puppetversion = ENV.key?('PUPPET_GEM_VERSION') ? "#{ENV['PUPPET_GEM_VERSION']}" : ['>= 3.3']

group :development, :unit_tests do
  gem 'json',                      :require => false
  gem 'metadata-json-lint', '< 1.2' if RUBY_VERSION < '2.1'
  gem 'puppet_facts',              :require => false
  gem 'puppet-blacksmith',         :require => false
  gem 'puppetlabs_spec_helper',    :require => false
  gem 'rspec-puppet', '>= 2.3.2',  :require => false
  gem 'simplecov',                 :require => false
  gem 'rspec-puppet-facts',        :require => false
  gem 'retriable', '< 3' if RUBY_VERSION < '2'
  gem 'nokogiri', '< 1.7' if RUBY_VERSION < '2.1'
end
group :system_tests do
  gem 'beaker-rspec', '< 6',           *location_for(ENV['BEAKER_RSPEC_VERSION'] || '>= 3.4')
  gem 'beaker',                        *location_for(ENV['BEAKER_VERSION'])
  gem 'public_suffix', '~> 1.4.0',     :require => false
  gem 'serverspec',                    :require => false
  gem 'beaker-puppet_install_helper',  :require => false
  gem 'master_manipulator',            :require => false
  gem 'beaker-hostgenerator',          *location_for(ENV['BEAKER_HOSTGENERATOR_VERSION'])
  gem 'pry',                           *location_for(ENV['BEAKER_HOSTGENERATOR_VERSION'])
end

gem 'facter', *location_for(ENV['FACTER_GEM_VERSION'])
gem 'puppet', puppetversion


if File.exists? "#{__FILE__}.local"
  eval(File.read("#{__FILE__}.local"), binding)
end
