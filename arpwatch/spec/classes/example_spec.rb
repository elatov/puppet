require 'spec_helper'

describe 'arpwatch' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "arpwatch class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('arpwatch::params') }
          it { is_expected.to contain_class('arpwatch::install').that_comes_before('arpwatch::config') }
          it { is_expected.to contain_class('arpwatch::config') }
          it { is_expected.to contain_class('arpwatch::service').that_subscribes_to('arpwatch::config') }

          it { is_expected.to contain_service('arpwatch') }
          it { is_expected.to contain_package('arpwatch').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'arpwatch class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('arpwatch') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
