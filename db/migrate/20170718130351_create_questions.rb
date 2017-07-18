class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table(:questions)do |t|
      t.column(:name, :string)
      t.column(:extras, :string)
    end
  end
end
