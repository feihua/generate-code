export interface ListParam {
    current?: number;
    pageSize?: number;
{{range .TableColumn}}    {{.JavaName}}?: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}

export interface SearchParam {
{{range .TableColumn}}    {{.JavaName}}?: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}

export interface AddParam {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}

export interface UpdateParam {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}

export interface RecordVo {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}