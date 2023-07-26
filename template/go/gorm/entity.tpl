package v1

import "time"

type {{.JavaName}} struct {
{{range .TableColumn}}  {{$typeLen :=len .GoType}}{{if gt $typeLen 0}}{{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"`{{else}}{{.GoNamePublic}}{{end}}{{$length :=len .ColumnComment}} {{ if gt $length 0}}//{{.ColumnComment}} {{else}}//{{.GoNamePublic}}{{end}}
{{end}}}

func (model {{.JavaName}}) TableName() string {
	return "{{.OriginalName}}"
}

func Create{{.JavaName}}(users []{{.JavaName}}) error {
	return dal.DB.Create(users).Error
}

func Delete{{.JavaName}}(menuIds []int64) error {
	return dal.DB.Where("id in (?)", menuIds).Delete(&{{.JavaName}}{}).Error
}

func Update{{.JavaName}}(user {{.JavaName}}) error {
	return dal.DB.Updates(user).Error
}

func Query{{.JavaName}}(keyword *string, page, pageSize int64) ([]{{.JavaName}}, int64, error) {
	db := dal.DB.Model({{.JavaName}}{})
	if keyword != nil && len(*keyword) != 0 {
		db = db.Where(dal.DB.Or("name like ?", "%"+*keyword+"%").
			Or("introduce like ?", "%"+*keyword+"%"))
	}
	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}
	var res []{{.JavaName}}
	if err := db.Limit(int(pageSize)).Offset(int(pageSize * (page - 1))).Find(&res).Error; err != nil {
		return nil, 0, err
	}
	return res, total, nil
}