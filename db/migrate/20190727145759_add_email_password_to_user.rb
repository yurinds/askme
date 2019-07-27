# frozen_string_literal: true

class AddEmailPasswordToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string

    add_column :users, :avatar_url, :string
  end
end
