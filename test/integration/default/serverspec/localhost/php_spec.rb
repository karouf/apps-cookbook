require 'spec_helper'

describe package('php5') do
    it { should be_installed }
end
