require './spec/spec_helper'
require 'spell_checker'

describe SpellChecker do
  it "should give valid suggestions" do
    spell_checker=SpellChecker.new :classifier=>:soundex
    cases = {"sheeeep"=>"sheep",
             "peepple"=>"people",
             "inSIDE"=>"inside",
             "jjoobbb"=>"job",
             "weke"=>"wake",
             "CUNsperrICY"=>"conspiracy"}
    cases.each do |k,v|
      suggestions=spell_checker.suggest(k)
      suggestion=suggestions.select {|s| s[:word]==v}.first
      suggestion.should_not be_nil
    end
  end
end
