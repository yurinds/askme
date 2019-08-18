# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def edit; end

  def show
    # @new_question = Question.new
    # @user = User.new(
    #  name: 'Dmitrii',
    #  username: 'yurinds',
    #  avatar_url: 'https://www.artwall.ru/products/autosticker_1157/image?width=400&fmt=.jpg'
    # )
    # @questions = [
    #  Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
    #  Question.new(text: 'Где живёшь?', created_at: Date.parse('28.03.2016'))
    # ]
  end

  private

  def user_params
    # берём объект params, потребуем у него иметь ключ
    # :user, у него с помощью метода permit разрешаем
    # набор инпутов. Ничего лишнего, кроме них, в пользователя не попадёт
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url)
  end
end
