require 'spec_helper'
describe 'kibana4' do

  context 'with defaults for all parameters' do
    it { should contain_class('kibana4') }
  end

  context 'installs via archive and no symlink and no user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '4.0.0-linux-x64',
        :ensure         => false,
        :enable         => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec root:root \/ sh -c "/) }
  end

  context 'installs via archive and no symlink and service ensure and no user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '4.0.0-linux-x64',
        :ensure         => true,
        :enable         => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec root:root \/ sh -c "/) }
  end

  context 'installs via archive and no symlink and service ensure/enable and no user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '4.0.0-linux-x64',
        :ensure         => true,
        :enable         => true,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec root:root \/ sh -c "/) }
  end

  context 'installs via archive and symlink and no user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '4.0.0-linux-x64',
        :ensure         => false,
        :enable         => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec root:root \/ sh -c "/) }
  end

  context 'installs via archive and symlink and service ensure and no user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '4.0.0-linux-x64',
        :ensure         => true,
        :enable         => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec root:root \/ sh -c "/) }
  end

  context 'installs via archive and symlink and service ensure/enable and no user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '4.0.0-linux-x64',
        :ensure         => true,
        :enable         => true,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec root:root \/ sh -c "/) }
  end




  context 'installs via archive and no symlink and user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '4.0.0-linux-x64',
        :create_user    => true,
        :kibana4_user   => 'kibana4',
        :kibana4_uid    => '200',
        :kibana4_group  => 'kibana4',
        :kibana4_gid    => '200',
        :enable         => false,
        :ensure         => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }    
  end

  context 'installs via archive and no symlink and service ensure and user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '4.0.0-linux-x64',
        :ensure         => true,
        :create_user    => true,
        :kibana4_user   => 'kibana4',
        :kibana4_uid    => '200',
        :kibana4_group  => 'kibana4',
        :kibana4_gid    => '200',
        :ensure         => true,
        :enable         => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }    
  end

  context 'installs via archive and no symlink and service ensure/enable and no user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => false,
        :version        => '4.0.0-linux-x64',
        :ensure         => true,
        :enable         => true,
        :create_user    => true,
        :kibana4_user   => 'kibana4',
        :kibana4_uid    => '200',
        :kibana4_group  => 'kibana4',
        :kibana4_gid    => '200',
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }    
  end

  context 'installs via archive and symlink and user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '4.0.0-linux-x64',
        :create_user    => true,
        :kibana4_user   => 'kibana4',
        :kibana4_uid    => '200',
        :kibana4_group  => 'kibana4',
        :kibana4_gid    => '200',
        :ensure         => false,
        :enable         => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }    
  end

  context 'installs via archive and symlink and service ensure and user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '4.0.0-linux-x64',
        :ensure         => true,
        :create_user    => true,
        :kibana4_user   => 'kibana4',
        :kibana4_uid    => '200',
        :kibana4_group  => 'kibana4',
        :kibana4_gid    => '200',
        :enable         => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }    
  end

  context 'installs via archive and symlink and service ensure/enable and user' do
    let :params do
      {
        :install_method => 'archive',
        :symlink        => true,
        :version        => '4.0.0-linux-x64',
        :ensure         => true,
        :enable         => true,
        :create_user    => true,
        :kibana4_user   => 'kibana4',
        :kibana4_uid    => '200',
        :kibana4_group  => 'kibana4',
        :kibana4_gid    => '200',
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }    
  end

end
