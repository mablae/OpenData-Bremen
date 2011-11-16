# encoding: UTF-8
FactoryGirl.define do
  factory :kita do
    traeger_name { Faker::Company.name }
    traeger_art "Öffentlicher Träger"
    name { Faker::Company.bs.titlelize }
    adresse { "#{Faker::Address.street_address}, Bremen" }
    telefon { "0421 / #{Faker::PhoneNumber.phone_number}" }
    profil { Faker::Lorem.sentence }
    plaetze_03 10
    plaetze_36 10
    plaetze_6 10
  end
end
