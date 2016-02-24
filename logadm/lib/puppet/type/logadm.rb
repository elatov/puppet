require 'etc'
require 'fileutils'
require 'optparse'
require 'shellwords'

module Puppet
    Type.newtype(:logadm) do
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

        attr_accessor :bucket
        

        # Returns a string of the appropriate line to add to
        # logadm.conf for this resource.
        def serialized_entry
            options = []
            options << "-a '#{self[:post_command]}'" if self[:post_command]
            options << "-A #{self[:age]}" if self[:age]
            options << "-b '#{self[:pre_command]}'" if self[:pre_command]
            options << "-c" if self[:copy_truncate]
            options << "-C #{self[:count]}" if self[:count]
            options << "-e #{self[:mail]}" if self[:mail]
            options << "-E '#{self[:expire_command]}'" if self[:expire_command]
            options << "-g #{self[:group]}" if self[:group]
            options << "-m #{self[:mode]}" if self[:mode]
            options << "-M '#{self[:move_command]}'" if self[:move_command]
            options << "-n" if self[:noop]
            options << "-N" if self[:ignore_missing]
            options << "-o #{self[:owner]}" if self[:owner]
            options << "-p #{self[:period]}" if self[:period]
            options << "-R '#{self[:run_on_rotate]}'" if self[:run_on_rotate]
            options << "-s #{self[:size]}" if self[:size]
            options << "-S #{self[:max_size]}" if self[:max_size]
            options << "-t #{self[:template]}" if self[:template]
            options << "-T #{self[:old_template]}" if self[:old_template]
            options << "-z #{self[:compress_count]}" if self[:compress_count]
            if self[:pattern]
                "#{self[:name]} #{options.join(' ')} #{self[:pattern]}"
                        else
                "#{self[:name]} #{options.join(' ')}"
                        end
        end

        def parse_options(options)
            o = {}
            local_options = options.shellsplit[1..-1]
            opts = OptionParser.new do |opts|
                opts.on('-a STRING') { |s| o[:post_command] = s }
                opts.on('-A STRING') { |s| o[:age] = s }
                opts.on('-b STRING') { |s| o[:pre_command] = s }
                opts.on('-c') { |s| o[:copy_truncate] = s }
                opts.on('-C STRING') { |s| o[:count] = s }
                opts.on('-e STRING') { |s| o[:mail] = s }
                opts.on('-E STRING') { |s| o[:expire_command] = s }
                opts.on('-g STRING') { |s| o[:group] = s }
                opts.on('-m STRING') { |s| o[:mode] = s }
                opts.on('-M STRING') { |s| o[:move_command] = s }
                opts.on('-n') { |s| o[:noop] = s }
                opts.on('-N') { |s| o[:ignore_missing] = s }
                opts.on('-o STRING') { |s| o[:owner] = s }
                opts.on('-p STRING') { |s| o[:period] = s }
                opts.on('-R STRING') { |s| o[:run_on_rotate] = s }
                opts.on('-s STRING') { |s| o[:size] = s }
                opts.on('-S STRING') { |s| o[:max_size] = s }
                opts.on('-t STRING') { |s| o[:template] = s }
                opts.on('-T STRING') { |s| o[:old_template] = s }
                opts.on('-z STRING') { |s| o[:compress_count] = s }
                opts.on('-P STRING') { |s| nil }
            end
            #local_options will only hold the leftovers which may include
            #a pattern.
            opts.parse!(local_options)
            return [o, local_options]
        end

        # Remove this resource from the logadm.conf file.
        def remove_entry
            tmpfile = Tempfile.new('puppet-logadm')
            File.open(self[:conf_file]).each_line do |line|
                # Skip the line implementing the entry itself
                unless line.match(/#{self[:name]}\s/)
                    # Skip the formatted comment for the entry
                    unless line.match(/^#.* puppet\(logadm\["#{self[:name]}"\]\)\s*$/)
                        tmpfile.puts line
                    end
                end
            end
            tmpfile.close
            FileUtils.copy(tmpfile.path, self[:conf_file])
            tmpfile.unlink
        end

        # Add this resource to the logadm.conf file.
        def add_entry
            File.open(self[:conf_file], 'a') do |file|
                file.puts comment
                file.puts serialized_entry
            end
        end

        def comment
            if self[:comment]
                "# #{self[:comment]} - puppet(logadm[\"#{self[:name]}\"])"
            else
                "# puppet(logadm[\"#{self[:name]}\"])"
            end
        end

        # Return the line from the logadm.conf file which matches this resource
        # if one exists. Otherwise, return nil.
        def entry_on_disk
            if @entry_on_disk
                @entry_on_disk
            else
                if File.exist?(self[:conf_file])
                    line = File.open(self[:conf_file]).detect do |line|
                        line.match(/^#{self[:name]}\s/)
                    end
                    if line
                        @entry_on_disk = line.chomp
                    else
                        nil
                    end
                else
                    nil
                end
            end
        end

        # We have to do some extra finishing, to retrieve our bucket if
        # there is one.
        
        # Validates the current logadm.conf file. If it's invalid,
        # restore's the backup
        def validate_entry
            if File.exist?('/usr/sbin/logadm')
                valid = Kernel.system("/usr/sbin/logadm -f #{self[:conf_file]} -V #{self[:name]} > /dev/null 2>&1")
                if !valid
                    self.err "Restoring previous #{self[:conf_file]}. Requested entry is invalid."
                    restore
                end
            else
                self.notice "Unable to validate, /usr/sbin/logadm unavailable"
            end
        end


        # returns whether a given entry matches this resource completely
        def entry_is_correct?
            if entry_on_disk
                parse_options(entry_on_disk) == parse_options(serialized_entry)
            else
                false
            end
        end


        def exists?
            case self[:ensure]
            when :present
                entry_is_correct?
            when :absent
                !entry_on_disk.nil?
            end
        end

        ensurable do
            desc "Ensure that an entry is present, or that it is absent.
                "
            newvalue(:present) do
                if @resource.entry_on_disk
                    if !@resource.entry_is_correct?
                        @resource.remove_entry
                        @resource.add_entry
                        @resource.validate_entry
                    end
                else
                    @resource.add_entry
                    @resource.validate_entry
                end
            end

            newvalue(:absent) do
                if @resource.entry_on_disk
                    @resource.remove_entry
                end
            end
            defaultto :present
        end

    end
end