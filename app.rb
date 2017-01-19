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
	else
		session[:word] = generate_random_word()
		session[:string_with_blanks] = generate_string_with_blanks(session[:word])
		session[:chances] = 10
		erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}
	end
end

post '/choosewordhuman' do
	session[:word] = params[:human_word]
	session[:string_with_blanks] = generate_string_with_blanks(session[:word])
	session[:chances] = 10
	erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}
end

post '/makeguess' do
	session[:current_guess] = params[:guess]
	if check_if_guess_has_been_used(session[:current_guess], session[:list_of_guesses]) == true
		erb :redo_guess, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}
	else 
		session[:list_of_guesses] << session[:current_guess]
		correct_guess = check_if_guess_is_correct(session[:word], session[:current_guess])
		if correct_guess == true
			session[:string_with_blanks] = add_letter_to_correct_blank_space(session[:string_with_blanks], session[:current_guess], session[:word])
			if guesser_wins(session[:string_with_blanks]) == true
				session[:tries] = session[:list_of_guesses].count
				erb :guesser_wins, :locals => {:tries => session[:tries], :string_with_blanks => session[:string_with_blanks], :list_of_guesses => session[:list_of_guesses]} 
			elsif guesser_loses(session[:chances]) == true
				erb :guesser_loses, :locals => {:word => session[:word], :list_of_guesses => session[:list_of_guesses]}
			else
				erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}	
			end
		elsif correct_guess == false
			session[:chances] = session[:chances] - 1
			if guesser_wins(session[:string_with_blanks]) == true
				session[:tries] = session[:list_of_guesses].count
				erb :guesser_wins, :locals => {:tries => session[:tries], :string_with_blanks => session[:string_with_blanks], :list_of_guesses => session[:list_of_guesses]} 
			elsif guesser_loses(session[:chances]) == true
				erb :guesser_loses, :locals => {:word => session[:word], :list_of_guesses => session[:list_of_guesses]}
			else
				erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances], :list_of_guesses => session[:list_of_guesses]}	
			end
		end
	end 
end

post '/playagain' do
	redirect '/'
end













