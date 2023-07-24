package model

type {{.JavaName}}AddInput struct {
{{range .TableColumn}}  {{.GoNamePublic}} {{.GoType}} //{{.ColumnComment}}
{{end}}}

type {{.JavaName}}AddOutput struct {
}

type {{.JavaName}}DeleteInput struct {
	Ids []int `json:"ids"`
}

type {{.JavaName}}DeleteOutput struct {
}

type {{.JavaName}}UpdateInput struct {
{{range .TableColumn}}  {{.GoNamePublic}} {{.GoType}} //{{.ColumnComment}}
{{end}}}

type {{.JavaName}}UpdateOutput struct {
}

type {{.JavaName}}Input struct {
	Id int `json:"id"`
}

type {{.JavaName}}Output struct {
	Record {{.JavaName}}ListOutputItem `json:"record"`
}

type {{.JavaName}}ListInput struct {
	PageNum  int `json:"pageNum"`
	PageSize int `json:"pageSize"`
}

type {{.JavaName}}ListOutput struct {
	List     []{{.JavaName}}ListOutputItem `json:"list"`
	PageNum  int                            `json:"pageNum"`
	PageSize int                            `json:"pageSize"`
	Total    int                            `json:"total"`
}

type {{.JavaName}}ListOutputItem struct {
{{range .TableColumn}}  {{.GoNamePublic}} {{.GoType}} //{{.ColumnComment}}
{{end}}}
