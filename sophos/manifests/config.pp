# == Class sophos::config
#
# This class is called from sophos for service config.
#
class sophos::config {
  if !$sophos::initial_setup {
  
	  case $::osfamily {
	    'Debian': {
	    }
	    'RedHat': {
	      if ( $::sophos::settings['enable_liveprotection'] == true ){
					exec { "${module_name}-enable_livep":
					        cwd    =>  ['"${::sophos::install_dir}"/bin'],
									command => './savconfig set LiveProtection true',
									unless  => './savconfig query LiveProtection | /bin/grep true' 
								} 
	      }
	
	      if ( $::sophos::settings['enable_onstart'] == true ){
	        exec { "${module_name}-enable_onstart":
	                cwd    =>  ['"${::sophos::install_dir}"/bin'],
	                command => './savconfig set EnableOnStart true',
	                unless  => './savconfig query EnableOnStart | /bin/grep true' 
	              } 
	      }
	      
	      if ( $::sophos::settings['enable_notifyonupdate'] == true ){
	        exec { "${module_name}-enable_notifyonupdate":
	                cwd    =>  ['"${::sophos::install_dir}"/bin'],
	                command => './savconfig set NotifyOnUpdate true',
	                unless  => './savconfig query NotifyOnUpdate | /bin/grep true' 
	              } 
	      }
	      
	      exec { "${module_name}-update_period_minutes":
	                cwd    =>  ['"${::sophos::install_dir}"/bin'],
	                command => "./savconfig set UpdatePeriodMinutes ${sophos::settings['enable_liveprotection']}",
	                unless  => "./savconfig query UpdatePeriodMinutes | /bin/grep ${sophos::settings['enable_liveprotection']}" 
	           }
	           
	     if ( $::sophos::settings['setup_weekly_job'] == true ){
	        $so_jobs_dir      = "${sophos::settings['weekly_job_settings']['sophos_jobs_dir']}"
	        $so_weekjob_file  = "${sophos::settings['weekly_job_settings']['sophos_jobs_dir']}/${sophos::settings['weekly_job_settings']['sophos_weekly_file']}"
	
					ensure_resource ( 'file',
														$so_jobs_dir,
														{'ensure' => 'directory',}
												   )
												   
	        file { "${so_weekjob_file}":
	          source  => 'puppet:///modules/sophos/weekly_job.conf',
	          mode    => '0600',
	          require => File["${so_jobs_dir}"]
	        }
	        
	        exec { "${module_name}-setup_weekly_job":
	                cwd    =>  ['"${::sophos::install_dir}"/bin'],
	                command => "./savconfig add NamedScans weekly ${so_weekjob_file}",
	                unless  => './savconfig query NamedScans | /bin/grep weekly',
	                require => File["$so_weekjob_file"]
	              } 
	      }
	      
	      if ( $::sophos::settings['enable_email_always'] == true ){
	        exec { "${module_name}-enable_email_always":
	                cwd    =>  ['"${::sophos::install_dir}"/bin'],
	                command => './savconfig set EmailDemandSummaryAlways true',
	                unless  => './savconfig query EmailDemandSummaryAlways | /bin/grep true' 
	              } 
	      }
	    }
	    default: {
	      fail("${::operatingsystem} not supported")
	    }
	  }
	}  
}
