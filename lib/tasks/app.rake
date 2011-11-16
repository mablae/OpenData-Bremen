# encoding: utf-8

namespace :app do

  namespace :backup do

    desc "Dump der MySQL-Datenbank"
    task :db => :environment do
      conf = ActiveRecord::Base.configurations[Rails.env]
      root_dir  = "#{Rails.root}/tmp/backup"
      timestamp = Time.now.strftime('%Y-%m-%d-%H%M%S')
      file_name = "holywood-#{Rails.env}-#{timestamp}.sql"
      file_path = "#{root_dir}/#{file_name}"
      cmd_line  = "mkdir -p #{root_dir}"
      cmd_line += " && mysqldump --add-drop-table"
      cmd_line += " -h #{conf["host"]}" if conf["host"].present?
      cmd_line += " -u #{conf["username"]}"
      cmd_line += " -p#{conf["password"]}" if conf["password"].present?
      cmd_line += " #{conf["database"]} > #{file_path}"
      cmd_line += " && gzip #{file_path}"
      system(cmd_line)
    end

  end

  namespace :import do

    desc "Import der Kita-Daten"
    task :kitas => :environment do
      require 'importer/kitas'
      importer = Importer::Kitas.new("#{Rails.root}/data/opendata_kita.csv")
      importer.run
    end

  end

  namespace :geocode do

    desc "Geokodieren der Kita-Daten"
    task :kitas => :environment do
      Kita.nicht_geocodiert.each do |kita|
        kita.geocodieren!
        kita.save! if kita.geocodiert?
      end
    end

  end

end
