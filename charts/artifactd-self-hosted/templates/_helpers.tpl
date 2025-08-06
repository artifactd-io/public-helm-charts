{{/*
Define the name of the chart/application.
*/}}
{{- define "application.name" -}}
{{- default .Chart.Name .Values.applicationName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden
*/}}
{{- define "application.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride -}}
{{- end -}}


{{/*
Define the version of the chart/application.
*/}}
{{- define "application.version" -}}
  {{- $version := default "" .Values.artifactd.image.tag -}}
  {{- regexReplaceAll "[^a-zA-Z0-9_\\.\\-]" $version "-" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "application.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "application.labels" -}}
helm.sh/chart: {{ include "application.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ include "application.name" . }}
{{- with include "application.version" . }}
app.kubernetes.io/version: {{ quote . }}
{{- end }}
{{- end }}

{{- define "artifactd.labels" -}}
{{- include "application.labels" . }}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.artifactd.name }}
{{- end }}

{{- define "db.labels" -}}
{{- include "application.labels" . }}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.db.name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "artifactd.selectorLabels" -}}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.artifactd.name }}
{{- end }}

{{- define "db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.db.name }}
{{- end }}
