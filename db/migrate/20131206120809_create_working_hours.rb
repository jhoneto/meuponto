class CreateWorkingHours < ActiveRecord::Migration
  def change
    create_table :working_hours do |t|
      t.integer     :user_id, :null => false
      t.date        :day, :null => false
      t.time        :record, :null => false
      t.timestamps
    end
  end
end
