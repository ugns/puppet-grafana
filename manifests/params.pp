# == Class grafana::params
#
# This class is meant to be called from grafana
# It sets variables according to platform
#
class grafana::params {
  $version            = '1.5.3'
  $download_url       = "http://grafanarel.s3.amazonaws.com/grafana-${version}.tar.gz"
  $install_dir        = '/opt'
  $symlink            = true
  $symlink_name       = 'grafana'
  $graphite_host      = 'localhost'
  $graphite_port      = 80
  $elasticsearch_host = 'localhost'
  $elasticsearch_port = 9200

  case $::osfamily {
    'Debian': {
      $user  = 'www-data'
      $group = 'www-data'
    }
    'RedHat', 'Amazon': {
      $user  = 'apache'
      $group = 'apache'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
