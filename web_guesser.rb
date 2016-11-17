require 'sinatra'
require 'sinatra/reloader'
require 'pry'

SECRET_NUMBER = rand(0..100)

get '/' do
  guess = params["guess"].to_i
  if params["cheat"] == "true"
    cheat = cheater_mode(guess)
  else
    cheat = ""
  end
  compare = compare(guess)
  color = get_color(guess)
  erb :index, :locals => {:guess => guess,
                          :compare => compare,
                          :color => color,
                          :cheat => cheat}
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

  def get_color(guess)
    factor = (guess - SECRET_NUMBER.to_f)/(100 - SECRET_NUMBER.to_f)
    factor_prime = (SECRET_NUMBER.to_f - guess)/SECRET_NUMBER.to_f
    if guess > SECRET_NUMBER
      red = (225 - (185*factor)).to_i
      green = ((57 * factor) + 79).to_i
      blue = ((176 * factor) + 79).to_i
      "rgba(#{red},#{green},#{blue},1)"
    elsif guess < SECRET_NUMBER
      red = (225 - (185*factor_prime)).to_i
      green = ((57 * factor_prime) + 79).to_i
      blue = ((176 * factor_prime) + 79).to_i
      "rgba(#{red},#{green},#{blue},1)"
    elsif guess == SECRET_NUMBER
      "rgba(255,79,79,1)"
    end
  end

  def cheater_mode(guess)
    "psst...the secret number is #{SECRET_NUMBER}"
  end
