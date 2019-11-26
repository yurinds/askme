# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    sequence(:text) { |n| "В каком году была космическая одиссея #{n}?" }

    sequence(:level) { |n| n % 15 }
  end
end
