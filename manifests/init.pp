# == Class: grafana
#
# Full description of class grafana here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class grafana (
  $version            = $grafana::params::version,
  $download_url       = $grafana::params::download_url,
  $install_dir        = $grafana::params::install_dir,
  $symlink            = $grafana::params::symlink,
  $symlink_name       = $grafana::params::symlink_name,
  $user               = $grafana::params::user,
  $group              = $grafana::params::group,
  $graphite_host      = $grafana::params::graphite_host,
  $graphite_port      = $grafana::params::graphite_port,
  $elasticsearch_host = $grafana::params::elasticsearch_host,
  $elasticsearch_port = $grafana::params::elasticsearch_port,
) inherits grafana::params {

  # validate parameters here

  class { 'grafana::install': } ->
  class { 'grafana::config': } ->
  Class['grafana']
}
