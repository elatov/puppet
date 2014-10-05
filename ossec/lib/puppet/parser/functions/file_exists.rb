module Puppet::Parser::Functions
	newfunction(:file_exists, :type => :rvalue) do |args|
		raise(Puppet::ParseError, "file is the following #{file}")
		file = File.expand_path(args[0])
		print "OMG PRINT SOMETHING"
		if File.exists?(file)
			return true
		else
			return false
		end
	end
end
