require "minitest/autorun"
require_relative "game_logic.rb"

class TestHangmanGame < Minitest::Test 

	def test_word_generator_works
		word = generate_random_word(8)
		assert_equal(word.length,8)
	end

end