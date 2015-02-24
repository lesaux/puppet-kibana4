require 'spec_helper'
describe 'kibana4' do

  context 'with defaults for all parameters' do
    it { should contain_class('kibana4') }
  end

  context 'installs via archive and no symlink' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '4.0.0-linux-x64',
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    #it { should contain_file('/opt/kibana-4.0.0-linux-x64/config/kibana.yml').with_ensure('present') }
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
  end

  context 'installs via archive and symlink' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '4.0.0-linux-x64',
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    #it { should contain_file('/opt/kibana-4.0.0-linux-x64/config/kibana.yml').with_ensure('present') }
    it { should contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
  end

end
