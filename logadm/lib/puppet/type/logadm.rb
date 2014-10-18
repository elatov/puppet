require 'etc'
require 'fileutils'
require 'optparse'
require 'shellwords'

Puppet::Type.newtype(:logadm) do

	ensurable do
       newvalue(:present) do
           provider.add_entry
       end

       newvalue(:absent) do
           provider.remove_entry
       end

       defaultto :present
    end
	
    newparam(:name) do
        desc "The name of the logadm entry. If no pattern is defined, this will
            be used by default.
                    "
        isnamevar
    end
    newparam(:pattern) do
            desc "The pattern to search for for log rotation"
            end

            def log_file
                    self[:pattern] || self[:name]
            end
    newparam(:conf_file) do
        desc "Use this config file to track the logadm entry's. This defaults
            to /etc/logadm.conf
            "
        defaultto { "/etc/logadm.conf" }
    end

            # Autorequire the logadm.conf file itself.
    autorequire(:file) do
            self[:conf_file]
            end

    newparam(:post_command) do
        desc "Execute the post command after renaming the log file. This
            is synonymous with logadm's -a option.
            "
    end
    newparam(:age) do
        desc "Delete any versions that have not been modified for the
            amount of time specified by age.  This is synonymous with
            logadm's -A option.
            "
    end
    newparam(:pre_command) do
        desc "Execute pre_command before renaming the log file. This is
            synonymous with logadm's -b option.
            "
    end
    newparam(:copy_truncate) do
        desc "Rotate the log file by copying it and truncating the original
            logfile to zero length, rather than renaming the file. This is
            synonymous with logadm's -c option.
            "
        newvalues(:true, :false)
    end
    newparam(:count) do
        desc "Delete the oldest versions until there are not more than count
            files left. This is synonymous with logadm's -C option.
        "
        validate do |value|
            unless value.match(/^\d+$/)
                raise ArgumentError, "Count must be numeric"
            end
        end
    end
    newparam(:mail) do
        desc "Send error messages by email to email address. This is synonymous
            with logadm's -e option.
            "
    end
    newparam(:expire_command) do
        desc "Execute expire_command to expire the file, rather than deleting
            the old log file to expire it. This is synonymous with logadm's
            -E option.
            "
    end
    newparam(:group) do
        desc "Create new empty file with the ID specified by group, instead of
            preserving the group ID of the log file. This is synonymous with
            logadm's -g option.
            "
        validate do |value|
            begin
                Etc.getgrnam(value)
            rescue ArgumentError
                raise ArgumentError, "Group must be a valid UNIX group."
            end
        end
    end
    newparam(:mode) do
        desc "Create a new empty file with the mode specified by mode, instead
            of preserving the mode of the log file. This is synonymous with
            logadm's -m option.
            "
    end
    newparam(:move_command) do
        desc 'Execute move_command to rename the move the file, rather than by
            using the default command "mv $file $nfile". Accepts the keywords
            $file and $nfile. This is synonymous with logadm\'s -M option."
            '
    end
    newparam(:noop) do
        desc "Have logadm print the actions it would take instead of performing
            them. This is synonymous with logadm's -n option. Please note that
            this noop is for logadm, not for puppet. Designating noop as true
            will cause puppet to take action to cause the -n option to be placed
            in the hosts /etc/logadm.conf file.
            "
        newvalues(:true, :false)
    end
    newparam(:ignore_missing) do
        desc "Prevent an error message if the specified logfile does not exist.
            This is synonymous with logadm's -N option.
            "
        newvalues(:true, :false)
    end
    newparam(:owner) do
        desc "Create new empty file with owner instead of preserving the owner
            of the log file. This is synonymous with logadm's -o option.
            "
        validate do |value|
            begin
                Etc.getpwnam(value)
            rescue ArgumentError
                raise ArgumentError, "Owner must be a valid UNIX user."
            end
        end
    end
    newparam(:period) do
        desc "Rotate the log file after the specified time period. This is
            synonymous with logadm's -p option.
            "
    end
    newparam(:run_on_rotate) do
        desc "Run the cmd when an old log file is created by a log rotation.
            This is synonymous with logadm's -R option.
            "
    end

    newparam(:size) do
        desc "Rotate the log file only if its size is greater than or equal
            to size. This is synonymous with logadm's -s option.
            "
    end
    newparam(:max_size) do
        desc "Delete the oldest versions until the total disk space used by
            the old log files is less than the specified size. This is synonymous
            with logadm's -S option.
            "
    end
    newparam(:template) do
        desc "Specify the template to use when renaming log files. This is
            synonymous with logadm's -t option.
            "
    end
    newparam(:old_template) do
        desc "Specify a different template to use when rotating old log files.
            This is synonymous with logadm's -T option.
            "
    end
    newparam(:compress_count) do
        desc "Compress old log files as they are created. Count of the most
            recent log files are left uncompressed for easy access. Use a count
            of 0 to compress all old logs. This is synonymous with logadm's -z
            option.
            "
        validate do |value|
            unless value.match(/^\d+$/)
                raise ArgumentError, "Compress count must be numeric"
            end
        end
    end

    newparam(:comment) do
        desc "Add a comment to logadm.conf explaining the purpose of this entry"
    end

        
end