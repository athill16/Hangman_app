require "minitest/autorun"
require_relative "game_logic.rb"

class TestHangmanGame < Minitest::Test 

	def test_word_generator_works
		word = generate_random_word()
		assert_equal(word.class,String)
	end

	def test_number_of_blanks
		blank_spaces = generate_number_of_blank_spaces("Aaron")
		assert_equal(blank_spaces, 5)
	end

end