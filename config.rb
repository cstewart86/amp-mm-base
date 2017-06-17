require "lib/image_helpers"
require "lib/stylesheet_helpers"

ignore 'assets/stylesheets/*'

def output_dir
  return 'build' unless ENV.fetch('WERCKER_OUTPUT_DIR', false)
  "#{ENV['WERCKER_OUTPUT_DIR']}"
end

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :fonts_dir, 'assets/fonts'

set :build_dir, output_dir

# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

page '*', layout: 'application'

activate :sprockets
activate :directory_indexes

helpers ImageHelpers
helpers StylesheetHelpers

config[:canonical_root] = 'https://beardless.io'

configure :development do
  config[:host] = "https://amp.dev"
end

configure :build do
  config[:host] = "https://beardless.io"
  activate :minify_html
  activate :asset_hash, ignore: ['sw.js', 'favicon.ico']
end
