require './spec/spec_helper'
require 'text_utils'
require 'yaml'
describe "TextUtils::MetaphoneClassifier" do
  it "should give valid metaphone classifications" do
    metaphone_strings = {"anastha"=>"ans0", 
                         "davis-carter"=>"tfskrtr", 
                         "escarmant"=>"eskrmnt", 
                         "mccall"=>"mkl", 
                         "mccrorey"=>"mkrr", 
                         "merseal"=>"mrsl", 
                         "pieurissaint"=>"prsnt", 
                         "rotman"=>"rtmn", 
                         "schevel"=>"sxfl", 
                         "schrom"=>"sxrm", 
                         "seal"=>"sl", 
                         "sparr"=>"spr", 
                         "starleper"=>"strlpr", 
                         "thrash"=>"thrx"}
    metaphone_strings.each do |key,value|
      TextUtils::MetaphoneClassifier.classify(key).should==value
    end
  end
end

describe "TextUtils::SoundexClassifer" do
  it "should give valid soundex classifications" do
    soundex_strings={"Euler"=>"e460",
                     "Ellery"=>"e460",
                     "Gauss"=>"g200",
                     "Ghosh"=>"g200",
                     "Hilbert"=>"h416",
                     "Heilbronn"=>"h416",
                     "Knuth"=>"k530",
                     "Kant"=>"k530",
                     "Lloyd"=>"l300",
                     "Ladd"=>"l300",
                     "Lukasiewicz"=>"l222",
                     "Lissajous"=>"l222"}
    soundex_strings.each do |key,value|
      TextUtils::SoundexClassifier.classify(key).should==value
    end

  end
end

describe "TextUtils::Levenshtein" do
  it "should give a valid levenshtein distances for words" do
    TextUtils::Levenshtein.distance("kitten","sitting").should==3
    TextUtils::Levenshtein.distance("test","rest").should==1
    TextUtils::Levenshtein.distance("boneym","money").should==2
    TextUtils::Levenshtein.distance("","money").should==5
  end
end
