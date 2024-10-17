{{- define "mycharts.labels}}
  labels:
    generator: helm
    deployedby: bansikah
    date: {{ now | htmtDate}}
{{- end }}

apiVersion: v1
kind: Service
metadata:
  name: my-service
  {{- template "mycharts.labels" }}
spec: