define rm_dir ($dir=$title) {
    exec { "rm_${$dir}":
      path => "/bin:/usr/bin",
      provider => "shell",
      command => "rmdir ${dir}",
      #onlyif => "[ -d ${dir} -a -z `ls -A ${dir}`]", 
      onlyif => "test -d ${dir} && test -z \"\$(ls -A ${dir})\"", 
    }
    #notify { "removing Directory ${dir}":; }
  }