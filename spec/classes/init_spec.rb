require 'spec_helper'
describe 'kibana4' do

  context 'with defaults for all parameters' do
    it { should contain_class('kibana4') }
  end

  context 'installs via archive and no symlink and no user' do
    let :params do
      {
        :package_provider => 'archive',
        :symlink          => false,
        :package_ensure   => '4.0.0-linux-x64',
        :service_ensure   => false,
        :service_enable   => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }
  end

  context 'installs via archive and no symlink and service ensure and no user' do
    let :params do
      {
        :package_provider => 'archive',
        :symlink          => false,
        :package_ensure   => '4.0.0-linux-x64',
        :service_ensure   => true,
        :service_enable   => false,
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
        :package_provider => 'archive',
        :symlink          => false,
        :package_ensure   => '4.0.0-linux-x64',
        :service_ensure   => true,
        :service_enable   => true,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and no user' do
    let :params do
      {
        :package_provider => 'archive',
        :symlink          => true,
        :package_ensure   => '4.0.0-linux-x64',
        :service_ensure   => false,
        :service_enable   => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and service ensure and no user' do
    let :params do
      {
        :package_provider => 'archive',
        :symlink          => true,
        :package_ensure   => '4.0.0-linux-x64',
        :service_ensure   => true,
        :service_enable   => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and service ensure/enable and no user' do
    let :params do
      {
        :package_provider => 'archive',
        :symlink          => true,
        :package_ensure   => '4.0.0-linux-x64',
        :service_ensure   => true,
        :service_enable   => true,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }
  end




  context 'installs via archive and no symlink and user' do
    let :params do
      {
        :package_provider => 'archive',
        :symlink          => false,
        :package_ensure   => '4.0.0-linux-x64',
        :manage_user      => true,
        :kibana4_user     => 'kib4',
        :kibana4_uid      => '200',
        :kibana4_group    => 'kib4',
        :kibana4_gid      => '200',
        :service_enable   => false,
        :service_ensure   => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

  context 'installs via archive and no symlink and service ensure and user' do
    let :params do
      {
        :package_provider => 'archive',
        :symlink          => false,
        :package_ensure   => '4.0.0-linux-x64',
        :manage_user      => true,
        :kibana4_user     => 'kib4',
        :kibana4_uid      => '200',
        :kibana4_group    => 'kib4',
        :kibana4_gid      => '200',
        :service_ensure   => true,
        :service_enable   => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

  context 'installs via archive and no symlink and service ensure/enable and no user' do
    let :params do
      {
        :package_provider => 'archive',
        :symlink        => false,
        :package_ensure        => '4.0.0-linux-x64',
        :service_ensure         => true,
        :service_enable         => true,
        :manage_user    => true,
        :kibana4_user   => 'kib4',
        :kibana4_uid    => '200',
        :kibana4_group  => 'kib4',
        :kibana4_gid    => '200',
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and user' do
    let :params do
      {
        :package_provider => 'archive',
        :symlink        => true,
        :package_ensure        => '4.0.0-linux-x64',
        :manage_user    => true,
        :kibana4_user   => 'kib4',
        :kibana4_uid    => '200',
        :kibana4_group  => 'kib4',
        :kibana4_gid    => '200',
        :service_ensure         => false,
        :service_enable         => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and service ensure and user' do
    let :params do
      {
        :package_provider => 'archive',
        :symlink          => true,
        :package_ensure   => '4.0.0-linux-x64',
        :service_ensure   => true,
        :manage_user      => true,
        :kibana4_user     => 'kib4',
        :kibana4_uid      => '200',
        :kibana4_group    => 'kib4',
        :kibana4_gid      => '200',
        :service_enable   => false,
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and service ensure/enable and user' do
    let :params do
      {
        :package_provider => 'archive',
        :symlink          => true,
        :package_ensure   => '4.0.0-linux-x64',
        :service_ensure   => true,
        :service_enable   => true,
        :manage_user      => true,
        :kibana4_user     => 'kib4',
        :kibana4_uid      => '200',
        :kibana4_group    => 'kib4',
        :kibana4_gid      => '200',
      }
    end
    it { should contain_archive('kibana-4.0.0-linux-x64')}
    it { should contain_file('/opt/kibana4').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^program=\/opt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

end
