require 'text_utils'
require 'singleton'
class SpellChecker
  def initialize(options={})
    defaults={classifier: :metaphone, corpus: '/usr/share/dict/words'}
    options = defaults.merge(options)
    @corpus = options[:corpus]
    @classifications= {}
    @classifier= {:metaphone => TextUtils::MetaphoneClassifier,
                  :soundex => TextUtils::SoundexClassifier}[options[:classifier]]
    init!
  end

  def init!
    corpus_stat = File::Stat.new(@corpus)
    cache_stat = File::Stat.new("cache.dump") if File.exists?("cache.dump")
    if(cache_stat and cache_stat.mtime > corpus_stat.mtime)
      @classifications=Marshal.load(File.read("cache.dump"))
    else
      dictionary = File.open(@corpus).read.lines.collect { |line| line.strip.downcase }
      dictionary.each do |word|
        key = @classifier.classify(word)
        @classifications[key] ||= []
        @classifications[key] << word
      end
      File.open('cache.dump','w') do |f| 
        f.write(Marshal.dump(@classifications))
      end
    end
  end

  def suggest(word)
    word=clean(word)
    return [] if word.empty?
    key=@classifier.classify(word)
    matches = @classifications[key]
    return [] unless matches 
    suggestions = matches.collect do |m| 
      { word: m, 
        distance: TextUtils::Levenshtein.distance(word,m) } 
    end
    suggestions.sort! { |x,y| x[:distance] <=> y[:distance] }
    suggestions.reject! { |s| s[:distance] > 4 }
    suggestions 
  end
  def clean(word)
    return "" unless word
    word.strip.downcase.gsub(/[^a-z]/,'')
  end
end
