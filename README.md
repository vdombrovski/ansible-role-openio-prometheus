![picture alt](https://cdn.rawgit.com/fabric8io/fabric8-devops/93ca9bc/prometheus/src/main/fabric8/icon.png "Prometheus")
# Ansible Role Prometheus

static_configs:
- targets: [{{ '"' + job['targets'] | join('","') + '"' }}]


### Variables
prometheus_netdata_enabled
prometheus_netdata_targets
prometheus_netdata_interval

prometheus_blackbox_enabled
prometheus_blackbox_targets
prometheus_blackbox_interval

prometheus_alertmanager_enabled
prometheus_alertmanager_targets
prometheus_alertmanager_interval

prometheus_conf_dir
prometheus_rules_dir
prometheus_alert_dir
prometheus_targets_dir

prometheus_recording_rules

## License

[Apache 2](https://choosealicense.com/licenses/apache-2.0/)

## Author Information

[Haggai Philip Zagury](http://www.tikalk.com/devops/haggai)
