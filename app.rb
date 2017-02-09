require 'sinatra'
require_relative "game_logic.rb"

enable :sessions
set :session_secret, 'This is a secret key'

get '/' do
	session[:list_of_guesses] = [] 
	erb :choose_players
end

post '/chooseplayertype' do
	session[:opponent] = params[:opponent]
	if session[:opponent] == "Human"
		erb :choose_word_human
	else
		erb :ai_player_mode
	end
end

post '/aitype' do
	session[:type] = params[:type]
	if session[:type] == "Pick"
		session[:word] = generate_random_word()
		session[:string_with_blanks] = generate_string_with_blanks(session[:word])
		session[:chances] = 10
		erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}
	else
		erb :choose_word_for_ai
	end
end

post '/choosewordhuman' do
	session[:word] = params[:human_word]
	session[:string_with_blanks] = generate_string_with_blanks(session[:word])
	session[:chances] = 10
	erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}
end

post '/choosewordai' do
	session[:word] = params[:ai_word]
	session[:string_with_blanks] = generate_string_with_blanks(session[:word])
	session[:chances] = 10
	session[:ai_list] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
	erb :make_move_ai, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}
end

post '/makeguess' do
	session[:current_guess] = params[:guess]
	if check_if_guess_has_been_used(session[:current_guess], session[:list_of_guesses]) == true || session[:current_guess][/[a-zA-Z]+/]  != session[:current_guess]
		erb :redo_guess, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}
	else 
		session[:list_of_guesses] << session[:current_guess].downcase
		session[:list_of_guesses] = session[:list_of_guesses].sort_by(&:downcase)
		correct_guess = check_if_guess_is_correct(session[:word], session[:current_guess])
		if correct_guess == true
			session[:string_with_blanks] = add_letter_to_correct_blank_space(session[:string_with_blanks], session[:current_guess], session[:word])
			if guesser_wins(session[:string_with_blanks]) == true
				session[:tries] = session[:list_of_guesses].count
				erb :guesser_wins, :locals => {:chances => session[:chances], :tries => session[:tries], :string_with_blanks => session[:string_with_blanks], :list_of_guesses => session[:list_of_guesses]} 
			elsif guesser_loses(session[:chances]) == true
				erb :guesser_loses, :locals => {:word => session[:word], :list_of_guesses => session[:list_of_guesses]}
			else
				erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}	
			end
		elsif correct_guess == false
			session[:chances] = session[:chances] - 1
			if guesser_wins(session[:string_with_blanks]) == true
				session[:tries] = session[:list_of_guesses].count
				erb :guesser_wins, :locals => {:chances => session[:chances], :tries => session[:tries], :string_with_blanks => session[:string_with_blanks], :list_of_guesses => session[:list_of_guesses]} 
			elsif guesser_loses(session[:chances]) == true
				erb :guesser_loses, :locals => {:word => session[:word], :list_of_guesses => session[:list_of_guesses]}
			else
				erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}	
			end
		end
	end 
end

post '/makeguessai' do
	session[:ai_move] = ai_guess(session[:ai_list])
	session[:ai_list].delete(session[:ai_move])
	session[:list_of_guesses] << session[:ai_move]
	session[:list_of_guesses] = session[:list_of_guesses].sort_by(&:downcase)
	correct_guess = check_if_guess_is_correct(session[:word], session[:ai_move])
	if correct_guess == true
		session[:string_with_blanks] = add_letter_to_correct_blank_space(session[:string_with_blanks], session[:ai_move], session[:word])
		if guesser_wins(session[:string_with_blanks]) == true
			session[:tries] = session[:list_of_guesses].count
			erb :guesser_wins, :locals => {:chances => session[:chances], :tries => session[:tries], :string_with_blanks => session[:string_with_blanks], :list_of_guesses => session[:list_of_guesses]} 
		elsif guesser_loses(session[:chances]) == true
			erb :guesser_loses, :locals => {:word => session[:word], :list_of_guesses => session[:list_of_guesses]}
		else
			erb :make_move_ai, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}	
		end
	elsif correct_guess == false
		session[:chances] = session[:chances] - 1
		if guesser_wins(session[:string_with_blanks]) == true
			session[:tries] = session[:list_of_guesses].count
			erb :guesser_wins, :locals => {:chances => session[:chances], :tries => session[:tries], :string_with_blanks => session[:string_with_blanks], :list_of_guesses => session[:list_of_guesses]} 
		elsif guesser_loses(session[:chances]) == true
			erb :guesser_loses, :locals => {:word => session[:word], :list_of_guesses => session[:list_of_guesses]}
		else
			erb :make_move_ai, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}	
		end
	end
end

post '/playagain' do
	redirect '/'
end













