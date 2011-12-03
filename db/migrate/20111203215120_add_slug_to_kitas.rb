class AddSlugToKitas < ActiveRecord::Migration
  def change
    add_column :kitas, :slug, :string, after: :longitude
    add_index :kitas, :slug, unique: true

    Kita.find_each(&:save)
  end
end
