# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'validations check' do
    it { should belong_to(:user) }
    it { should belong_to(:author).class_name('User').optional }

    it { should have_many(:hashtag_questions) }
    it { should have_many(:hashtags) .through(:hashtag_questions).dependent(:destroy) }

    it { should validate_presence_of :text }
    it { should validate_length_of(:text).is_at_most(255) }
  end

  describe '#find_or_create_hashtags' do
    let(:first_question) { FactoryBot.create(:question, text: '#hashtag! #has_h-tag.', answer: '#ex-ample') }
    let(:second_question) { FactoryBot.create(:question) }

    context 'when the hashtag is indicated in the question and in the answer' do
      it { expect(first_question.hashtags.map(&:name)).to eq %w[#hashtag #has_h-tag #ex-ample] }
    end

    context 'when the hashtag is not indicated in the question and in the answer' do
      it { expect(second_question.hashtags.map(&:name)).to eq [] }
    end
  end
end
