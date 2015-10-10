source 'https://rubygems.org'

gem 'berkshelf'

group :integration do
  gem 'test-kitchen'
  gem 'kitchen-docker'
end
gem "kitchen-vagrant"

if ENV['CHEF_VERSION'] == 'master'
  gem 'chef', github: 'chef/chef'
else
  gem 'chef', ENV['CHEF_VERSION']
end
