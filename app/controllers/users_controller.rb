# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, except: %i[index create new]

  before_action :authorize_user, except: %i[index new create show]
  before_action :check_color, only: %i[create update]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def edit; end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to root_url, notice: 'Пользователь успешно удалён!'
    else
      render 'edit'
    end
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def check_color
    user_color = params[:user][:background_color]
    available_colors = ApplicationHelper::COLORS_FOR_COLORPICKER.map(&:first)
    params[:user][:background_color] = nil unless available_colors.include?(user_color)
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    # берём объект params, потребуем у него иметь ключ
    # :user, у него с помощью метода permit разрешаем
    # набор инпутов. Ничего лишнего, кроме них, в пользователя не попадёт
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :background_color)
  end
end
