require 'spec_helper_acceptance'

describe 'kibana4 package' do

  package = only_host_with_role(hosts, 'package')

  let(:manifest_package) {
  <<-EOS
    class { '::kibana4': }
    EOS
  }

  let(:manifest_package_plugin_install) {
  <<-EOS
    class { '::kibana4':
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

  let(:manifest_package_plugin_remove) {
  <<-EOS
    class { '::kibana4':
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

  it 'package install should run without errors' do
    result = apply_manifest_on(package, manifest_package, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 2
  end

  it 'package install should run a second time without changes' do
    result = apply_manifest_on(package, manifest_package, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 0
  end

  it 'package plugin install should run without errors' do
    result = apply_manifest_on(package, manifest_package_plugin_install, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 2
  end

  it 'package plugin install should run a second time without changes' do
    result = apply_manifest_on(package, manifest_package_plugin_install, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 0
  end

  it 'package plugin remove should run without errors' do
    result = apply_manifest_on(package, manifest_package_plugin_remove, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 2
  end

  it 'package plugin remove should run a second time without changes' do
    result = apply_manifest_on(package, manifest_package_plugin_remove, opts = { :catch_failures => true })
    expect(@result.exit_code).to eq 0
  end

  #describe service('kibana') do
  #  it { should be_enabled }
  #end

  #@hosts.each do |host|
  #  step "i'm going to say hello to #{host}"
  #  on host, 'echo hello'
  #  hellos += 1
  #end


end
