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
