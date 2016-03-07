require 'spec_helper_acceptance'

describe 'kibana4 default' do

  archive = only_host_with_role(hosts, 'archive')
  package = only_host_with_role(hosts, 'package')

  let(:manifest_package) {
  <<-EOS
    class { '::kibana4': }
    EOS
  }

  let(:manifest_archive) {
  <<-EOS
    class { '::kibana4':
      install_method     => 'archive',
      version            => '4.4.1-linux-x64',
      archive_symlink    => true,
      service_name       => 'kibana',
      manage_init_file   => true,
      manage_user        => true,
      kibana4_user       => 'kibana',
      kibana4_group      => 'kibana',
      config             => {
        'port'                 => 5601,
        'host'                 => '0.0.0.0',
        'elasticsearch_url'    => 'http://localhost:9200',
      }
    }
    EOS
  }

  it 'package install should run without errors' do
    result = apply_manifest_on(package, manifest_package, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 2
  end

  it 'package install should run a second time without changes' do
    result = apply_manifest_on(package, manifest_package, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 0
  end

  it 'archive install should run without errors' do
    result = apply_manifest_on(archive, manifest_archive, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 2
  end

  it 'archive install should run a second time without changes' do
    result = apply_manifest_on(archive, manifest_archive, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 0
  end

end
