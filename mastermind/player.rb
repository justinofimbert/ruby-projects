# frozen_string_literal: true

require_relative 'display'

class Player
  attr_reader :role, :is_user, :score

  include Display

  def initialize(role, is_user, score = 0)
    @role = role
    @is_user = is_user
    @score = score
    @last_guess_pair = false
    @possible_guesses = %w[1 2 3 4 5 6 7 8].permutation(4).to_a if role == 'codebreaker' && is_user == false
  end

  def is_user?
    @is_user
  end

  def create_secret_code
    unless is_user?
      secret_code = []
      available_numbers = [1, 2, 3, 4, 5, 6, 7, 8]

      4.times { secret_code.push(available_numbers.delete(available_numbers.sample)) }
      puts secret_code.join
      secret_code.join
    else
      ask_secret_code
      get_valid_code
    end
  end

  def make_guess(guess_number)
    unless is_user?
      return @possible_guesses.first.join unless last_guess_pair

      clean_possible_guesses
      @possible_guesses.first.join

    else
      if guess_number.zero?
        ask_first_guess
      else
        ask_guess
      end
      get_valid_code
    end
  end

  def increase_score
    @score += 1
  end

  private

  def get_valid_code
    loop do
      user_input = gets.chomp.split('')
      return user_input.join if user_input.length == 4 && only_numbers?(user_input) && user_input.all? { |value| value.to_i.between?(1, 8) }

      ask_errorless_code
    end
  end

  def only_numbers?(code)
    Integer code.join("") rescue false
  end

  def clean_possible_guesses(last_guess, last_guess_answer)
    
  end
end
