# == Class sophos::config
#
# This class is called from sophos for service config.
#
class sophos::config {
  if !$sophos::initial_setup {
  
	  case $::osfamily {
	    'Debian': {
	      if ( $::sophos::settings['enable_liveprotection'] == true ){
          exec { "${module_name}-enable_livep":
                  cwd    =>  "${::sophos::install_dir}/bin",
                  command => "${::sophos::install_dir}/bin/savconfig set LiveProtection enabled",
                  unless  => "${::sophos::install_dir}/bin/savconfig query LiveProtection | /bin/grep enabled"
                } 
        }
  
        if ( $::sophos::settings['enable_onstart'] == true ){
          exec { "${module_name}-enable_onstart":
                  cwd    =>  "${::sophos::install_dir}/bin",
                  command => "${::sophos::install_dir}/bin/savconfig set EnableOnStart true",
                  unless  => "${::sophos::install_dir}/bin/savconfig query EnableOnStart | /bin/grep true"
                } 
        }
        
        if ( $::sophos::settings['enable_notifyonupdate'] == true ){
          exec { "${module_name}-enable_notifyonupdate":
                  cwd    =>  "${::sophos::install_dir}/bin",
                  command => "${::sophos::install_dir}/bin/savconfig set NotifyOnUpdate true",
                  unless  => "${::sophos::install_dir}/bin/savconfig query NotifyOnUpdate | /bin/grep true"
                } 
        }
        
        exec { "${module_name}-update_period_minutes":
                  cwd    =>  "${::sophos::install_dir}/bin",
                  command => "${::sophos::install_dir}/bin/savconfig set UpdatePeriodMinutes ${sophos::settings['update_period_minutes']}",
                  unless  => "${::sophos::install_dir}/bin/savconfig query UpdatePeriodMinutes | /bin/grep ${sophos::settings['update_period_minutes']}" 
             }
             
       if ( $::sophos::settings['setup_weekly_job'] == true ){
          $so_jobs_dir      = "${sophos::settings['weekly_job_settings']['sophos_jobs_dir']}"
          $so_weekjob_file  = "${sophos::settings['weekly_job_settings']['sophos_jobs_dir']}/${sophos::settings['weekly_job_settings']['sophos_weekly_file']}"
  
          ensure_resource ( 'file',
                            $so_jobs_dir,
                            {'ensure' => 'directory',}
                           )
                           
          file { "${so_weekjob_file}":
            content => template('sophos/weekly_job.erb'),
            mode    => '0600',
            require => File["${so_jobs_dir}"]
          }
          
          exec { "${module_name}-setup_weekly_job":
                  cwd    =>  "${::sophos::install_dir}/bin",
                  command => "${::sophos::install_dir}/bin/savconfig add NamedScans weekly ${so_weekjob_file}",
                  unless  => "${::sophos::install_dir}/bin/savconfig query NamedScans | /bin/grep weekly",
                  require => File["$so_weekjob_file"]
                } 
        }
        
        if ( $::sophos::settings['enable_email_always'] == true ){
          exec { "${module_name}-enable_email_always":
                  cwd    =>  "${::sophos::install_dir}/bin",
                  command => "${::sophos::install_dir}/bin/savconfig set EmailDemandSummaryAlways true",
                  unless  => "${::sophos::install_dir}/bin/savconfig query EmailDemandSummaryAlways | /bin/grep true" 
                } 
        }
	    }
	    'RedHat': {
	      if ( $::sophos::settings['enable_liveprotection'] == true ){
					exec { "${module_name}-enable_livep":
					        cwd    =>  "${::sophos::install_dir}/bin",
									command => "${::sophos::install_dir}/bin/savconfig set LiveProtection enabled",
									unless  => "${::sophos::install_dir}/bin/savconfig query LiveProtection | /bin/grep enabled"
								} 
	      }
	
	      if ( $::sophos::settings['enable_onstart'] == true ){
	        exec { "${module_name}-enable_onstart":
	                cwd    =>  "${::sophos::install_dir}/bin",
	                command => "${::sophos::install_dir}/bin/savconfig set EnableOnStart true",
	                unless  => "${::sophos::install_dir}/bin/savconfig query EnableOnStart | /bin/grep true"
	              } 
	      }
	      
	      if ( $::sophos::settings['enable_notifyonupdate'] == true ){
	        exec { "${module_name}-enable_notifyonupdate":
	                cwd    =>  "${::sophos::install_dir}/bin",
	                command => "${::sophos::install_dir}/bin/savconfig set NotifyOnUpdate true",
	                unless  => "${::sophos::install_dir}/bin/savconfig query NotifyOnUpdate | /bin/grep true"
	              } 
	      }
	      
	      exec { "${module_name}-update_period_minutes":
	                cwd    =>  "${::sophos::install_dir}/bin",
	                command => "${::sophos::install_dir}/bin/savconfig set UpdatePeriodMinutes ${sophos::settings['update_period_minutes']}",
	                unless  => "${::sophos::install_dir}/bin/savconfig query UpdatePeriodMinutes | /bin/grep ${sophos::settings['update_period_minutes']}" 
	           }
	           
	     if ( $::sophos::settings['setup_weekly_job'] == true ){
	        $so_jobs_dir      = "${sophos::settings['weekly_job_settings']['sophos_jobs_dir']}"
	        $so_weekjob_file  = "${sophos::settings['weekly_job_settings']['sophos_jobs_dir']}/${sophos::settings['weekly_job_settings']['sophos_weekly_file']}"
	
					ensure_resource ( 'file',
														$so_jobs_dir,
														{'ensure' => 'directory',}
												   )
												   
	        file { "${so_weekjob_file}":
	          content => template('sophos/weekly_job.erb'),
	          mode    => '0600',
	          require => File["${so_jobs_dir}"]
	        }
	        
	        exec { "${module_name}-setup_weekly_job":
	                cwd    =>  "${::sophos::install_dir}/bin",
	                command => "${::sophos::install_dir}/bin/savconfig add NamedScans weekly ${so_weekjob_file}",
	                unless  => "${::sophos::install_dir}/bin/savconfig query NamedScans | /bin/grep weekly",
	                require => File["$so_weekjob_file"]
	              } 
	      }
	      
	      if ( $::sophos::settings['enable_email_always'] == true ){
	        exec { "${module_name}-enable_email_always":
	                cwd    =>  "${::sophos::install_dir}/bin",
	                command => "${::sophos::install_dir}/bin/savconfig set EmailDemandSummaryAlways true",
	                unless  => "${::sophos::install_dir}/bin/savconfig query EmailDemandSummaryAlways | /bin/grep true" 
	              } 
	      }
	    }
	    default: {
	      fail("${::operatingsystem} not supported")
	    }
	  }
	}  
}
