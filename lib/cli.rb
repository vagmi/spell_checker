require 'spell_checker'
require 'readline'
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
    begin
      word=Readline.readline("> ",true)
      unless(word.nil? or word.strip.empty?)
        suggestions=@sc.suggest(word)
        if(suggestions.empty?)
          puts "No Suggestions"
        else
          puts suggestions.first[:word]
        end
      end
    end while(word and not word.strip.empty?)
  end
end
