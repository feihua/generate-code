
export interface {{.JavaName}}ListParam {
    current: number;
    pageSize?: number;
{{range .TableColumn}}    {{.JavaName}}?: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}

export interface {{.JavaName}}Vo {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}
