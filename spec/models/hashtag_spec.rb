# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hashtag, type: :model do
  context 'associations check' do
    it { should have_many(:hashtag_questions) }
    it { should have_many(:questions) .through(:hashtag_questions) }
  end

  describe '.find_hashtags' do
    context 'when there is a hashtag in the line' do
      it 'creates hashtags array' do
        test_string = 'It #w_a-s! a #beautiful #day!'
        hashtags = Hashtag.find_hashtags(test_string).map(&:name)

        expect(hashtags).to eq %w[#w_a-s #beautiful #day]
      end
    end
    context 'when there is no hashtag in the line' do
      it 'creates empty array' do
        test_string = 'It was a beautiful day!'
        hashtags = Hashtag.find_hashtags(test_string).map(&:name)

        expect(hashtags).to eq []
      end
    end
  end
end
