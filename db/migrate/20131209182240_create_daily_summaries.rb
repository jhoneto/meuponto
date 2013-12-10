class CreateDailySummaries < ActiveRecord::Migration
  def change
    create_table :daily_summaries do |t|
      t.integer    :user_id, :null => false
      t.string     :description, :null => false
      t.date       :day, :null => false
      t.decimal    :value, :null => false
      t.boolean    :manually, :default => false
      t.timestamps
    end
  end
end
