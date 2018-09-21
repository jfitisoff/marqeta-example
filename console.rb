#!/usr/bin/env ruby

require "pry"
require "./spec/spec_helper"

api = MarqetaCore.new(
  CREDS["base_url"],
  CREDS["app_token"],
  CREDS["access_token"]
)

puts "Pry session started.\n"
puts "API object created (variable name is 'api')"
binding.pry
