Puppet::Type.type(:logadm).provide(:logadm) do
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


end