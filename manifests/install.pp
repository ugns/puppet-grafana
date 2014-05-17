# == Class grafana::install
#
class grafana::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if ! defined( staging ) {
    class { 'staging': }
  }

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  staging::deploy { "grafana-${grafana::version}.tar.gz":
    source  => $grafana::download_url,
    target  => $grafana::install_dir,
    user    => $grafana::user,
    group   => $grafana::group,
    creates => "${grafana::install_dir}/grafana-${grafana::version}",
  }
}
