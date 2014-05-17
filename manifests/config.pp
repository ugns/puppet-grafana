# == Class grafana::config
#
# This class is called from grafana
#
class grafana::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  File {
    owner => $grafana::user,
    group => $grafana::group,
    mode  => '0644',
  }

  file { "${grafana::install_dir}/grafana-${grafana::version}/config.js":
    ensure  => present,
    content => template('grafana/config.js.erb'),
    require => Staging::Deploy["grafana-${grafana::version}.tar.gz"],
  }

  if $grafana::symlink {
    file { "${grafana::install_dir}/${grafana::symlink_name}":
      ensure  => link,
      target  => "${grafana::install_dir}/grafana-${grafana::version}",
      require => Staging::Deploy["grafana-${grafana::version}.tar.gz"],
    }
  }
}
