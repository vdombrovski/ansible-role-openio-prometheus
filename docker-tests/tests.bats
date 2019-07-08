#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

# Tests

@test 'Prometheus listens 9090' {
  run bash -c "curl http://${SUT_IP}:9090/metrics"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'go_goroutines' ]]
}

@test 'Prometheus defaults file exists and is correct' {
  run bash -c "docker exec -ti ${SUT_ID} cat /etc/default/prometheus"
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'storage.tsdb.path=/var/lib/prometheus/data' ]]
}

@test 'Prometheus config file exists' {
  run bash -c "docker exec -ti ${SUT_ID} cat /etc/prometheus/prometheus.yml"
  echo "output: "$output
  [[ "${status}" -eq "0" ]]
}

@test 'Netdata rules are added' {
  run bash -c "docker exec -ti ${SUT_ID} cat /etc/prometheus/targets/netdata.yml"
  echo "output: "$output
  [[ "${status}" -eq "0" ]]
}

@test 'Healthchecks for services defined in inventory are set up' {
    # OIOPROXY
    run bash -c "docker exec -ti ${SUT_ID} grep '${SUT_IP}=>10.0.0.91:6006' /etc/prometheus/targets/blackbox.yml"
    echo "output: "$output
    [[ "${status}" -eq "0" ]]

    # CONSCIENCE
    run bash -c "docker exec -ti ${SUT_ID} grep '${SUT_IP}=>10.0.0.91:6000' /etc/prometheus/targets/blackbox.yml"
    echo "output: "$output
    [[ "${status}" -eq "0" ]]

    # META2
    run bash -c "docker exec -ti ${SUT_ID} grep '${SUT_IP}=>10.0.0.91:6137' /etc/prometheus/targets/blackbox.yml"
    echo "output: "$output
    [[ "${status}" -eq "0" ]]

    # BLACKBOX SELF-CHECK
    run bash -c "docker exec -ti ${SUT_ID} grep '${SUT_IP}=>${SUT_IP}:9115' /etc/prometheus/targets/blackbox.yml"
    echo "output: "$output
    [[ "${status}" -eq "0" ]]

    # ICMP
    run bash -c "docker exec -ti ${SUT_ID} grep '${SUT_IP}=>${SUT_IP}' /etc/prometheus/targets/blackbox.yml"
    echo "output: "$output
    [[ "${status}" -eq "0" ]]
}

@test 'All targets contain valid YAML' {
    run bash -c "docker exec -ti ${SUT_ID} find /etc/prometheus/ -name \*.yml -exec python -c \
    'import sys,yaml; yaml.load(open(sys.argv[1]).read(), Loader=yaml.SafeLoader);' {} \;"
    echo "output: "$output
    [[ "${output}" -eq "" ]]
}
