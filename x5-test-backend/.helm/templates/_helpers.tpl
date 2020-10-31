{{/*
Expand the name of the chart.
*/}}
{{- define "x5-test-backend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "x5-test-backend.fullname" -}}
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
{{- define "x5-test-backend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "x5-test-backend.labels" -}}
helm.sh/chart: {{ include "x5-test-backend.chart" . }}
{{ include "x5-test-backend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "x5-test-backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "x5-test-backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels for nginx-cert
*/}}
{{- define "x5-test-backend.nginx-cert.labels" -}}
helm.sh/chart: {{ include "x5-test-backend.chart" . }}
{{ include "x5-test-backend.nginx-cert.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for nginx-cert
*/}}
{{- define "x5-test-backend.nginx-cert.selectorLabels" -}}
app.kubernetes.io/name: {{ include "x5-test-backend.name" . }}-nginx-cert
app.kubernetes.io/instance: {{ .Release.Name }}-nginx-cert
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "x5-test-backend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "x5-test-backend.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Return the Database connection type
*/}}
{{- define "x5-test-backend.databaseConnection" -}}
{{ "pgsql" }}
{{- end }}

{{/*
Return the Postgresql Hostname
*/}}
{{- define "x5-test-backend.databaseHost" -}}
{{- if .Values.postgresql.enabled }}
{{- printf "%s" .Values.postgresql.fullnameOverride }}
{{- end }}
{{- end }}

{{/*
Return the Postgresql Port
*/}}
{{- define "x5-test-backend.databasePort" -}}
{{- if .Values.postgresql.enabled }}
{{- printf "5432" }}
{{- end }}
{{- end }}

{{/*
Return the Postgresql Database Name
*/}}
{{- define "x5-test-backend.databaseName" -}}
{{- if .Values.postgresql.enabled }}
{{- printf "%s" .Values.postgresql.postgresqlDatabase }}
{{- end }}
{{- end }}

{{/*
Return the Postgresql User
*/}}
{{- define "x5-test-backend.databaseUser" -}}
{{- if .Values.postgresql.enabled }}
{{- printf "%s" .Values.postgresql.postgresqlUsername }}
{{- end }}
{{- end }}

{{/*
Return the Postgresql Secret Name
*/}}
{{- define "x5-test-backend.databaseSecretName" -}}
{{- if .Values.postgresql.enabled }}
{{- printf "%s" .Values.postgresql.fullnameOverride }}
{{- end }}
{{- end }}