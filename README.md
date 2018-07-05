![picture alt](https://cdn.rawgit.com/fabric8io/fabric8-devops/93ca9bc/prometheus/src/main/fabric8/icon.png "Prometheus")
# Ansible Role Prometheus [![Build Status](https://travis-ci.org/vdombrovski/ansible-role-prometheus.svg?branch=alertmanager)](https://travis-ci.org/vdombrovski/ansible-role-prometheus)


### Variables

#### Groups and Network
| Variable                   | Description                                       | Type   |
| -------------------------- | ------------------------------------------------- | ------ |
| prometheus_blackbox_group  | Ansible group containing all health checked nodes | string |
| prometheus_admin_group     | Ansible group containing the admin machine        | string |

#### Global
| Variable                     | Description                                | Type    |
| ---------------------------- | ------------------------------------------ | ------- |
| prometheus_listen_ip         | IP address on which Prometheus will listen | string  |
| prometheus_listen_port       | Port on which Prometheus will listen       | integer |
| prometheus_storage_retention | How much time to keep data in Prometheus   | string  |
| prometheus_loglevel          | Prometheus log level                       | string  |
| prometheus_user              | Prometheus Linux User                      | string  |
| prometheus_group             | Prometheus Linux Group                     | string  |
| prometheus_version           | Version of Prometheus to run               | string  |

#### Directories
| Variable                | Description                             | Type   |
| ----------------------- | --------------------------------------- | ------ |
| prometheus_storage_path | Path to the metric storage directory    | string |
| prometheus_conf_dir     | Path to the configuration directory     | string |


#### Collection: netdata
| Variable                    | Description                                   | Type    |
| --------------------------- | --------------------------------------------- | ------- |
| prometheus_netdata_enabled  | Whether to enable scraping of netdata targets | boolean |
| prometheus_netdata_interval | Interval at which netdata targets are scraped | string  |
| prometheus_netdata_targets  | List of IP:PORT of netdata targets to monitor | list    |

#### Collection: blackbox
| Variable                          | Description                                      | Type    |
| --------------------------------- | ------------------------------------------------ | ------- |
| prometheus_blackbox_enabled       | Enable health checks                             | boolean |
| prometheus_blackbox_iface         | Network interface of the health checked nodes    | string  |
| prometheus_blackbox_admin_iface   | Network interface of the admin nodes             | string  |
| prometheus_blackbox_zk_port_regex | Regex to use to determine Zookeeper client ports | string  |
| prometheus_blackbox_port          | Port to deploy blackbox exporter on              | integer |
| prometheus_blackbox_interval      | Interval at which health checks are scraped      | string  |

#### Metric aggregation
| Variable                     | Description                     | Type |
| ---------------------------- | ------------------------------- | ---- |
| prometheus_aggregation_rules | Metric aggregation definitions* | list |

#### Alert generation
| Variable                                 | Description                                                                                | Type    |
| ---------------------------------------- | ------------------------------------------------------------------------------------------ | ------- |
| prometheus_alert_sla_default_medium      | Percentage of operational services below which an SLA warning is emitted                   | integer |
| prometheus_alert_sla_levels_medium       | Per service definition of the above                                                        | dict    |
| prometheus_alert_instance_default_medium | Percentage of operational services below which an insufficient instance warning is emitted | integer |
| prometheus_alert_instance_levels_medium  | Per service definition of the above                                                        | dict    |
| prometheus_alert_sla_default_high        | Percentage of operational services below which an SLA alert is emitted                     | integer |
| prometheus_alert_sla_levels_high         | Per service definition of the above                                                        | dict    |
| prometheus_alert_instance_default_high   | Percentage of operational services below which an insufficient instance alert is emitted   | integer |
| prometheus_alert_instance_levels_high    | Per service definition of the above                                                        | dict    |

#### Alert forwarding (WIP)
| Variable                         | Description                         | Type   |
| -------------------------------- | ----------------------------------- | ------ |
| prometheus_alertmanager_enabled  | Enable alert forwarding             | string |
| prometheus_alertmanager_interval | Interval at which to forward alerts | string |
| prometheus_alertmanager_targets  | Prometheus alertmanager targets     | list   |

### Example Inventory

```ini
[admin]
127.0.0.1

[admin:vars]
ansible_connection=local
```

### Example playbook
```yaml
---
- hosts: localhost
  become: true
  roles:
    - role: ansible-role-prometheus
...
```

## License

[Apache 2](https://choosealicense.com/licenses/apache-2.0/)

## Author Information

Vladimir DOMBROVSKI <vladimir@openio.io> (Maintainer)
[Haggai Philip Zagury](http://www.tikalk.com/devops/haggai)
