require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
  end

  def score
    word_test = true
    @letters_test = params[:letters].upcase.split("")
    @word = params[:word].upcase.split("")
    @word.each do |w|
      if @letters_test.include?(w)
        @letters_test.delete_at(@letters_test.index(w))
        word_test = true
      else
        word_test = false
      end
      break if word_test == false
    end

    if word_test && english_word(params[:word])
      @message = "Le mot trouvé est bon"
    else
      @message= "Le mot trouvé n'est pas correct"
    end
  end
end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_dictionary = URI.open(url).read
    word = JSON.parse(word_dictionary)
    return word['found']
  end
