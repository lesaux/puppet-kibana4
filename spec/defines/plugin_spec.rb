require 'spec_helper'

describe 'kibana::plugin' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      let(:pre_condition) { "class { 'kibana': package_repo_version => '#{package_repo_version}' }" }
      let(:title) { 'x-pack' }

      context 'with package_repo_version=4.5' do
        let(:package_repo_version) { '4.5' }

        context 'with ensure=present' do
          let(:params) { { :ensure => 'present' } }

          it do
            is_expected.to contain_exec('install_kibana_plugin_x-pack').that_requires('Class[kibana::install]').that_notifies('Service[kibana]').with({
              :command => '/opt/kibana/bin/kibana-plugin install --quiet --plugin-dir /opt/kibana/plugins x-pack',
              :unless  => "/opt/kibana/bin/kibana-plugin list --plugin-dir /opt/kibana/plugins | grep --fixed-strings --quiet 'x-pack'",
            })
          end
        end

        context 'with ensure=absent' do
          let(:params) { { :ensure => 'absent' } }

          it do
            is_expected.to contain_exec('remove_kibana_plugin_x-pack').that_requires('Class[kibana::install]').that_notifies('Service[kibana]').with({
              :command => '/opt/kibana/bin/kibana-plugin remove --quiet --plugin-dir /opt/kibana/plugins x-pack',
              :onlyif  => "/opt/kibana/bin/kibana-plugin list --plugin-dir /opt/kibana/plugins | grep --fixed-strings --quiet 'x-pack'",
            })
          end
        end
      end

      context 'with package_repo_version=5.1' do
        let(:package_repo_version) { '5.1' }

        context 'with ensure=present' do
          let(:params) { { :ensure => 'present' } }

          it do
            is_expected.to contain_exec('install_kibana_plugin_x-pack').that_requires('Class[kibana::install]').that_notifies('Service[kibana]').with({
              :command => '/usr/share/kibana/bin/kibana-plugin install --quiet --plugin-dir /usr/share/kibana/plugins x-pack',
              :unless  => "/usr/share/kibana/bin/kibana-plugin list --plugin-dir /usr/share/kibana/plugins | grep --fixed-strings --quiet 'x-pack'",
            })
          end
        end

        context 'with ensure=absent' do
          let(:params) { { :ensure => 'absent' } }

          it do
            is_expected.to contain_exec('remove_kibana_plugin_x-pack').that_requires('Class[kibana::install]').that_notifies('Service[kibana]').with({
              :command => '/usr/share/kibana/bin/kibana-plugin remove --quiet --plugin-dir /usr/share/kibana/plugins x-pack',
              :onlyif  => "/usr/share/kibana/bin/kibana-plugin list --plugin-dir /usr/share/kibana/plugins | grep --fixed-strings --quiet 'x-pack'",
            })
          end
        end
      end
    end
  end
end
