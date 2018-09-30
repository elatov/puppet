require 'facter'

# Default for non-Linux nodes
#
Facter.add(:dock_compose_files) do
    setcode do
        nil
    end
end

# Linux
#
Facter.add(:dock_compose_files) do
    confine :kernel  => :linux
    setcode do
        Facter::Util::Resolution.exec("ls /etc/puppetlabs/code/environments/production/modules/dock_compose/files/")
    end
end
