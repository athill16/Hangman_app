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
	erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks], :chances => session[:chances]}
end

post '/makeguess' do 
	session[:current_guess] = params[:guess]
end