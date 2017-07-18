class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table(:answers)do |t|
      t.column(:name, :string)
      t.column(:author, :string)
    end
  end
end
