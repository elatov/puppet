require 'spec_helper'

describe 'lynis' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "lynis class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('lynis::params') }
          it { is_expected.to contain_class('lynis::install').that_comes_before('lynis::config') }
          it { is_expected.to contain_class('lynis::config') }
          it { is_expected.to contain_class('lynis::service').that_subscribes_to('lynis::config') }

          it { is_expected.to contain_service('lynis') }
          it { is_expected.to contain_package('lynis').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'lynis class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('lynis') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
