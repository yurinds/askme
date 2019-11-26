# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user, email: 'qwerty@example.com') }

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

  describe '.authenticate' do
    context 'when email and password is right' do
      it { expect(User.authenticate(user.email, '123456')).to eq user }
    end
    context 'when email or password is wrong' do
      it { expect(User.authenticate(user.email, '23659')).to eq nil }
    end
  end
end
