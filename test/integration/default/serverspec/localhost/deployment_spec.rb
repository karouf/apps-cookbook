require 'spec_helper'

describe user('deploy') do
  it { should exist }
  it { should belong_to_group 'www-data' }
end

describe file('/var/www/pictesfootball.com') do
  it { should be_a_directory }
  it { should be_owned_by 'deploy' }
  it { should be_grouped_into 'www-data' }
  it { should be_mode 770 }
end

describe file('/var/log/pictesfootball.com') do
  it { should be_a_directory }
  it { should be_owned_by 'deploy' }
  it { should be_grouped_into 'www-data' }
  it { should be_mode 775 }
end

describe file('/var/cache/pictesfootball.com') do
  it { should be_a_directory }
  it { should be_owned_by 'deploy' }
  it { should be_grouped_into 'www-data' }
  it { should be_mode 775 }
end
