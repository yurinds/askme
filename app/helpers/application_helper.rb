# frozen_string_literal: true

module ApplicationHelper
  COLORS_FOR_COLORPICKER = [
    ['#d06b64', '#d06b64'],
    ['#f83a22', '#f83a22'],
    ['#fa573c', '#fa573c'],
    ['#ff7537', '#ff7537'],
    ['#ffad46', '#ffad46'],
    ['#42d692', '#42d692'],
    ['#16a765', '#16a765'],
    ['#7bd148', '#7bd148'],
    ['#b3dc6c', '#b3dc6c'],
    ['#fbe983', '#fbe983'],
    ['#fad165', '#fad165'],
    ['#92e1c0', '#92e1c0'],
    ['#9fe1e7', '#9fe1e7'],
    ['#9fc6e7', '#9fc6e7'],
    ['#4986e7', '#4986e7'],
    ['#9a9cff', '#9a9cff'],
    ['#b99aff', '#b99aff'],
    ['#c2c2c2', '#c2c2c2'],
    ['#cabdbf', '#cabdbf'],
    ['#cca6ac', '#cca6ac'],
    ['#f691b2', '#f691b2'],
    ['#cd74e6', '#cd74e6'],
    ['#a47ae2', '#a47ae2']
  ].freeze

  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'swin.png'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def declination(number, krokodil, krokodila, krokodilov)
    # Сначала, проверим входные данные на правильность
    number = 0 if number.nil? || !number.is_a?(Numeric)

    # Так как склонение определяется последней цифрой в числе, вычислим остаток
    # от деления числа number на 10
    remainder = number % 10

    # Вычислим остаток от деления числа number на 100 для обхода ситуаций с числами 111-114
    big_remainder = number % 100

    if (11..14).cover?(big_remainder)
      # 111-114 — родительный падеж и множественное число (111 Кого?/Чего? —
      # крокодилов)
      krokodilov
    else
      case remainder
      when 1
        # Для 1 — именительный падеж (Кто?/Что? — крокодил)
        krokodil
      when (2..4)
        # Для 2-4 — родительный падеж (2 Кого?/Чего? — крокодила)
        krokodila
      else
        # 5-9 или ноль — родительный падеж и множественное число (8 Кого?/Чего? —
        # крокодилов)
        krokodilov
     end
    end
  end
end
