class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.time :date
      t.references :user, index: true, foreign_key: true
      t.string :sha
      t.string :message

      t.timestamps null: false
    end
  end
end
