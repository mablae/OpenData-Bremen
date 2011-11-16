# encoding: UTF-8
require 'importer/base'

module Importer
  class Kitas < Base

    def run
      Rails.logger.silence do
        _log "Kitas werden verarbeitet"
        count = 0
        CSV.parse(file_content, csv_config) do |row|
          kita = Kita.find_or_initialize_by_bremen_id(row['EDV-Nr'])
          is_new = kita.new_record?
          kita.traeger_name = row['TrägerName']
          kita.traeger_art = row['Trägerart']
          kita.name = row['Einrichtung']
          kita.adresse = row['Strasse']
          kita.telefon = row['Telefon']
          kita.profil = row['BesonderesProfil']
          kita.plaetze_03 = row['OktPlätze0<3']
          kita.plaetze_36 = row['OktPlätze3<6']
          kita.plaetze_6 = row['OktPlätze>6']
          # Statusmeldung
          if kita.changed?
            info  = "Kita #{kita.bremen_id} "
            info += is_new ? 'angelegt' : "bearbeitet: #{kita.changed.join(', ')}"
            begin
              kita.save!
            rescue Exception => e
              info += " - FEHLER: #{e.message || kita.errors.full_messages.join(', ')}"
            end
            _log info
          end
          count += 1
        end
        # Status
        _log "#{count} Kitas verarbeitet\n#{'=' * 50}\n"
      end
    end

  end
end