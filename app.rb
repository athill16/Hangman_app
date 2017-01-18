require 'sinatra'
require_relative "game_logic.rb"

enable :sessions

get '/' do 
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
	session[:chances] = 10
	erb :display_blank_spaces, :locals => {:string_with_blanks => session[:string_with_blanks]}
end
