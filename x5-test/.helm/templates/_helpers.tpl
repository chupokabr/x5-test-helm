{{/*
Expand the name of the chart.
*/}}
{{- define "x5-test.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "x5-test.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "x5-test.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "x5-test.labels" -}}
helm.sh/chart: {{ include "x5-test.chart" . }}
{{ include "x5-test.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "x5-test.selectorLabels" -}}
app.kubernetes.io/name: {{ include "x5-test.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "x5-test.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "x5-test.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Return the Mongo Hostname
*/}}
{{- define "x5-test.mongoHost" -}}
{{- if .Values.mongodb.enabled }}
{{- printf "%s" .Values.mongodb.fullnameOverride }}
{{- end }}
{{- end }}

{{/*
Return the Redis Hostname
*/}}
{{- define "x5-test.redisHost" -}}
{{- if .Values.redis.enabled }}
{{- printf "%s-headless" .Values.redis.fullnameOverride }}
{{- end }}
{{- end }}

{{/*
Selector labels for nginx-cert
*/}}
{{- define "x5-test.nginx-cert.labels" -}}
helm.sh/chart: {{ include "x5-test.chart" . }}
{{ include "x5-test.nginx-cert.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for nginx-cert
*/}}
{{- define "x5-test.nginx-cert.selectorLabels" -}}
app.kubernetes.io/name: {{ include "x5-test.name" . }}-nginx-cert
app.kubernetes.io/instance: {{ .Release.Name }}-nginx-cert
{{- end }}
