# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = [
      @user = User.new(
        id: 1,
        name: 'Dmitrii',
        username: 'yurinds',
        avatar_url: 'https://www.artwall.ru/products/autosticker_1157/image?width=400&fmt=.jpg'
      ),
      User.new(id: 2, name: 'Lena', username: 'bunina')
    ]
  end

  def new; end

  def edit; end

  def show
    @new_question = Question.new
    @user = User.new(
      name: 'Dmitrii',
      username: 'yurinds',
      avatar_url: 'https://www.artwall.ru/products/autosticker_1157/image?width=400&fmt=.jpg'
    )
    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016'))
    ]
  end
end
