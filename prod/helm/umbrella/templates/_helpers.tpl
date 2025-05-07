{{/* helpers only -- no Kubernetes yaml here */}}

{{- define "weather.fullname" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
