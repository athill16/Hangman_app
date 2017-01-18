require "minitest/autorun"
require_relative "game_logic.rb"

class TestHangmanGame < Minitest::Test 

	def test_files_work
		answer = test(2)
		assert_equal(answer,4)
	end

end