# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "figaro_#{rand(999)}" }
    username { "figaro_#{rand(999)}" }

    sequence(:email) { |n| "someguy_#{n}@example.com" }

    after(:build) { |u| u.password_confirmation = u.password = '123456' }
  end
end
