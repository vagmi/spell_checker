# Based on http://en.wikipedia.org/wiki/Soundex
module TextUtils
  class SoundexClassifier
    def self.classify(word)
      return nil if word.empty?
      word = word.strip.downcase
      last_code = soundex_val(word[0,1])
      soundex = word[0,1]
      (1...(word.size)).each do |index|
        return soundex if soundex.size == 4
        code = soundex_val(word[index,1])
        if code == "0" then
          last_code = nil
        elsif code == nil then
          last_code = nil
        elsif code != last_code then
          soundex += code
          last_code = code
        end
      end 
      soundex + "000"[0,4-soundex.size]
    end
    def self.soundex_val(char)
      rules = [ /[aeiouhwy]/,
                /[bpfv]/,
                /[cgjkqsxz]/,
                /[dt]/,
                /[l]/,
                /[mn]/,
                /[r]/ ]
      rules.each_with_index { |rule, index|
        return index.to_s if rule=~char
      }
      nil
    end
  end
end
