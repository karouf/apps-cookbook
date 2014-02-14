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

describe file('/etc/php5/fpm/pool.d/pictesfootball.com.conf') do
  it { should be_a_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
  its(:content) { should match /\[pictesfootball.com\]/ }
  its(:content) { should match /listen = \/var\/run\/php5-fpm-\$pool.sock/ }
end

describe file('/var/run/php5-fpm-pictesfootball.com.sock') do
  it { should be_a_socket }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 666 }
end
