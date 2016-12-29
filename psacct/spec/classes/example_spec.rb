require 'spec_helper'

describe 'psacct' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "psacct class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('psacct::params') }
          it { is_expected.to contain_class('psacct::install').that_comes_before('psacct::config') }
          it { is_expected.to contain_class('psacct::config') }
          it { is_expected.to contain_class('psacct::service').that_subscribes_to('psacct::config') }

          it { is_expected.to contain_service('psacct') }
          it { is_expected.to contain_package('psacct').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'psacct class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('psacct') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
