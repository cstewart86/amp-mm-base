source 'https://rubygems.org'


git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Middleman Gems
gem 'middleman', '>= 4.0.0'
gem 'middleman-livereload'
gem 'middleman-sprockets', github: 'middleman/middleman-sprockets'
gem 'nokogiri'

# performance
gem 'middleman-minify-html'
gem 'fastimage'
gem 'tzinfo-data', platforms: [:mswin, :mingw, :jruby]
gem 'wdm', '~> 0.1.0', platforms: [:mswin, :mingw]
