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
	session[:blank_spaces] = generate_number_of_blank_spaces(session[:human_word])
	session[:chances] = 10
	erb :display_blank_spaces, :locals => {:blank_spaces => session[:blank_spaces]}
end
