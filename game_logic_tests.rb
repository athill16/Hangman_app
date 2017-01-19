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

	def test_if_guess_has_been_used
		answer = check_if_guess_has_been_used("A", "a, c, d")
		assert_equal(true, answer)
		answer = check_if_guess_has_been_used("A", "x, c, d")
		assert_equal(false, answer)
		answer = check_if_guess_has_been_used("a", "a, c, d")
		assert_equal(true, answer)
	end

	def test_if_letter_is_added_to_blank_space
		blanks = add_letter_to_correct_blank_space("____", "o", "word")
		assert_equal("_o__", blanks)
	end

	def test_if_game_is_over
		over = guesser_wins("word")
		assert_equal(true, over)
		over = guesser_wins("w_rd")
		assert_equal(false, over)
		over = guesser_loses(0)
		assert_equal(true, over)
		over = guesser_loses(1)
		assert_equal(false, over)
	end

	def test_if_list_has_26_elements
		assert_equal(26, generate_list_for_ai().count)
	end

	def test_if_ai_guess_is_one_element_thats_a_string
		move = ai_guess()
		assert_equal(1, move.length)
		assert_equal(String, move.class)
	end

end









