# choose play mode
# generate word if against AI
# store word in memory (global variable?)
# generate blanks based on word that is chosen
# let player enter guess and submit it
# accept that guess, list all past guesses
# correct guess? then add that letter to it's corresponding blank
# with incorrect guess, increment how many choices they have left
# game won? blanks have been filled
# game won? ran out of guesses
# game loop
# visuals

# gem 'random-word-generator', '~> 0.0.1'
require 'random_word_generator'

def generate_random_word(x)
	# random_word = RandomWordGenerator.word
	random_word = RandomWordGenerator.of_length(x)
	random_word
end
