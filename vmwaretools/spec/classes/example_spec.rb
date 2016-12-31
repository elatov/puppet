require 'spec_helper'

describe 'vmwaretools' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "vmwaretools class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('vmwaretools::params') }
          it { is_expected.to contain_class('vmwaretools::install').that_comes_before('vmwaretools::config') }
          it { is_expected.to contain_class('vmwaretools::config') }
          it { is_expected.to contain_class('vmwaretools::service').that_subscribes_to('vmwaretools::config') }

          it { is_expected.to contain_service('vmwaretools') }
          it { is_expected.to contain_package('vmwaretools').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'vmwaretools class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('vmwaretools') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
