require 'spec_helper'

describe 'kibana' do
  shared_examples 'kibana' do |facts|
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('kibana') }

    it { is_expected.to contain_package('kibana').that_notifies('Service[kibana]').with_ensure('latest') }
    case facts[:osfamily]
    when 'RedHat'
      it do
        is_expected.to contain_yumrepo('kibana').that_comes_before('Package[kibana]').with({
          :gpgkey  => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
        })
      end

    when 'Debian', 'Ubuntu'
      it do
        is_expected.to contain_apt__source('kibana').that_comes_before('Package[kibana]').with({
          :release  => 'stable',
          :repos    => 'main',
          :key      => {
            'source' => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
            'id'     => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
          },
        })
      end

      it do
        is_expected.to contain_apt__pin('kibana').that_comes_before('Package[kibana]').with({
          :packages => 'kibana',
          :priority => 700,
        })
      end
    end

    it do
      is_expected.to contain_file('kibana.yml').that_notifies('Service[kibana]').with({
        :owner => 'root',
        :group => 'root',
        :mode  => '0644',
      })
    end

    it do
      is_expected.to contain_service('kibana').with({
        :ensure => 'running',
        :enable => true,
      })
    end
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      context 'with package_repo_version=4.5' do
        let(:facts) { facts }
        let(:params) { { :package_repo_version => '4.5' } }

        it_behaves_like 'kibana', facts

        case facts[:osfamily]
        when 'RedHat'
          it { is_expected.to contain_yumrepo('kibana').with_baseurl('https://artifacts.elastic.co/kibana/4.5/yum') }
        when 'Debian', 'Ubuntu'
          it { is_expected.to contain_apt__source('kibana').with_location('https://artifacts.elastic.co/kibana/4.5/debian') }
          it { is_expected.to contain_apt__pin('kibana').with_version('4.5.*') }
        end

        it { is_expected.to contain_file('kibana.yml').with_path('/opt/kibana/config/kibana.yml') }
      end

      context 'with package_repo_version=5.1' do
        let(:facts) { facts }
        let(:params) { { :package_repo_version => '5.1' } }

        it_behaves_like 'kibana', facts

        case facts[:osfamily]
        when 'RedHat'
          it { is_expected.to contain_yumrepo('kibana').with_baseurl('https://artifacts.elastic.co/packages/5.x/yum') }
        when 'Debian', 'Ubuntu'
          it { is_expected.to contain_apt__source('kibana').with_location('https://artifacts.elastic.co/packages/5.x/apt') }
          it { is_expected.to contain_apt__pin('kibana').with_version('5.1.*') }
        end

        it { is_expected.to contain_file('kibana.yml').with_path('/etc/kibana/kibana.yml') }
      end

      context 'with manage_repo=false' do
        let(:facts) { facts }
        let(:params) { { :manage_repo => false } }

        case facts[:osfamily]
        when 'RedHat'
          it { is_expected.not_to contain_yumrepo('kibana') }
        when 'Debian', 'Ubuntu'
          it { is_expected.not_to contain_apt__source('kibana') }
        end
      end

      context 'with custom service parameters' do
        let(:facts) { facts }
        let(:params) do
          {
            :package_repo_version => '5.1',
            :service_ensure       => 'stopped',
            :service_enable       => false,
            :service_provider     => 'provider',
          }
        end

        it do
          is_expected.to contain_service('kibana').with({
            :ensure   => 'stopped',
            :enable   => false,
            :provider => 'provider',
          })
        end
      end
    end
  end
end
