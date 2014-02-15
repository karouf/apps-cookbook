require 'spec_helper'

describe package('nginx') do
    it { should be_installed }
end

describe service('nginx') do
    it { should be_enabled   }
      it { should be_running   }
end

describe port(80) do
    it { should be_listening }
end

describe file('/etc/nginx/sites-available/pictesfootball.com') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/nginx/sites-enabled/pictesfootball.com') do
  it { should be_linked_to '/etc/nginx/sites-available/pictesfootball.com' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 777 }
end
