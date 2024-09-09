
export interface {{.JavaName}}ListParam {
  current: number;
  pageSize?: number;
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else if isContain .JavaName "Sort"}}
{{- else if isContain .JavaName "sort"}}
{{- else if isContain .JavaName "remark"}}
{{- else if isContain .JavaName "id"}}
{{- else}}
  {{.JavaName}}?: {{.TsType}}; //{{.ColumnComment}}
{{- end}}
{{- end}}
}

export interface {{.JavaName}}Vo {
{{range .TableColumn}}  {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}
