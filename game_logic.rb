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

def generate_random_word()
	random_word = RandomWordGenerator.word
	random_word
end

def generate_number_of_blank_spaces(word)
	# takes in a string, outputs an integer
	number_of_blanks = word.length
	number_of_blanks
end

def check_if_guess_is_correct(word, guess)
	# takes in a string (word) and another string which is a single letter (guess)
	# outputs a boolean
	word = word.downcase
	guess = guess.downcase
	if word.include?(guess)
		true
	else
		false
	end
end

def generate_string_with_blanks(word)
	word_length = word.length
	word = ""
	word_length.times do 
		word = word + "_"
	end
	word 
end







