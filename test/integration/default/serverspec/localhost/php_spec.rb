require 'spec_helper'

describe package('php5') do
    it { should be_installed }
end

describe package('php5-fpm') do
    it { should be_installed }
end

describe service('php5-fpm') do
  it { should be_enabled }
  it { should be_running }
end
