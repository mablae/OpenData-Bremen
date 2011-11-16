# encoding: UTF-8
require 'csv'

module Importer
  class Base

    attr_accessor :log

    def initialize(file_path)
      @file_path = file_path
      @log = ""
    end

    def csv_config
      { :col_sep => ";",
        :quote_char => '"',
        :headers => true,
        :skip_blanks => true }
    end

    def run
    end

    def file_content
      @file_content ||= read_file_content
    end

    protected

    def read_file_content
      boms = {
        'UTF-8' => "\xEF\xBB\xBF",
        'UTF-32BE' => "\x00\x00\xFE\xFF",
        'UTF-32LE' => "\xFF\xFE\x00\x00",
        'UTF-16BE' => "\xFE\xFF",
        'UTF-16LE' => "\xFF\xFE" }
      encoding = Encoding.default_external
      content = IO.read(@file_path, {mode: 'rb'})
      boms.each do |encoding_name, bom|
        bom.force_encoding(content.encoding)
        if content.start_with?(bom)
          content.slice!(0..bom.length-1)
          encoding = Encoding.find(encoding_name)
          break
        end
      end
      content.force_encoding(encoding)
    end

    def convert_string(str)
      return nil if str.blank?
      str.gsub!(/<\/?[^>]*>/, '')
      str
    end

    def _log(msg)
      message = "[#{Time.now}] #{msg}\n"
      puts message unless Rails.env.test?
      @log += message
    end

  end
end