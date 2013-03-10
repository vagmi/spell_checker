# A simple and stupid spell checker

A simple spell checker to suggest mostly incorrect but valid English words. 


Run `./correct.rb` launch spell checker. It reads words from STDIN and prints what it thinks would be the most appropriate replacement.

## How does it work?

Spell checker loads words from /usr/share/dict/words. It then classifies the words using the metaphone algorithm. It then takes the word to be corrected and matches it with other words that have the same metaphone signature. It then calculates the levenshtein distance between the given word and the matches from the dictionary. 

Since the dictionary does not change, I take the liberty of caching the calculated metaphone signatures and the associated words. This vastly improves the startup of the spell checker.

## How can this be made better?

We could use the norvig's way to construct n-grams from a bigger corpus that would allow us to frequency analysis to given better or more probable words. Since /usr/share/dict/words has only one occurrence, the matches of equal distance are all equally probable. 
