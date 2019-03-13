require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def score
    @entered_word = params[:answer]
    @entered_letters_array = params[:answer].downcase.chars
    @original_letters_array = params[:letters].delete(' ').downcase.chars
    @english_word = english_word?(@entered_word)
    @included = included?(@entered_letters_array, @original_letters_array)
  end

  private

  def included?(entered_letters_array, original_letters_array)
    (entered_letters_array - original_letters_array).empty?
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
