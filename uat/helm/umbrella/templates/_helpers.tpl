{{- /*
Helper template to generate a unique, per-release name.

• Uses .Release.Name so each Argo CD Application
  (weather-api-uat, favourite-api-uat, …) gets its own
  Deployment / Service names and avoids “shared resource” warnings.
*/ -}}

{{- define "weather.fullname" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
