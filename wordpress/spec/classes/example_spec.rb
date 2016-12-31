require 'spec_helper'

describe 'wordpress' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "wordpress class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('wordpress::params') }
          it { is_expected.to contain_class('wordpress::install').that_comes_before('wordpress::config') }
          it { is_expected.to contain_class('wordpress::config') }
          it { is_expected.to contain_class('wordpress::service').that_subscribes_to('wordpress::config') }

          it { is_expected.to contain_service('wordpress') }
          it { is_expected.to contain_package('wordpress').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'wordpress class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('wordpress') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
