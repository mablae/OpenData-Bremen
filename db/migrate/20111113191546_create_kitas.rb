class CreateKitas < ActiveRecord::Migration
  def change
    create_table :kitas do |t|
      t.string :traeger_name
      t.string :traeger_art
      t.string :name
      t.string :adresse
      t.string :adresse_normalisiert
      t.string :telefon
      t.string :profil
      t.integer :plaetze_03
      t.integer :plaetze_36
      t.integer :plaetze_6
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
