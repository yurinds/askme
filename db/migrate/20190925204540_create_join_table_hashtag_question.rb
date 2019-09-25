# frozen_string_literal: true

class CreateJoinTableHashtagQuestion < ActiveRecord::Migration[5.2]
  def change
    create_join_table :hashtag, :questions do |t|
      # t.index [:hashtag_id, :question_id]
      # t.index [:question_id, :hashtag_id]
    end
  end
end
