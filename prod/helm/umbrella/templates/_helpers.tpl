{{/* ─────────────────────────────────────────────────────────────
     Shared helpers for the weather-umbrella chart
────────────────────────────────────────────────────────────────*/}}

{{/* Return a release-wide, DNS-safe name */}}
{{- define "weather.fullname" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ──────────────────────────
     Ingress (ALB) when enabled
──────────────────────────*/}}
{{- if .Values.ingress.enabled }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "weather.fullname" . }}
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/group.name: weather-prod
spec:
  rules:
  - host: {{ .Values.ingress.activeHost }}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: {{ include "weather.fullname" . }}
            port:
              number: {{ .Values.service.port }}
{{- end }}
