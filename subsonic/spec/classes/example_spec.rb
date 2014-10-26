require 'spec_helper'

describe 'subsonic' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "subsonic class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('subsonic::params') }
        it { should contain_class('subsonic::install').that_comes_before('subsonic::config') }
        it { should contain_class('subsonic::config') }
        it { should contain_class('subsonic::service').that_subscribes_to('subsonic::config') }

        it { should contain_service('subsonic') }
        it { should contain_package('subsonic').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'subsonic class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('subsonic') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
