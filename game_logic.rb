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

def check_if_guess_has_been_used(guess, list_of_guesses)
	if list_of_guesses.include?(guess.upcase) || list_of_guesses.include?(guess.downcase)
		true
	else
		false
	end
end

def add_letter_to_correct_blank_space(current_blank_spaces, guess, word)
	word = word.split("")
	word.each_with_index do |letter, index|
		if guess.downcase == letter.downcase
			current_blank_spaces[index] = guess
		end
	end
	current_blank_spaces
end

def guesser_wins(current_blank_spaces)
	current_blank_spaces = current_blank_spaces.split("")
	if current_blank_spaces.include?("_") == false
		true
	else
		false
	end
end

def guesser_loses(chances_left)
	if chances_left == 0
		true
	else
		false
	end
end

def ai_guess(list)
	guess = list.sample
	guess
end















