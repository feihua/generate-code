package utils

import (
	"fmt"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"strings"
	"unicode"
)

type Table struct {
	OriginalName      string        `json:"table_name" gorm:"column:TABLE_NAME"`       //表名 sys_user
	UpperOriginalName string        ` gorm:"-"`                                        //表名(大写开头) SysUser
	Comment           string        `json:"table_comment" gorm:"column:TABLE_COMMENT"` //表注释 用户表
	TableColumn       []TableColumn ` gorm:"-"`                                        //表的列
	RustName          string        ` gorm:"-"`                                        //rust文件名 user
	GoName            string        ` gorm:"-"`                                        //go的文件名 user
	JavaName          string        ` gorm:"-"`                                        //java文件名 User
	LowerJavaName     string        ` gorm:"-"`                                        //java变量(小写开头) user
	ModuleName        string        ` gorm:"-"`                                        //生成gf的时候,模块的名称
	ProjectName       string        ` gorm:"-"`                                        //生成gf的时候,项目的名称
	PackageName       string        ` gorm:"-"`                                        //生成java的时候,包的名称
	Author            string        ` gorm:"-"`                                        //生成java的时候,作者的名称
	CreateTime        string        ` gorm:"-"`                                        //生成java代码的时间
	GroupId           string        ` gorm:"-"`                                        //生成java代码的common包目录
	AllColumns        string        ` gorm:"-"`                                        //生成xml的时候用
	RpcClient         string        ` gorm:"-"`                                        //生成grpc的时候用
}

func (model Table) TableName() string {
	return "tables"
}

type TableColumn struct {
	ColumnName    string `json:"ColumnName" gorm:"column:COLUMN_NAME"`       //列名 nick_name
	DataType      string `json:"DataType" gorm:"column:DATA_TYPE"`           //列的数据类型 varchar
	IsNullable    string `json:"IsNullable" gorm:"column:IS_NULLABLE"`       //是否为空  NO
	ColumnKey     string `json:"ColumnKey" gorm:"column:COLUMN_KEY"`         // 索引类型 PRI
	ColumnType    string `json:"ColumnType" gorm:"column:COLUMN_TYPE"`       //列的类型  varchar
	ColumnComment string `json:"ColumnComment" gorm:"column:COLUMN_COMMENT"` //列注释
	RustType      string ` gorm:"-"`                                         //rust字段的类型  String
	GoType        string ` gorm:"-"`                                         //go字段的类型   string
	ProtoType     string ` gorm:"-"`                                         //生成proto的时候用  string
	JavaType      string ` gorm:"-"`                                         //java字段的类型 String
	JdbcType      string ` gorm:"-"`                                         //jdbc字段的类型 String
	TsType        string ` gorm:"-"`                                         //ts字段的类型 string
	RustName      string ` gorm:"-"`                                         //rust字段的名称 nick_name
	GoName        string ` gorm:"-"`                                         //go字段的名称 nick_name
	GoNamePublic  string ` gorm:"-"`                                         //go公开字段的名称 NickName
	JavaName      string ` gorm:"-"`                                         //java字段的名称 nickName
	Sort          int    ` gorm:"-"`                                         //生成proto的时候用
	LowerJavaName string ` gorm:"-"`                                         //java变量(小写开头) user

}

func (model TableColumn) TableName() string {
	return "columns"
}

type DbUtils struct {
}

func New() DbUtils {
	return DbUtils{}
}

// QueryTables 查询表数组
func (DbUtils) QueryTables(dsn string, TableNames string, prefix string) []Table {
	split := strings.Split(dsn, "/")
	s := split[0] + "/information_schema"
	db, err := gorm.Open(mysql.Open(s))
	if err != nil {
		panic(err)
	}

	var t []Table
	db.Where("table_schema = ? and table_name LIKE ?", split[1], TableNames+"%").Find(&t)

	if len(t) == 0 {
		fmt.Println("查询不到表")
		return nil
	}
	var tt []Table
	for _, table := range t {
		trimPrefix := strings.TrimPrefix(table.OriginalName, prefix)
		table.RustName = trimPrefix
		table.GoName = trimPrefix
		table.Comment = strings.Replace(table.Comment, "表", "", -1)
		table.JavaName = UnderScoreToUpperCamelCase(trimPrefix)
		table.LowerJavaName = UnderScoreToLowerCamelCase(trimPrefix)
		table.UpperOriginalName = UnderScoreToUpperCamelCase(table.OriginalName)
		tableColumns, allColumns := QueryTableColumns(dsn, table.OriginalName, UnderScoreToLowerCamelCase(trimPrefix))
		table.TableColumn = tableColumns
		table.AllColumns = allColumns
		tt = append(tt, table)
	}

	fmt.Println(tt)
	return tt
}

// QueryTableColumns 查询表列
func QueryTableColumns(dsn, TableName, lowerJavaName string) ([]TableColumn, string) {
	split := strings.Split(dsn, "/")
	s := split[0] + "/information_schema"
	db, err := gorm.Open(mysql.Open(s))
	if err != nil {
		panic(err)
	}

	var t []TableColumn
	db.Where("table_schema = ? and table_name = ?", split[1], TableName).Find(&t)

	if len(t) == 0 {
		fmt.Println("查询不到表的列")
		return nil, "nil"
	}

	var allColumns string
	var tt []TableColumn
	for i, column := range t {
		column.TsType = TsType[column.DataType]
		column.RustType = ToRustType[column.DataType]
		column.GoType = ToGoType[column.DataType]
		column.ProtoType = ToProtoType[column.DataType]
		column.JavaType = ToJavaType[column.DataType]
		column.JdbcType = ToJdbcType[column.DataType]
		column.RustName = column.ColumnName
		column.GoName = column.ColumnName
		column.GoNamePublic = UnderScoreToUpperCamelCase(column.ColumnName)
		column.JavaName = UnderScoreToLowerCamelCase(column.ColumnName)
		column.LowerJavaName = lowerJavaName
		column.Sort = i + 1
		allColumns = allColumns + column.ColumnName + ", "
		tt = append(tt, column)
	}

	lastIndex := strings.LastIndex(allColumns, ",")
	return tt, allColumns[0:lastIndex]
}

var TsType = map[string]string{
	"int":       "number",
	"tinyint":   "number",
	"smallint":  "number",
	"mediumint": "number",
	"bigint":    "number",
	"bool":      "bool",
	"enum":      "string",
	"set":       "string",
	"varchar":   "string",
	"char":      "string",
	"datetime":  "string",
	"text":      "string",
	"timestamp": "string",
	"decimal":   "number",
}
var ToRustType = map[string]string{
	"int":       "i32",
	"tinyint":   "i32",
	"smallint":  "i32",
	"mediumint": "i32",
	"bigint":    "i32",
	"bool":      "bool",
	"enum":      "String",
	"set":       "String",
	"varchar":   "String",
	"char":      "String",
	"datetime":  "DateTime",
	"text":      "String",
	"timestamp": "DateTime",
	"decimal":   "i32",
}
var ToGoType = map[string]string{
	"int":       "int32",
	"tinyint":   "int32",
	"smallint":  "int32",
	"mediumint": "int64",
	"bigint":    "int64",
	"bool":      "bool",
	"enum":      "string",
	"set":       "string",
	"varchar":   "string",
	"char":      "string",
	"text":      "string",
	"datetime":  "time.Time",
	"timestamp": "time.Time",
	"decimal":   "float64",
}

var ToProtoType = map[string]string{
	"int":       "int32",
	"tinyint":   "int32",
	"smallint":  "int",
	"mediumint": "int64",
	"bigint":    "int64",
	"bool":      "bool",
	"enum":      "string",
	"set":       "string",
	"varchar":   "string",
	"char":      "string",
	"text":      "string",
	"datetime":  "string",
	"date":      "string",
	"timestamp": "string",
	"decimal":   "float",
}

var ToJavaType = map[string]string{
	"int":       "int",
	"tinyint":   "int",
	"smallint":  "int",
	"mediumint": "int",
	"bigint":    "int",
	"bool":      "bool",
	"enum":      "String",
	"set":       "String",
	"varchar":   "String",
	"char":      "String",
	"datetime":  "Date",
	"decimal":   "int",
	"timestamp": "Date",
	"text":      "String",
	"longtext":  "String",
}

var ToJdbcType = map[string]string{
	"int":       "INTEGER",
	"tinyint":   "TINYINT",
	"smallint":  "SMALLINT",
	"integer":   "INTEGER",
	"double":    "DOUBLE",
	"bigint":    "BIGINT",
	"varchar":   "VARCHAR",
	"char":      "CHAR",
	"datetime":  "TIMESTAMP",
	"decimal":   "DECIMAL",
	"timestamp": "TIMESTAMP",
	"text":      "VARCHAR",
	"longtext":  "VARCHAR",
	"date":      "DATE",
	"time":      "TIME",
}

// UnderScoreToUpperCamelCase 下划线单词转为大写驼峰单词
func UnderScoreToUpperCamelCase(s string) string {
	s = strings.Replace(s, "_", " ", -1)
	s = strings.Title(s)
	return strings.Replace(s, " ", "", -1)
}

// UnderScoreToLowerCamelCase 下画线单词转小写驼峰单词
func UnderScoreToLowerCamelCase(s string) string {
	s = UnderScoreToUpperCamelCase(s)
	return string(unicode.ToLower(rune(s[0]))) + s[1:]
}
