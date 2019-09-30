# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtag_questions
  has_many :hashtags, through: :hashtag_questions, dependent: :destroy

  validates :text, presence: true, length: { maximum: 255 }

  after_save :find_or_create_hashtags

  def find_or_create_hashtags
    hashtags = Hashtag.find_hashtags(text) | Hashtag.find_hashtags(answer)
    self.hashtags = hashtags
  end
end
