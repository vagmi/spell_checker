#!/usr/bin/env ruby
$:.unshift("./lib")

require 'mangler'
Mangler.new.mangle_line(ARGV.first).each { |word|
  puts word
}
