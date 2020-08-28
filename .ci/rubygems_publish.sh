#!/usr/bin/env bash

# Publishes a gem to rubygems.org

set -ev

GEM_VERSION=$(ruby -I ./lib -r croaky/version -e 'puts Croaky::VERSION')
GEM_NAME=$(ruby -e 'gem = eval(File.read("croaky-rspec.gemspec")); puts gem.name')

if gem search "$GEM_NAME" -v "$GEM_VERSION" | grep "$GEM_VERSION"; then
  mkdir -p "$HOME"/.gem
  touch "$HOME"/.gem/credentials
  chmod 0600 "$HOME"/.gem/credentials
  printf "---\n:rubygems_api_key: %s\n" "$GEM_HOST_API_KEY" > "$HOME"/.gem/credentials
  git config --global credential.helper store
  echo "https://${GITHUB_ACCESS_TOKEN}:x-oauth-basic@github.com" > ~/.git-credentials
  git config user.email "sayantam@gmail.com"
  git config user.name "Sayantam Dey"
  bundle exec rake release
fi
