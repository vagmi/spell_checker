# Based on description of metaphone on ASpell
# http://aspell.net/metaphone/metaphone-kuhn.txt

module TextUtils
  class MetaphoneClassifier
    def self.build(regexp,value)
      {regexp: regexp, replacement: value}
    end
    def self.metaphone_rules
        rules = []
        rules << build(/([bcdfhjklmnpqrstvwxyz])\1+/, '\1')       
        rules << build(/^ae/, 'e')
        rules << build(/^[gkp]n/, 'n')
        rules << build(/^wr/,'r')
        rules << build(/^x/, 's')
        rules << build(/^wh/,'w')
        rules << build(/mb$/,'m')
        rules << build(/(?!^)sch/, 'sk')
        rules << build(/(?!^)th/, '0')
        rules << build(/t?ch|sh/,'x')
        rules << build(/c(?=ia)/,'x')
        rules << build(/[st](?=i[ao])/,'x')
        rules << build(/s?c(?=[iey])/,'s')
        rules << build(/[cq]/,'k')
        rules << build(/dg(?=[iey])/,'j')
        rules << build(/d/,'t')
        rules << build(/g(?=h[^aeiou])/,'')
        rules << build(/gn(ed)?/,'n')
        rules << build(/([^g]|^)g(?=[iey])/, '\1j')
        rules << build(/g+/,'k')
        rules << build(/ph/,'f')
        rules << build(/([aeiou])h(?=\b|[^aeiou])/,'\1')
        rules << build(/[wy](?![aeiou])/,'')
        rules << build(/z/,'s')
        rules << build(/v/,'f')
        rules << build(/(?!^)[aeiou]+/,'')
    end
    def self.classify(word)
      #get rid of spaces and non charecters
      str = word.strip.downcase.gsub(/[^a-z]/,'')
      metaphone_rules.each do |rule|
        str.gsub!(rule[:regexp],rule[:replacement])
      end
      str
    end
  end
end
