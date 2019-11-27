# frozen_string_literal: true

FactoryBot.define do
  factory :hashtag do
    name { "#hashtag_#{rand(999)}" }

    trait :with_questions do
      after(:build) do |hashtag|
        hashtag.questions = FactoryBot.build_list(:question, 5)
      end
    end
  end
end
