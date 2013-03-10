require 'spell_checker'
class CLI
  def initialize
    display_banner
    puts 
    puts "Initializing SpellChecker ... "
    @sc=SpellChecker.new
  end
  def display_banner
    puts File.read("./lib/banner.txt")
  end
  def run
    puts "Type in a word after the prompt to get suggestions"
    while(true)
      print "> "
      word=gets
      suggestions=@sc.suggest(word)
      if(suggestions.empty?)
        puts "No Suggestions"
      else
        puts suggestions.first[:word]

        puts suggestions.collect {|w| w[:word]}.join ", "
      end
    end
  end
end
