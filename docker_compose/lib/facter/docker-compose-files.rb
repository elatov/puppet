require 'facter'

# Default for non-Linux nodes
#
Facter.add(:docker_compose_files) do
    setcode do
        nil
    end
end

# Linux
#
Facter.add(:docker_compose_files) do
    confine :kernel  => :linux
    setcode do
        Facter::Util::Resolution.exec("ls /etc/puppetlabs/code/environments/production/modules/docker_compose/files/")
    end
end
