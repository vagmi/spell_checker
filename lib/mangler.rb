class Mangler
  def mangle_line(line)
    mangled = line.split(/\s+/).collect { |word| mangle(word) }
    mangled.reject { |w| w.strip.empty? }
  end
  def mangle(word)
    str=""
    word = word.strip.downcase.gsub(/[^a-z]/,'')
    word.split("").each do |c|
      str += replace_vowel(c) if c=~/[aeiou]/
      str += replace_consonant(c) if c=~/[^aeiou]/
    end
    str
  end
  def replace_vowel(c)
    if(rand(3)<1)
      %w(a e i o u).sample
    else
      c
    end
  end
  def replace_consonant(c)
    if(rand(3)<1)
      c*(rand(1)+1)
    else
      c
    end
  end
end
