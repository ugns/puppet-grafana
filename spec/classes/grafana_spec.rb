require 'spec_helper'

describe 'grafana' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "grafana class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('staging::params') }
        it { should contain_class('staging') }

        it { should contain_file('/opt/staging') }
        it { should contain_file('/opt/staging/grafana') }

        it { should contain_staging__deploy("grafana-1.5.3.tar.gz").with({
              'creates' => '/opt/grafana-1.5.3'
        }) }
        it { should contain_staging__file("grafana-1.5.3.tar.gz") }
        it { should contain_staging__extract("grafana-1.5.3.tar.gz") }
        it { should contain_exec("/opt/staging/grafana/grafana-1.5.3.tar.gz") }
        it { should contain_exec("extract grafana-1.5.3.tar.gz") }

        it { should contain_file('/opt/grafana-1.5.3/config.js') }
        it { should contain_file('/opt/grafana').with({
              'ensure' => 'link',
              'target' => '/opt/grafana-1.5.3'
        }) }

        it { should contain_class('grafana::params') }
        it { should contain_class('grafana::install').that_comes_before('grafana::config') }
        it { should contain_class('grafana::config') }
        it { should contain_class('grafana') }
      end

      describe "grafana class with parameters on #{osfamily}" do
        let(:params) {{
          :version      => '9.9.9',
          :install_dir  => '/var/www',
          :symlink_name => 'Grafana',
          :user         => 'root',
          :group        => 'root',
        }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_staging__deploy("grafana-9.9.9.tar.gz").with({
              'creates' => '/var/www/grafana-9.9.9'
        }) }
        it { should contain_staging__file("grafana-9.9.9.tar.gz") }
        it { should contain_staging__extract("grafana-9.9.9.tar.gz").with({
              'user'  => 'root',
              'group' => 'root',
        }) }
        it { should contain_exec("/opt/staging/grafana/grafana-9.9.9.tar.gz") }
        it { should contain_exec("extract grafana-9.9.9.tar.gz") }

        it { should contain_file('/var/www/grafana-9.9.9/config.js').with({
              'owner' => 'root',
              'group' => 'root',
        }) }
        it { should contain_file('/var/www/Grafana').with({
              'ensure' => 'link',
              'owner'  => 'root',
              'group'  => 'root',
              'target' => '/var/www/grafana-9.9.9',
        }) }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'grafana class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('grafana') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
