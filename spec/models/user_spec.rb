# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create(:user) }

  context 'validations check' do
    it { should have_many(:questions) }

    it { should validate_presence_of :username }
    it { should validate_length_of(:username).is_at_most(40) }
    it { should validate_uniqueness_of(:username).ignoring_case_sensitivity }
    it { should allow_value('ararat1456').for(:username) }

    it { should validate_presence_of :email }
    it { should allow_value('safjhskakjk2142_fs1@sd-jd-iek.ru').for(:email) }

    it { should validate_presence_of(:password).on(:create) }
  end
end
