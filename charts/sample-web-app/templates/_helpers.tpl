{{- define "sample-web-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "sample-web-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- .Release.Name }}-{{ .Chart.Name }}-sa
{{- else -}}
{{- .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{- define "sample-web-app.labels" -}}
app: {{ .Chart.Name }}
release: {{ .Release.Name }}
{{- end -}}