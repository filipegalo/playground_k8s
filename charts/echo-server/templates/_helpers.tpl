{{- define "my-helm-chart.labels" -}}
app: {{ .Chart.Name }}
{{- end -}}