require 'sinatra'
require_relative "game_logic.rb"

enable :sessions

get '/' do 
	erb :choose_players
end



