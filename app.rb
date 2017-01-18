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

