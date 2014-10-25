# == Class atomic::settings
#
# This class is called from atomic::config
#
define atomic::settings (
    $key            = $title,
    $settings_hash  = {},
    $config_file    = 'file.conf',
) {
  
  validate_hash($settings_hash)  
  $value = $settings_hash[$key]
  validate_string($value)
  
  augeas{"${module_name}_setting_${key}":
    incl    => "${config_file}", 
    lens    => 'Yum.lns',
    context => "/files${config_file}",
    changes => "set atomic/${key} '${value}'",
    onlyif  => "match atomic/${key} not_include '${value}'",
  }
   
#  if is_array($value){
##    $size           = size($value)
##    $array_index  = $size -1
#    $array_size = size($atomic::params::atomic_settings[$key])
##    $aug_index = $array_index + 1
#    
#    if $array_index <= $array_size {
#      $val = $value[$array_index -1]
#      
#			augeas{"atomic_setting_${key}_${val}":
#				incl    => "${config_file}", 
#				lens    => 'Yum.lns',
#				context => "/files${config_file}",
#				changes => "set atomic/${key}[${array_index}] $val",
#				onlyif  => "match atomic/${key}[${array_index}] not_include $val",
#			}
##      notify {"print key: ${key} ${array_index}":}
##      
##      $karim = $value[$array_index - 1]
##      
##      notify {"print actual value: ${karim}":}
##
#			$increment= inline_template('<%= @array_index.to_i + 1 %>')
#      
#      atomic::settings{ "settings-${array_index}":
#        key         => $key,
#        array_index => $increment,
#      }
#    }
#    #notify {"size of array is $size":}
#  }
#  
	
}