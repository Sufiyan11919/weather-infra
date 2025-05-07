{{/* -------------------------------------------------------------------
   Helper definitions for the chart
------------------------------------------------------------------- */}}

{{- define "weather.fullname" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
