require 'open-uri'

class GamesController < ApplicationController
  def score
    @word = params[:word]
    @letters = params[:letters].split
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end
end

private
  def included?(word, letters)
  word.chars.all? { |letter| word.count(letter) <= letters.count(letter.capitalize) }
  end

def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end
