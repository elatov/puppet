class update_checker::install {
  if ($update_checker::packages != undef) {
    ensure_packages ($update_checker::packages,{ 'ensure'=> 'present' })
  }
}