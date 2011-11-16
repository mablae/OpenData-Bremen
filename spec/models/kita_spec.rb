# encoding: UTF-8
require 'spec_helper'

describe Kita do

  describe "Validierung" do

    subject { Kita.new }
    it { should have(1).error_on(:name) }
    it { should have(1).error_on(:adresse) }

  end

end
