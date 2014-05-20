#!/bin/bash

rbenv install 2.1.1
rbenv global 2.1.1
gem install bundler
rbenv rehash

number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

bundle
