require 'spec_helper'

describe 'audit' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "audit class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('audit::params') }
          it { is_expected.to contain_class('audit::install').that_comes_before('audit::config') }
          it { is_expected.to contain_class('audit::config') }
          it { is_expected.to contain_class('audit::service').that_subscribes_to('audit::config') }

          it { is_expected.to contain_service('audit') }
          it { is_expected.to contain_package('audit').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'audit class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('audit') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
