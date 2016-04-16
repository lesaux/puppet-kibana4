require 'spec_helper'

describe 'kibana4' do

  context 'with defaults for all parameters' do
    let :facts do
      {
         :osfamily => 'RedHat'
      }
    end
    it { is_expected.to contain_class('kibana4') }
  end

  context 'installs via archive and no symlink and no user' do
    let :params do
      {
        :install_method   => 'archive',
        :archive_symlink  => false,
        :version          => '4.0.0-linux-x64',
        :service_ensure   => false,
        :service_enable   => false,
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }
  end

  context 'installs via archive and no symlink and service ensure and no user' do
    let :params do
      {
        :install_method   => 'archive',
        :archive_symlink  => false,
        :version          => '4.0.0-linux-x64',
        :service_ensure   => true,
        :service_enable   => false,
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }
  end

  context 'installs via archive and no init file' do
    let :params do
      {
        :install_method   => 'archive',
        :version          => '4.0.0-linux-x64',
        :service_ensure   => false,
        :service_enable   => false,
        :manage_init_file => false,
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { is_expected.to_not contain_file('/etc/init.d/kibana') }
  end

  context 'installs via archive and no symlink and service ensure/enable and no user' do
    let :params do
      {
        :install_method   => 'archive',
        :archive_symlink  => false,
        :version          => '4.0.0-linux-x64',
        :service_ensure   => true,
        :service_enable   => true,
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and no user' do
    let :params do
      {
        :install_method   => 'archive',
        :archive_symlink  => true,
        :version          => '4.0.0-linux-x64',
        :service_ensure   => false,
        :service_enable   => false,
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and service ensure and no user' do
    let :params do
      {
        :install_method   => 'archive',
        :archive_symlink  => true,
        :version          => '4.0.0-linux-x64',
        :service_ensure   => true,
        :service_enable   => false,
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and service ensure/enable and no user' do
    let :params do
      {
        :install_method   => 'archive',
        :archive_symlink  => true,
        :version          => '4.0.0-linux-x64',
        :service_ensure   => true,
        :service_enable   => true,
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kibana4:kibana4 \/ sh -c "/) }
  end

  context 'installs via archive and no symlink and user' do
    let :params do
      {
        :install_method   => 'archive',
        :archive_symlink  => false,
        :version          => '4.0.0-linux-x64',
        :manage_user      => true,
        :kibana4_user     => 'kib4',
        :kibana4_uid      => '200',
        :kibana4_group    => 'kib4',
        :kibana4_gid      => '200',
        :service_enable   => false,
        :service_ensure   => false,
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

  context 'installs via archive and no symlink and service ensure and user' do
    let :params do
      {
        :install_method   => 'archive',
        :archive_symlink  => false,
        :version          => '4.0.0-linux-x64',
        :manage_user      => true,
        :kibana4_user     => 'kib4',
        :kibana4_uid      => '200',
        :kibana4_group    => 'kib4',
        :kibana4_gid      => '200',
        :service_ensure   => true,
        :service_enable   => false,
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

  context 'installs via archive and no symlink and service ensure/enable and no user' do
    let :params do
      {
        :install_method  => 'archive',
        :archive_symlink => false,
        :version         => '4.0.0-linux-x64',
        :service_ensure  => true,
        :service_enable  => true,
        :manage_user     => true,
        :kibana4_user    => 'kib4',
        :kibana4_uid     => '200',
        :kibana4_group   => 'kib4',
        :kibana4_gid     => '200',
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to_not contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\-4.0.0\-linux\-x64\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and user' do
    let :params do
      {
        :install_method  => 'archive',
        :archive_symlink => true,
        :version         => '4.0.0-linux-x64',
        :manage_user     => true,
        :kibana4_user    => 'kib4',
        :kibana4_uid     => '200',
        :kibana4_group   => 'kib4',
        :kibana4_gid     => '200',
        :service_ensure  => false,
        :service_enable  => false,
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('false').with_enable('false') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and service ensure and user' do
    let :params do
      {
        :install_method   => 'archive',
        :archive_symlink  => true,
        :version          => '4.0.0-linux-x64',
        :service_ensure   => true,
        :manage_user      => true,
        :kibana4_user     => 'kib4',
        :kibana4_uid      => '200',
        :kibana4_group    => 'kib4',
        :kibana4_gid      => '200',
        :service_enable   => false,
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

  context 'installs via archive and symlink and service ensure/enable and user' do
    let :params do
      {
        :install_method   => 'archive',
        :archive_symlink  => true,
        :version          => '4.0.0-linux-x64',
        :service_ensure   => true,
        :service_enable   => true,
        :manage_user      => true,
        :kibana4_user     => 'kib4',
        :kibana4_uid      => '200',
        :kibana4_group    => 'kib4',
        :kibana4_gid      => '200',
      }
    end
    it { is_expected.to contain_archive('kibana-4.0.0-linux-x64')}
    it { is_expected.to contain_file('/opt/kibana').with_ensure('link').with_target('/opt/kibana-4.0.0-linux-x64') }
    it { is_expected.to contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^program=\/opt\/kibana\/bin\/kibana/) }
    #it { is_expected.to contain_file('/etc/init.d/kibana').with_content(/^  chroot --userspec kib4:kib4 \/ sh -c "/) }
  end

  context 'installs via package and package_install_dir and no init file and service ensure/enable and user' do
    let :facts do
      {
         :osfamily => 'RedHat'
      }
    end
    let :params do
      {
        :install_method      => 'package',
        :package_name        => 'kibana4',
        :version             => '4.4.1',
        :service_ensure      => true,
        :service_enable      => true,
        :kibana4_user        => 'kib4',
        :kibana4_group       => 'kib4',
        :manage_user         => false,
        :package_install_dir => '/usr/share/kibana4',
        :manage_init_file    => false,
        :config		     => {
          'server.port'           => 5601,
          'server.host'           => '0.0.0.0',
          'elasticsearch.url'     => 'http://localhost:9200'
        }
      }
    end
    it { is_expected.to contain_package('kibana4').with_ensure('4.4.1') }
    it { is_expected.to_not contain_file('/opt/kibana') }
    it { is_expected.to contain_file('kibana-config-file').with_path('/usr/share/kibana4/config/kibana.yml') }
    it { is_expected.to contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { is_expected.to_not contain_file('/etc/init.d/kibana') }
  end

  context 'installs via package and package_install_dir and init file and service ensure/enable and user' do
    let :facts do
      {
         :osfamily => 'RedHat'
      }
    end
    let :params do
      {
        :install_method      => 'package',
        :package_name        => 'kibana4',
        :version             => '4.4.1',
        :service_ensure      => true,
        :service_enable      => true,
        :kibana4_user        => 'kib4',
        :kibana4_group       => 'kib4',
        :manage_user         => false,
        :package_install_dir => '/usr/share/kibana4',
        :manage_init_file    => true,
        :config		     => {
          'server.port'           => 5601,
          'server.host'           => '0.0.0.0',
          'elasticsearch.url'     => 'http://localhost:9200'
        }
      }
    end
    it { is_expected.to contain_package('kibana4').with_ensure('4.4.1') }
    it { is_expected.to_not contain_file('/opt/kibana') }
    it { is_expected.to contain_file('kibana-config-file').with_path('/usr/share/kibana4/config/kibana.yml') }
    it { is_expected.to contain_service('kibana4').with_ensure('true').with_enable('true') }
    it { is_expected.to contain_file('/etc/init.d/kibana') }
    it {
      verify_contents(catalogue, '/etc/init.d/kibana', [
        'rundir=$(dirname $pidfile)',
        '[ ! -d $rundir ] && mkdir -p $rundir',
        'chown $user:$group $rundir',
        '  echo $! > $pidfile',
        '  chown $user:$group $pidfile',
      ])
    }
    it {
      verify_contents(catalogue, '/etc/init.d/kibana', [
        'program=/usr/share/kibana4/bin/kibana',
      ])
    }
  end

  context 'installs via package and set config file' do
    let :facts do
      {
         :osfamily => 'RedHat'
      }
    end
    let :params do
      {
        :install_method   => 'package',
        :config_file      => '/etc/kibana4/kibana.yml',
        :config      	  => {
          'server.port'           => 5601,
          'server.host'           => '0.0.0.0',
          'elasticsearch.url'     => 'http://localhost:9200'
        }
      }
    end
    it { is_expected.to contain_file('kibana-config-file').with_path('/etc/kibana4/kibana.yml') }
  end

  context 'installs via package provider' do

    context 'using custom package' do
      let :facts do
        {
          :osfamily => 'RedHat'
        }
      end
      let :params do
        {
          :install_method   => 'package',
        }
      end
      it { is_expected.to contain_package('kibana4') }
    end

    context 'using the official repos on CentOS' do
      let :facts do
        {
          :osfamily => 'RedHat'
        }
      end
      let :params do
        {
          :install_method            => 'package',
          :package_name              => 'kibana',
          :service_name              => 'kibana',
          :package_use_official_repo => true,
          :package_repo_version      => '4.1'
        }
      end
      it { is_expected.to contain_package('kibana4').with_name('kibana')}
      it { is_expected.to contain_service('kibana4').with_ensure('true').with_name('kibana') }
      it { is_expected.to contain_yumrepo('kibana-4.1') }
    end

    context 'using the official repos on CentOS behind a proxy' do
      let :facts do
        {
          :osfamily => 'RedHat'
        }
      end
      let :params do
        {
          :install_method            => 'package',
          :package_name              => 'kibana',
          :service_name              => 'kibana',
          :package_use_official_repo => true,
          :package_repo_version      => '4.1',
          :package_repo_proxy        => 'http://proxy:8080'

        }
      end
      it { should contain_package('kibana4').with_name('kibana')}
      it { should contain_service('kibana4').with_ensure('true').with_name('kibana') }
      it { should contain_yumrepo('kibana-4.1').with_proxy('http://proxy:8080') }
    end

    context 'using the official repos on Ubuntu' do
      let :facts do
        {
          :osfamily  => 'Debian',
          :lsbdistid => 'trusty'
        }
      end
      let :params do
        {
          :install_method            => 'package',
          :package_name              => 'kibana',
          :service_name              => 'kibana',
          :package_use_official_repo => true,
          :package_repo_version      => '4.1'
        }
      end
      it { is_expected.to contain_package('kibana4').with_name('kibana')}
      it { is_expected.to contain_service('kibana4').with_ensure('true').with_name('kibana') }
      it { is_expected.to contain_apt__source('kibana-4.1') }
    end

  end

end
