class GuessANumberBetweenOneAndTenJob < ApplicationJob
  queue_as :default

  class ThatsNotFair < StandardError; end
  class GuessedWrongNumber < StandardError; end

  discard_on ThatsNotFair
  retry_on GuessedWrongNumber, attempts: 8, wait: 1

  def perform(my_number)
    unless my_number.is_a?(Integer) && my_number.between?(1, 10)
      raise ThatsNotFair, "#{my_number} isn't an integer between 1 and 10!"
    end

    guessed_number = rand(1..10)

    if guessed_number == my_number
      Rails.logger.info "I guessed it! It was #{my_number}"
    else
      raise GuessedWrongNumber, "Is it #{guessed_number}? No? Hmm."
    end
  end
end
