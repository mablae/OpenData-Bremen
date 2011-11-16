class Kita < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :adresse
end
