class AddWorkloadToUser < ActiveRecord::Migration
  def change
    add_column :users, :workload, :integer
  end
end
