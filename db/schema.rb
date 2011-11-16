# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111116103707) do

  create_table "kitas", :force => true do |t|
    t.integer  "bremen_id"
    t.string   "traeger_name"
    t.string   "traeger_art"
    t.string   "name"
    t.string   "adresse"
    t.string   "adresse_normalisiert"
    t.string   "telefon"
    t.string   "profil"
    t.integer  "plaetze_03"
    t.integer  "plaetze_36"
    t.integer  "plaetze_6"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kitas", ["bremen_id"], :name => "index_kitas_on_bremen_id", :unique => true

end
