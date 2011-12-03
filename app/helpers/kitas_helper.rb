# encoding: utf-8
module KitasHelper
  def traeger_arten
     ['öffentlicher Träger',
      'kirchlicher Träger',
      'freier Träger der Wohlfahrtspflege',
      'gemeinütziger Verein',
      'privat-gewerblicher Träger',
      'Elternverein',
      'gemeinnütziger Verein']
  end

  def kitas_title
    app_name = Settings.kitas.name
    content_for(:title).blank? ? app_name : "#{content_for(:title)} - #{app_name}"
  end
end