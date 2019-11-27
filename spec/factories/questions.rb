# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    association :user

    sequence(:text) { |n| "В каком году была космическая одиссея #{n}?" }
    sequence(:answer) { |n| "Неопределено #{n}?" }

    trait :with_hashtags do
      after(:build) do |question|
        question.hashtags << FactoryBot.build_list(:hashtag, 5)
      end
    end
  end
end
