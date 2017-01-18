require "minitest/autorun"
require_relative "game_logic.rb"

class TestHangmanGame < Minitest::Test 

	def test_word_generator_works
		word = generate_random_word()
		assert_equal(String, word.class)
	end

	def test_number_of_blanks
		blank_spaces = generate_number_of_blank_spaces("Aaron")
		assert_equal(5, blank_spaces)
	end

	def test_if_guess_is_correct
		answer = check_if_guess_is_correct("Aaron", "A")
		assert_equal(true, answer)
		answer = check_if_guess_is_correct("Aaron", "R")
		assert_equal(true, answer)
		answer = check_if_guess_is_correct("Aaron", "x")
		assert_equal(false, answer)
	end

	def test_string_with_blanks
		word = generate_string_with_blanks("Aaron")
		assert_equal("_____", word)
	end
	
end