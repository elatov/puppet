require 'spec_helper'

describe 'sophos' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "sophos class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('sophos::params') }
          it { is_expected.to contain_class('sophos::install').that_comes_before('sophos::config') }
          it { is_expected.to contain_class('sophos::config') }
          it { is_expected.to contain_class('sophos::service').that_subscribes_to('sophos::config') }

          it { is_expected.to contain_service('sophos') }
          it { is_expected.to contain_package('sophos').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'sophos class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('sophos') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
