export interface List{{.JavaName}}Param {
    current?: number;
    pageSize?: number;
{{range .TableColumn}}    {{.JavaName}}?: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}

export interface Search{{.JavaName}}Param {
{{range .TableColumn}}    {{.JavaName}}?: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}

export interface Add{{.JavaName}}Param {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}

export interface Update{{.JavaName}}Param {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}

export interface {{.JavaName}}RecordVo {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}