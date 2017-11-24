# == Class docker_compose::install
#
# This class is called from docker_compose for install.
#
class docker_compose::install {

  $dirs = generate ("ls")
  notify {"Result of ls is ${dirs}":}

}
