require 'spec_helper'

describe 'kibana' do

  context 'with defaults for all parameters' do
    let :facts do
      {
         :osfamily => 'RedHat'
      }
    end
    it { is_expected.to contain_class('kibana') }
  end

  context 'installs via package' do
    let :facts do
      {
         :osfamily => 'RedHat'
      }
    end
    let :params do
      {
        :version             => 'latest',
        :service_ensure      => true,
        :service_enable      => true,
        :config		     => {
          'server.port'           => 5601,
          'server.host'           => '0.0.0.0',
          'elasticsearch.url'     => 'http://localhost:9200'
        }
      }
    end
    it { is_expected.to contain_package('kibana') }
    it { is_expected.to contain_file('kibana-config-file').with_path('/opt/kibana/config/kibana.yml') }
    it { is_expected.to contain_service('kibana').with_ensure('true').with_enable('true') }
  end

  context 'with manage_repo unspecified' do
    let :facts do
      {
         :osfamily => 'RedHat'
      }
    end
    let :params do
      {
        :package_repo_version => '4.5',
      }
    end
    it { is_expected.to contain_yumrepo('kibana-4.5') }
  end

  context 'with manage_repo set to false' do
    let :facts do
      {
         :osfamily => 'RedHat'
      }
    end
    let :params do
      {
        :manage_repo          => false,
        :package_repo_version => '4.5',
      }
    end
    it { is_expected.to_not contain_yumrepo('kibana-4.5') }
  end
end
