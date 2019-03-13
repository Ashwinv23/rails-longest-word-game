require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def score
    entered_word = params[:answer]
    entered_letters_array = params[:answer].downcase.chars
    original_letters_array = params[:letters].delete(' ').downcase.chars

    if (entered_letters_array - original_letters_array).empty?
      url = "https://wagon-dictionary.herokuapp.com/#{entered_word}"
      word_serialized = open(url).read
      @result = JSON.parse(word_serialized)
      @found = if @result['found']
                 "Congratulations!! #{entered_word} is a valid English word."
               else
                 "Sorry but #{entered_word} doesn't seem to be a valid English word"
               end
    else
      @cant_be_built = "Sorry but #{entered_word} can't be built out of the letters given"
    end
  end
end
