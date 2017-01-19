require 'sinatra'
require_relative "game_logic.rb"

enable :sessions

get '/' do
	session[:list_of_guesses] = [] 
	erb :choose_players
end

post '/chooseplayertype' do
	session[:opponent] = params[:opponent]
	if session[:opponent] == "Human"
		erb :choose_word_human
	end
end

post '/choosewordhuman' do
	session[:human_word] = params[:human_word]
	session[:string_with_blanks] = generate_string_with_blanks(session[:human_word])
	session[:chances] = number_of_chances_left(11)
	erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}
end

post '/makeguess' do
	if game_over() == true
		erb :game_over
	end 
	session[:current_guess] = params[:guess]
	if check_if_guess_has_been_used(session[:current_guess], session[:list_of_guesses]) == true
		erb :redo_guess, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}
	else 
		session[:list_of_guesses] << session[:current_guess]
		correct_guess = check_if_guess_is_correct(session[:human_word], session[:current_guess])
		if correct_guess == true
			session[:string_with_blanks] = add_letter_to_correct_blank_space(session[:string_with_blanks], session[:current_guess], session[:human_word])
			erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}
		else
			session[:chances] = session[:chances] - 1
			erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}
		end
	end
end














