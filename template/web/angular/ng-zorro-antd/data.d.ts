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

export interface Delete{{.JavaName}}Param {
  ids: number[]; //编号
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

export interface Update{{.JavaName}}StatusParam {
  ids: number[]; //编号
  status?: number; //状态(0：禁用，1：启用)
}

export interface QueryList{{.JavaName}}Param {
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


export interface {{.JavaName}}RecordRes {
{{- range .TableColumn}}
  {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{- end}}

}
