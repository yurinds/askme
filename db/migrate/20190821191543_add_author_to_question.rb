# frozen_string_literal: true

class AddAuthorToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :author_id, :integer
    add_index :questions, :author_id
  end
end
