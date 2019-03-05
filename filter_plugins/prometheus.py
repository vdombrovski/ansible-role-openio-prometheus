class FilterModule(object):
    def filters(self):
        return {
            'format_alerts': self.format_alerts,
        }

    def _format_rules(self, alerts):
        rules = []
        for rule in alerts:
            new_rule = dict(
                alert=rule["name"],
                expr=rule["query"],
                labels=dict(),
                annotations=dict(
                    details=rule['details'],
                    solutions=rule['solutions']
                )
            )
            new_rule["for"] = rule["duration"]
            labels = dict()
            for k, v in rule["tags"].items():
                if k == "code":
                    labels[k] = v
                else:
                    labels[k] = "{{ $labels.%s }}" % v
            labels["severity"] = rule["severity"]
            new_rule["labels"] = labels

            rules.append(new_rule)
        return rules

    def format_alerts(self, alerts):
        import yaml
        try:
            data = yaml.load(alerts)
        except Exception as e:
            raise Exception(
                "Could not load alerts: invalid yaml format %s" % str(e))
        else:
            try:
                rules = self._format_rules(data)
            except Exception as e:
                raise Exception("Could not parse alerts: %s" % str(e))
            else:
                return yaml.dump(
                    dict(groups=[
                        dict(name="default", rules=rules)
                    ]),
                    default_flow_style=False)
