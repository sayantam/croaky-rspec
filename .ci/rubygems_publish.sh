#!/usr/bin/env bash

# Publishes a gem to rubygems.org

GEM_VERSION=$(ruby -I ./lib -r croaky/version -e 'puts Croaky::VERSION')

git tag --list | grep "$GEM_VERSION"

if [ $? -ne 0 ]; then
  echo "Build and release new Gem version..."
  mkdir -p "$HOME"/.gem
  touch "$HOME"/.gem/credentials
  chmod 0600 "$HOME"/.gem/credentials
  printf -- "---\n:rubygems_api_key: ${GEM_HOST_API_KEY}\n" > $HOME/.gem/credentials
  git config --global credential.helper store
  echo "https://${GITHUB_ACCESS_TOKEN}:x-oauth-basic@github.com" > ~/.git-credentials
  git checkout master
  git config user.email "sayantam@gmail.com"
  git config user.name "Sayantam Dey"
  bundle exec rake release
fi
