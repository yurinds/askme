# frozen_string_literal: true

require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions, dependent: :destroy

  before_validation :username_to_downcase

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :username, length: { maximum: 40 }

  validates :username, format: { with: /\A[a-zA-Z\d_]+\Z/,
                                 message: 'can contain only latin letters, numbers, and the sign "_"' }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-zа-я0-9]+\.)+[a-zа-я]{2,})\z/i,
                              message: 'is not an email' }

  attr_accessor :password

  validates :password, presence: true, on: :create
  validates :password, confirmation: true

  before_save :encrypt_password

  def username_to_downcase
    return nil if username.nil?

    username.downcase!
  end

  def encrypt_password
    if password.present?
      # Создаем т.н. «соль» — случайная строка, усложняющая задачу хакерам по
      # взлому пароля, даже если у них окажется наша БД.
      # У каждого юзера своя «соль», это значит, что если подобрать перебором пароль
      # одного юзера, нельзя разгадать, по какому принципу
      # зашифрованы пароли остальных пользователей
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # Создаем хэш пароля — длинная уникальная строка, из которой невозможно
      # восстановить исходный пароль. Однако, если правильный пароль у нас есть,
      # мы легко можем получить такую же строку и сравнить её с той, что в базе.
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )

      # Оба поля попадут в базу при сохранении (save).
    end
  end

  # Служебный метод, преобразующий бинарную строку в шестнадцатиричный формат,
  # для удобства хранения.
  def self.hash_to_string(password_hash)
    password_hash.unpack1('H*')
  end

  # Основной метод для аутентификации юзера (логина). Проверяет email и пароль,
  # если пользователь с такой комбинацией есть в базе, возвращает этого
  # пользователя. Если нет — возвращает nil.
  def self.authenticate(email, password)
    # Сперва находим кандидата по email
    user = find_by(email: email)

    # Если пользователь не найден, возвращает nil
    return nil unless user.present?

    # Формируем хэш пароля из того, что передали в метод
    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    # Обратите внимание: сравнивается password_hash, а оригинальный пароль так
    # никогда и не сохраняется нигде. Если пароли совпали, возвращаем
    # пользователя.
    return user if user.password_hash == hashed_password

    # Иначе, возвращаем nil
    nil
  end
end
