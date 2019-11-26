# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    association :user

    sequence(:text) { |n| "В каком году была космическая одиссея #{n}?" }
    sequence(:answer) { |n| "Неопределено #{n}?" }
  end
end
