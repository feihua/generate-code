export interface Add{{.JavaName}}Param {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}

export interface Delete{{.JavaName}}Param {
  ids: number[]; //编号
}

export interface Update{{.JavaName}}Param {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}

}

export interface Update{{.JavaName}}StatusParam {
  ids: number[]; //编号
  status?: number; //状态(0：禁用，1：启用)
}

export interface QueryList{{.JavaName}}Param {
  current?: number;
  pageSize?: number;
{{range .TableColumn}}{{.JavaName}}?: {{.TsType}}; //{{.ColumnComment}}
{{end}}

}


export interface {{.JavaName}}RecordRes {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}

}
