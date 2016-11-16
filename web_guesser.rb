require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(0..100)

get '/' do
  guess = params["guess"].to_i
  compare = compare(guess)
  erb :index, :locals => {:guess => guess, :compare => compare}
end

def compare(guess)
  if guess > SECRET_NUMBER + 5
    "WAY too high!"
  elsif guess > SECRET_NUMBER
    "too high!"
  elsif guess < SECRET_NUMBER  - 5
    "WAY too low!"
  elsif guess < SECRET_NUMBER 
    "too low!"
  elsif guess == SECRET_NUMBER
    "right on! You Win! The secret number was #{SECRET_NUMBER }"
  end
end
