# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.8', '>= 5.2.8.1'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Management ENV variables
gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'

# Authentication
gem 'devise', '~> 4.9', '>= 4.9.3'

# Admin
gem 'trestle', '~> 0.9.8'
gem 'trestle-auth', '~> 0.4.4'
gem 'trestle-tinymce', '~> 0.3.1'

# Internationalize
gem 'rails-i18n', '~> 5.1', '>= 5.1.1'

# Upload file
gem 'carrierwave', '~> 2.2', '>= 2.2.3'
gem 'carrierwave-i18n', '< 3'
gem 'image_processing', '~> 1.12', '>= 1.12.2'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Add a comment summarizing the current schema
  gem 'annotate', '~> 3.2'
  gem 'pry', '~> 0.14.2'
  gem 'pry-byebug', '~> 3.10', '>= 3.10.1'
  gem 'pry-rails', '~> 0.3.9'
  # Prevent N+1 queries
  gem 'bullet', '~> 7.1', '>= 7.1.6'

  # Linting codes
  gem 'rubocop', '~> 1.60', '>= 1.60.2'
  gem 'rubocop-performance', '~> 1.20', '>= 1.20.2'
  gem 'rubocop-rails', '~> 2.23', '>= 2.23.1'

  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'

  # Add support for debugging
  gem 'pry', '~> 0.14.2'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
