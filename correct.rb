#!/usr/bin/env ruby
$:.unshift("./lib")
require 'cli'
Signal.trap "SIGINT" do
  puts "Have a nice day."
  exit(0)
end
CLI.new.run
