require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'apache::mod::dav_svn class', unless: (fact('operatingsystem') == 'OracleLinux' && fact('operatingsystemmajrelease') == '7') ||
                                               (fact('operatingsystem') == 'SLES' && fact('operatingsystemmajorrelease') < '11') do
  case fact('osfamily')
  when 'Debian'
    if fact('operatingsystemmajrelease') == '6' || fact('operatingsystemmajrelease') == '10.04' || fact('operatingsystemrelease') == '10.04' || fact('operatingsystemmajrelease') == '16.04'
      authz_svn_load_file = 'dav_svn_authz_svn.load'
    else
      authz_svn_load_file = 'authz_svn.load'
    end
  else
    authz_svn_load_file = 'dav_svn_authz_svn.load'
  end

  context 'default dav_svn config' do
    pp = <<-MANIFEST
        class { 'apache': }
        include apache::mod::dav_svn
    MANIFEST
    it 'succeeds in puppeting dav_svn' do
      apply_manifest(pp, catch_failures: true)
    end

    describe service($service_name) do
      if fact('operatingsystem') == 'Debian' && fact('operatingsystemmajrelease') == '8'
        pending 'Should be enabled - Bug 760616 on Debian 8'
      else
        it { is_expected.to be_enabled }
      end
      it { is_expected.to be_running }
    end

    describe file("#{$mod_dir}/dav_svn.load") do
      it { is_expected.to contain 'LoadModule dav_svn_module' }
    end
  end

  context 'dav_svn with enabled authz_svn config' do
    pp = <<-MANIFEST
        class { 'apache': }
        class { 'apache::mod::dav_svn':
            authz_svn_enabled => true,
        }
    MANIFEST
    it 'succeeds in puppeting dav_svn' do
      apply_manifest(pp, catch_failures: true)
    end

    describe service($service_name) do
      if fact('operatingsystem') == 'Debian' && fact('operatingsystemmajrelease') == '8'
        pending 'Should be enabled - Bug 760616 on Debian 8'
      else
        it { is_expected.to be_enabled }
      end
      it { is_expected.to be_running }
    end

    describe file("#{$mod_dir}/#{authz_svn_load_file}") do
      it { is_expected.to contain 'LoadModule authz_svn_module' }
    end
  end
end
