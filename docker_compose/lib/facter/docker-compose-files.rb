require 'facter'

# Default for non-Linux nodes
#
Facter.add(:docker-compose-files) do
    setcode do
        nil
    end
end

# Linux
#
Facter.add(:docker-compose-files) do
    confine :kernel  => :linux
    setcode do
        Facter::Util::Resolution.exec("ls
        /etc/puppetlabs/code/environments/production/modules/docker_compose/files/")
    end
end