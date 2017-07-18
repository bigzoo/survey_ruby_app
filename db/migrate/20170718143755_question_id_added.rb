class QuestionIdAdded < ActiveRecord::Migration[5.1]
  def change
    add_column(:answers, :question_id, :int)
  end
end
