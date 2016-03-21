require 'spec_helper_acceptance'

describe 'kibana4 default', :node => :archive do

  archive = only_host_with_role(hosts, 'archive')

  let(:manifest_archive) {
  <<-EOS
    class { '::kibana4':
      install_method     => 'archive',
      version            => '4.4.1-linux-x64',
      manage_init_file   => true,
      manage_user        => true,
      config             => {
        'port'                 => 5601,
        'host'                 => '0.0.0.0',
        'elasticsearch_url'    => 'http://localhost:9200',
      }
    }
  EOS
  }

  let(:manifest_archive_plugin_install) {
  <<-EOS
    class { '::kibana4':
      install_method     => 'archive',
      version            => '4.4.1-linux-x64',
      manage_init_file   => true,
      manage_user        => true,
      config             => {
        'port'                 => 5601,
        'host'                 => '0.0.0.0',
        'elasticsearch_url'    => 'http://localhost:9200',
      },
      plugins => {
        'elasticsearch/marvel' => {
           ensure          => present,
           plugin_dest_dir => 'marvel',
        },
        'elastic/sense' => {
           ensure          => present,
           plugin_dest_dir => 'sense',
        }
      }
    }
  EOS
  }

  let(:manifest_archive_plugin_remove) {
    <<-EOS
    class { '::kibana4':
      install_method     => 'archive',
      version            => '4.4.1-linux-x64',
      manage_init_file   => true,
      manage_user        => true,
      config             => {
        'port'                 => 5601,
        'host'                 => '0.0.0.0',
        'elasticsearch_url'    => 'http://localhost:9200',
      },
      plugins => {
        'elasticsearch/marvel' => {
           ensure          => absent,
           plugin_dest_dir => 'marvel',
        },
        'elastic/sense' => {
           ensure          => absent,
           plugin_dest_dir => 'sense',
        }
      }
    }
  EOS
  }

  it 'archive install should run without errors' do
    result = apply_manifest_on(archive, manifest_archive, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 2
  end

  it 'archive install should run a second time without changes' do
    result = apply_manifest_on(archive, manifest_archive, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 0
  end

  context 'archive default params' do

    describe group('kibana') do
      it { should exist }
    end

    describe user('kibana') do
      it { should exist }
      it { should belong_to_group 'kibana' }
    end

    describe file('/opt/kibana') do
      it { should be_symlink }
      it { should be_owned_by 'kibana' }
      it { should be_grouped_into 'kibana' }
    end

    describe file('/etc/init.d/kibana') do
      it { should be_file }
      it { should contain 'pidfile=/var/run/kibana.pid' }
      it { should be_executable }
    end

    describe file('/etc/default/kibana') do
      it { should be_file }
      it { should contain 'user="kibana"' }
      it { should contain 'group="kibana"' }
    end

    describe service('kibana') do
      #it { should be_installed }
      it { should be_running }
    end

    #this needs troubleshooting
    #describe port(5601) do
    #  it { should be_listening.with('tcp') }
    #end

  end

  it 'archive plugin install should run without errors' do
    result = apply_manifest_on(archive, manifest_archive_plugin_install, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 2
  end

  it 'archive plugin install should run a second time without changes' do
    result = apply_manifest_on(archive, manifest_archive_plugin_install, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 0
  end

  it 'archive plugin remove should run without errors' do
    result = apply_manifest_on(archive, manifest_archive_plugin_remove, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 2
  end

  it 'archive plugin remove should run a second time without changes' do
    result = apply_manifest_on(archive, manifest_archive_plugin_remove, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 0
  end

end
