require_relative 'spec_helper'

describe 'apps::pictesfootball' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes the APT recipe' do
    expect(chef_run).to include_recipe('apt')
  end

  it 'installs Nginx web server' do
    expect(chef_run).to install_package('nginx')
  end

  it 'enables Nginx service at boot' do
    expect(chef_run).to enable_service('nginx')
  end

  it 'starts Nginx service' do
    expect(chef_run).to start_service('nginx')
  end

  it 'configures a vhost for pictesfootball.com' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/sites-available/pictesfootball.com')
    expect(chef_run).to create_link('/etc/nginx/sites-enabled/pictesfootball.com').with(to: '/etc/nginx/sites-available/pictesfootball.com')
    expect(chef_run.link('/etc/nginx/sites-enabled/pictesfootball.com')).to notify('service[nginx]').to(:restart)
  end

  it 'installs PHP' do
    expect(chef_run).to install_package('php5')
  end

  it 'installs the Curl extension for PHP' do
    expect(chef_run).to install_package('php5-curl')
    expect(chef_run.package('php5-curl')).to notify('service[php5-fpm]').to(:restart)
  end

  it 'installs PHP-FPM' do
    expect(chef_run).to install_package('php5-fpm')
  end

  it 'enables PHP-FPM service at boot' do
    expect(chef_run).to enable_service('php5-fpm')
  end

  it 'starts PHP-FPM service' do
    expect(chef_run).to start_service('php5-fpm')
  end

  it 'creates PHP-FPM config for pictesfootball.com' do
    expect(chef_run).to create_cookbook_file('/etc/php5/fpm/pool.d/pictesfootball.com.conf')
    expect(chef_run.cookbook_file('/etc/php5/fpm/pool.d/pictesfootball.com.conf')).to notify('service[php5-fpm]').to(:restart)
  end

  it 'includes the git recipe' do
    expect(chef_run).to include_recipe('git')
  end

  it 'creates the deploy user' do
    expect(chef_run).to create_user('deploy').with(group: 'www-data')
  end

  it 'creates the directory to deploy to' do
    expect(chef_run).to create_directory('/var/www/pictesfootball.com').with(owner: 'deploy', group: 'www-data', mode: '770')
  end
end
