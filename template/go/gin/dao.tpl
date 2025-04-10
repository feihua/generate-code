package {{.ModuleName}}

import (
	"{{.ProjectName}}/internal/dto/{{.ModuleName}}"
	m "{{.ProjectName}}/internal/model/{{.ModuleName}}"
	"gorm.io/gorm"
)

type {{.JavaName}}Dao struct {
	db *gorm.DB
}

func New{{.JavaName}}Dao(DB *gorm.DB) *{{.JavaName}}Dao {
	return &{{.JavaName}}Dao{
		db: DB,
	}
}

// Create{{.JavaName}} 添加{{.Comment}}
func (b {{.JavaName}}Dao) Create{{.JavaName}}(dto {{.ModuleName}}.Add{{.JavaName}}Dto) error {
	item := m.{{.JavaName}}{
    {{- range .TableColumn}}
    {{- if isContain .GoNamePublic "CreateTime"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else }}
        {{.GoNamePublic}}:dto.{{.GoNamePublic}}, //{{.ColumnComment}}
    {{- end}}
    {{- end}}

	}

	return b.db.Create(&item).Error
}

// Delete{{.JavaName}}ByIds 根据id删除{{.Comment}}
func (b {{.JavaName}}Dao) Delete{{.JavaName}}ByIds(ids []int64) error {
	return b.db.Where("id in (?)", ids).Delete(&m.{{.JavaName}}{}).Error
}

// Update{{.JavaName}} 更新{{.Comment}}
func (b {{.JavaName}}Dao) Update{{.JavaName}}(dto {{.ModuleName}}.Update{{.JavaName}}Dto) error {

	item := m.{{.JavaName}}{
    {{- range .TableColumn}}
    {{- if isContain .GoNamePublic "UpdateTime"}}
        {{.GoNamePublic}}: &dto.{{.GoNamePublic}}, //{{.ColumnComment}}
    {{- else }}
        {{.GoNamePublic}}: dto.{{.GoNamePublic}}, //{{.ColumnComment}}
    {{- end}}
    {{- end}}

	}

	return b.db.Updates(&item).Error
}

// Update{{.JavaName}}Status 更新{{.Comment}}状态
func (b {{.JavaName}}Dao) Update{{.JavaName}}Status(dto {{.ModuleName}}.Update{{.JavaName}}StatusDto) error {

	return b.db.Model(&m.Dept{}).Where("id in (?)", dto.Ids).Update("status", dto.Status).Error
}


// Query{{.JavaName}}Detail 查询{{.Comment}}详情
func (b {{.JavaName}}Dao) Query{{.JavaName}}Detail(dto {{.ModuleName}}.Query{{.JavaName}}DetailDto) (m.{{.JavaName}}, error) {
	var item m.{{.JavaName}}
	err := b.db.Where("id = ?", dto.Id).First(&item).Error
	return item, err
}

// Query{{.JavaName}}ById 根据id查询{{.Comment}}详情
func (b {{.JavaName}}Dao) Query{{.JavaName}}ById(id int64) (m.{{.JavaName}}, error) {
	var item m.{{.JavaName}}
	err := b.db.Where("id = ?", id).First(&item).Error
	return item, err
}

// Query{{.JavaName}}List 查询{{.Comment}}列表
func (b {{.JavaName}}Dao) Query{{.JavaName}}List(dto {{.ModuleName}}.Query{{.JavaName}}ListDto) ([]m.{{.JavaName}}, int64) {
	pageNo := dto.PageNo
	pageSize := dto.PageSize

	var total int64 = 0
	var list []m.{{.JavaName}}
	tx := b.db.Model(&m.{{.JavaName}}{})

	{{- range .TableColumn}}
	{{- if isContain .GoNamePublic "Create"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "Sort"}}
	{{- else if eq .GoType "time.Time"}}
	{{- else if eq .GoType "string"}}
	if len(dto.{{.GoNamePublic}}) > 0 {
        tx.Where("{{.ColumnName}} like %?%", dto.{{.GoNamePublic}}) //{{.ColumnComment}}
    }
    {{- else}}
	if dto.{{.GoNamePublic}} != 2 {
        tx.Where("{{.ColumnName}}=?", dto.{{.GoNamePublic}}) //{{.ColumnComment}}
    }
	{{- end}}
	{{- end}}
	tx.Limit(pageSize).Offset((pageNo - 1) * pageSize).Find(&list)

	tx.Count(&total)
	return list, total
}


