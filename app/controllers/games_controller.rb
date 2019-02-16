require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def score
    entered_word = params[:answer]
    # use API to check conditions
    url = "https://wagon-dictionary.herokuapp.com/#{entered_word}"
    word_serialized = open(url).read
    @result = JSON.parse(word_serialized)
    @found = if @result['found']
               'valid'
             else
               'invalid'
             end
  end
end
