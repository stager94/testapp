class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :message
      t.boolean :in_process, default: false

      t.timestamps null: false
    end
  end
end
