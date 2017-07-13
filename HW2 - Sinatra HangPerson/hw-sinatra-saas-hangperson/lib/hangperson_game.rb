class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    if /[0-9!@#$%^&*()_]/.match(letter) or letter == nil or letter == ""
      raise ArgumentError
    elsif @guesses.include?(letter) or @wrong_guesses.include?(letter) or /[A-Z]/.match(letter)
      false
    else
      if @word.include?(letter)
        @guesses += letter
      else
        @wrong_guesses += letter
      end
      true
    end
  end
  
  def word_with_guesses
    answer = ''
    @word.each_char do |word|
      if @guesses.index(word) != nil
        answer += word
      else
        answer += '-'
      end
    end
    answer
  end
  
  def check_win_or_lose
    if @word == word_with_guesses
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end
  
end
