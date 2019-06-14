![picture alt](https://cdn.rawgit.com/fabric8io/fabric8-devops/93ca9bc/prometheus/src/main/fabric8/icon.png "Prometheus")
# Ansible Role Prometheus [![Build Status](https://travis-ci.org/open-io/ansible-role-openio-prometheus.svg?branch=master)](https://travis-ci.org/open-io/ansible-role-openio-prometheus)

### Description

This role deploys a Prometheus setup, specifically tuned for the monitoring of OpenIO clusters. Below are the currently supported features:
- Netdata metric collection
- Blackbox health check collection
- Metric aggregation
- Alert generation
- Alert forwarding

### Variables

#### Groups and Network
| Variable                     | Description                                | Type    |
| ---------------------------- | ------------------------------------------ | ------- |
| prometheus_systemd_enabled   | Enable service at boot                     | boolean |
| prometheus_systemd_limits    | Limits to setup in systemd unit file       | dict    |
| prometheus_listen_ip         | IP address on which Prometheus will listen | string  |
| prometheus_listen_port       | Port on which Prometheus will listen       | integer |
| prometheus_storage_retention | How much time to keep data in Prometheus   | string  |
| prometheus_loglevel          | Prometheus log level                       | string  |
| prometheus_user              | Prometheus Linux User                      | string  |
| prometheus_group             | Prometheus Linux Group                     | string  |
| prometheus_version           | Version of Prometheus to run               | string  |
| prometheus_storage_path      | Path to the metric storage directory       | string  |
| prometheus_conf_dir          | Path to the configuration directory        | string  |

#### Collection
| Variable                        | Description                                   | Type    |
| ------------------------------- | --------------------------------------------- | ------- |
| prometheus_netdata_enabled      | Whether to enable scraping of netdata targets | boolean |
| prometheus_blackbox_enabled     | Enable health checks                          | boolean |


#### Collection: netdata
| Variable                    | Description                                   | Type    |
| --------------------------- | --------------------------------------------- | ------- |
| prometheus_netdata_interval | Interval at which netdata targets are scraped | string  |
| prometheus_netdata_group    | Ansible inventory netdata group               | string  |

#### Collection: blackbox
| Variable                             | Description                                                                             | Type    |
| ------------------------------------ | --------------------------------------------------------------------------------------- | ------- |
| prometheus_blackbox_iface            | Network interface of the health checked nodes                                           | string  |
| prometheus_blackbox_admin_iface      | Network interface of the admin nodes                                                    | string  |
| prometheus_blackbox_port             | Port to deploy blackbox exporter on                                                     | integer |
| prometheus_blackbox_interval         | Interval at which health checks are scraped                                             | string  |
| prometheus_blackbox_node_admin_iface | Admin Network interface of the health checked nodes (needs to be joinable by the admin) | string  |
| prometheus_blackbox_node_data_iface  | OpenIO Network interface of the health checked nodes (on which OpenIO services listen)  | string  |
| prometheus_monitored_hosts           | List of hostnames of all healthchecked hosts                                            | list    |

#### Collection: alertmanager
| Variable                     | Description              | Type    |
| ---------------------------- | ------------------------ | ------- |
| prometheus_alertmanager_host | Alertmanager listen ip   | string  |
| prometheus_alertmanager_port | Alertmanager listen port | integer |

### Examples

See docker-tests branch.

## License

[Apache 2](https://choosealicense.com/licenses/apache-2.0/)

## Author Information

- Vladimir DOMBROVSKI <vladimir@openio.io> (Maintainer)
- Original contribution by [Haggai Philip Zagury](http://www.tikalk.com/devops/haggai)
