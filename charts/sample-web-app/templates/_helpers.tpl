{{- /*
Common helpers for sample-web-app chart
*/ -}}

{{- define "sample-web-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "sample-web-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sample-web-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "sample-web-app.labels" -}}
{{ include "sample-web-app.selectorLabels" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}