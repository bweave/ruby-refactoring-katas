# frozen_string_literal: true

# TODO: Gemfile.lock is pinned to `BUNDLED WITH 2.5.22` to match the bundler
# that ships with the Nix Ruby in devbox. If we let `bundle install` run from
# a system Ruby with a newer bundler, BUNDLED WITH will bump and a duplicate
# bundler will be installed in vendor/bundle, reintroducing the constant
# redefinition warnings filtered by bin/_filter_noise. Re-pin to the version
# returned by `devbox run -- gem list bundler` whenever it drifts.

source "https://rubygems.org"

gem "debug"
gem "minitest", "~> 5.25"
gem "rake", "~> 13.0"
gem "rerun", "~> 0.14"
gem "rubocop-rails-omakase", require: false
gem "syntax_tree", require: false
