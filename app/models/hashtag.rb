# frozen_string_literal: true

class Hashtag < ApplicationRecord
  has_many :hashtag_questions
  has_many :questions, through: :hashtag_questions

  def self.find_hashtags(string)
    return [] if string.nil?

    raw_hashtags = string.scan(/#[[:word:]-]+/)
    raw_hashtags.map!(&:downcase).uniq!

    raw_hashtags.map do |item|
      # запрос в цикле - не хорошо, пока не знаю как исправить
      find_or_create_by(name: item)
    end
  end
end
