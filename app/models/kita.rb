class Kita < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :adresse

  geocoded_by :geocodierbare_adresse do |obj, results|
    if geo = results.first
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      obj.adresse_normalisiert = geo.address
    end
  end

  after_validation :geocodieren

  scope :geocodiert, where("latitude IS NOT NULL AND longitude IS NOT NULL")
  scope :nicht_geocodiert, where("latitude IS NULL OR longitude IS NULL")
  scope :gefiltert, lambda { |params|
    s = scoped
    # Bounding Box
    if params[:bounds].present? && params[:bounds].is_a?(Hash)
      box = params[:bounds].slice(:sw_lat, :sw_lng, :ne_lat, :ne_lng).values
      s = s.within_bounding_box(box)
    end
    # Alter
    if params[:traeger_art].present?
      s = s.where(traeger_art: params[:traeger_art])
    end
    # Trägerart
    if params[:alter].present?
      params[:alter].each { |alter| s = s.where(arel_table[alter.to_sym].gt(0)) }
    end
    s
  }

  def geocodiert?
    latitude? && longitude?
  end

  def geocodieren!
    geocode
  end

  private

  def geocodieren
    geocode if !Rails.env.test? && (new_record? || adresse_changed? || (adresse? && !geocodiert?))
    true
  end

  def geocodierbare_adresse
    "#{name}, #{adresse}, Bremen, Deutschland"
  end
end
