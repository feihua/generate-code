export interface {{.JavaName}}ListItem {
{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}

export interface {{.JavaName}}ListPagination {
  total: number;
  pageSize: number;
  current: number;
}

export interface {{.JavaName}}ListData {
  list: {{.JavaName}}ListItem[];
  pagination: Partial<{{.JavaName}}ListPagination>;
}

export interface {{.JavaName}}ListParams {
{{range .TableColumn}}    {{.JavaName}}?: {{.TsType}}; //{{.ColumnComment}}
{{end}}
    pageSize?: number;
    current?: number;
    filter?: { [key: string]: any[] };
    sorter?: { [key: string]: any };

}
