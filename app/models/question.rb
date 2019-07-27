# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user

  validates :text, presence: true
end
