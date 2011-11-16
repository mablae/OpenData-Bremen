class AddBremenIdToKitas < ActiveRecord::Migration
  def change
    add_column :kitas, :bremen_id, :integer, after: :id
    add_index :kitas, :bremen_id, unique: true
  end
end
