# encoding: utf-8
[Kita].each { |klass| klass.delete_all }

Rake::Task['app:import:kitas'].invoke