export interface Add{{.JavaName}}Param {
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else if isContain .JavaName "id"}}
{{- else}}
  {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{- end}}
{{- end}}
}

export interface Update{{.JavaName}}Param {
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else}}
  {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{- end}}
{{- end}}
}

export interface Search{{.JavaName}}Param {
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

export interface List{{.JavaName}}Param {
    current?: number;
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

export interface {{.JavaName}}RecordVo {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}