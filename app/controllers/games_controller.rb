class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @attempt = params[:answer]
    # @result = run_game(attempt, grid)
    def included?(guess, grid)
      guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
    end

    def compute_score(attempt)
      attempt.size * 1.0
    end

    def score_and_message(attempt, grid, time)
      if included?(attempt.upcase, grid)
        if english_word?(attempt)
          score = compute_score(attempt, time)
          [score, "well done"]
        else
          [0, "not an english word"]
        end
      else
        [0, "not in the grid"]
      end
    end

    def english_word?(word)
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
      json = JSON.parse(response.read)
      return json['found']
    end


  end
end

# @answer = params[:answer]
