-{{- define "weather.fullname" -}}
-{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
+{{- define "weather.fullname" -}}
+{{- /* Use the Helm release name so each Application gets unique K8s objects */ -}}
+{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
 {{- end -}}
