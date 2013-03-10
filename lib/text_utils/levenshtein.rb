module TextUtils
  class Levenshtein
    def self.distance(word1, word2)
      word1,word2=clean(word1),clean(word2)
      if(word1.length>word2.length)
        word1,word2=word2,word1
      end
      len1, len2 = word1.length, word2.length
      return len2 if len1==0
      return len1 if len2==0
      distance = nil
      acc = (0..len2).to_a
      (0...len1).each do |i|
        outer = i + 1
        (0...len2).each do |j|
          substitution = acc[j] + (word1[i]==word2[j] ? 0 : 1)
          addition = acc[j+1]
          deletion = outer + 1
          acc[j]=outer
          distance=outer=[addition,deletion,substitution].min
        end
        acc[len2]=distance
      end
      distance
    end
    def self.clean(word)
      word.strip.downcase.gsub(/[^a-z]/,'')
    end
  end
end
