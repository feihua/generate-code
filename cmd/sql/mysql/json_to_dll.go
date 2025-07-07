package mysql

import (
	"encoding/json"
	"fmt"
	"github.com/feihua/generate-code/utils"
	"io/ioutil"
	"reflect"
	"sort"
	"strconv"
	"strings"
	"time"
)

// ColumnInfo 存储列信息
type ColumnInfo struct {
	Name     string
	DataType string
	NotNull  bool
	Comment  string
}

// JSONToDDL 结构体用于处理JSON到DDL的转换
type JSONToDDL struct {
	TableName string
	Columns   map[string]*ColumnInfo
}

// NewJSONToDDL 创建一个新的JSONToDDL实例
func NewJSONToDDL(tableName string) *JSONToDDL {
	return &JSONToDDL{
		TableName: tableName,
		Columns:   make(map[string]*ColumnInfo),
	}
}

// AnalyzeJSON 分析JSON结构
func (j *JSONToDDL) AnalyzeJSON(jsonStr string) error {
	var data interface{}
	err := json.Unmarshal([]byte(jsonStr), &data)
	if err != nil {
		return fmt.Errorf("解析JSON失败: %v", err)
	}

	// 处理单个对象
	if obj, ok := data.(map[string]interface{}); ok {
		j.analyzeObject(obj)
		return nil
	}

	// 处理对象数组
	if arr, ok := data.([]interface{}); ok {
		for _, item := range arr {
			if obj, ok := item.(map[string]interface{}); ok {
				j.analyzeObject(obj)
			}
		}
		return nil
	}

	return fmt.Errorf("不支持的JSON格式，请提供对象或对象数组")
}

// analyzeObject 分析单个JSON对象
func (j *JSONToDDL) analyzeObject(obj map[string]interface{}) {
	for key, value := range obj {
		columnName := j.sanitizeColumnName(key)
		dataType := j.inferDataType(value)
		notNull := value != nil

		// 如果列已存在，更新数据类型（选择更宽泛的类型）
		if existingCol, exists := j.Columns[columnName]; exists {
			existingCol.DataType = j.mergeDataTypes(existingCol.DataType, dataType)
			existingCol.NotNull = existingCol.NotNull && notNull
		} else {
			j.Columns[columnName] = &ColumnInfo{
				Name:     utils.CamelToSnake(columnName),
				DataType: dataType,
				NotNull:  notNull,
				Comment:  fmt.Sprintf("字段: %s", key),
			}
		}
	}
}

// sanitizeColumnName 清理列名，确保符合SQL标准
func (j *JSONToDDL) sanitizeColumnName(name string) string {
	// 替换特殊字符为下划线
	result := strings.ReplaceAll(name, "-", "_")
	result = strings.ReplaceAll(result, " ", "_")
	result = strings.ReplaceAll(result, ".", "_")

	// 如果以数字开头，添加前缀
	if len(result) > 0 && result[0] >= '0' && result[0] <= '9' {
		result = "col_" + result
	}

	return result
}

// inferDataType 推断数据类型
func (j *JSONToDDL) inferDataType(value interface{}) string {
	if value == nil {
		return "VARCHAR(255)"
	}

	v := reflect.ValueOf(value)
	switch v.Kind() {
	case reflect.String:
		strVal := value.(string)
		strLen := len(strVal)

		// 检查是否是日期时间格式
		if j.isDateTime(strVal) {
			return "DATETIME"
		}

		// 检查是否是日期格式
		if j.isDate(strVal) {
			return "DATE"
		}

		// 检查是否是时间格式
		if j.isTime(strVal) {
			return "TIME"
		}

		// 根据长度选择字符串类型
		if strLen <= 50 {
			return "VARCHAR(50)"
		} else if strLen <= 255 {
			return "VARCHAR(255)"
		} else if strLen <= 1000 {
			return "VARCHAR(1000)"
		} else {
			return "TEXT"
		}

	case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32:
		return "INT"

	case reflect.Int64:
		return "BIGINT"

	case reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64:
		return "BIGINT UNSIGNED"

	case reflect.Float32:
		return "FLOAT"

	case reflect.Float64:
		// 检查是否是整数值的浮点数
		floatVal := value.(float64)
		if floatVal == float64(int64(floatVal)) {
			if floatVal >= -2147483648 && floatVal <= 2147483647 {
				return "INT"
			}
			return "BIGINT"
		}
		return "DOUBLE"

	case reflect.Bool:
		return "BOOLEAN"

	case reflect.Slice, reflect.Array:
		return "JSON"

	case reflect.Map:
		return "JSON"

	default:
		return "JSON"
	}
}

// isDateTime 检查字符串是否是日期时间格式
func (j *JSONToDDL) isDateTime(s string) bool {
	dateTimeFormats := []string{
		"2006-01-02 15:04:05",
		"2006-01-02T15:04:05Z",
		"2006-01-02T15:04:05.000Z",
		"2006-01-02T15:04:05+08:00",
	}

	for _, format := range dateTimeFormats {
		if _, err := time.Parse(format, s); err == nil {
			return true
		}
	}
	return false
}

// isDate 检查字符串是否是日期格式
func (j *JSONToDDL) isDate(s string) bool {
	dateFormats := []string{
		"2006-01-02",
		"01/02/2006",
		"2006/01/02",
	}

	for _, format := range dateFormats {
		if _, err := time.Parse(format, s); err == nil {
			return true
		}
	}
	return false
}

// isTime 检查字符串是否是时间格式
func (j *JSONToDDL) isTime(s string) bool {
	timeFormats := []string{
		"15:04:05",
		"15:04",
	}

	for _, format := range timeFormats {
		if _, err := time.Parse(format, s); err == nil {
			return true
		}
	}
	return false
}

// mergeDataTypes 合并数据类型，选择更宽泛的类型
func (j *JSONToDDL) mergeDataTypes(type1, type2 string) string {
	// 如果类型相同，直接返回
	if type1 == type2 {
		return type1
	}

	// 数值类型优先级：BIGINT > INT > FLOAT > DOUBLE
	numericTypes := map[string]int{
		"INT":             1,
		"BIGINT":          2,
		"BIGINT UNSIGNED": 2,
		"FLOAT":           3,
		"DOUBLE":          4,
	}

	if priority1, ok1 := numericTypes[type1]; ok1 {
		if priority2, ok2 := numericTypes[type2]; ok2 {
			if priority1 >= priority2 {
				return type1
			}
			return type2
		}
	}

	// 字符串类型优先级：TEXT > VARCHAR(1000) > VARCHAR(255) > VARCHAR(50)
	if strings.HasPrefix(type1, "VARCHAR") && strings.HasPrefix(type2, "VARCHAR") {
		len1 := j.extractVarcharLength(type1)
		len2 := j.extractVarcharLength(type2)
		if len1 >= len2 {
			return type1
		}
		return type2
	}

	// 如果一个是TEXT，另一个是VARCHAR，选择TEXT
	if type1 == "TEXT" || type2 == "TEXT" {
		return "TEXT"
	}

	// 如果一个是JSON，另一个不是，选择JSON
	if type1 == "JSON" || type2 == "JSON" {
		return "JSON"
	}

	// 默认选择VARCHAR(255)
	return "VARCHAR(255)"
}

// extractVarcharLength 提取VARCHAR长度
func (j *JSONToDDL) extractVarcharLength(varcharType string) int {
	start := strings.Index(varcharType, "(")
	end := strings.Index(varcharType, ")")
	if start != -1 && end != -1 && end > start {
		lengthStr := varcharType[start+1 : end]
		if length, err := strconv.Atoi(lengthStr); err == nil {
			return length
		}
	}
	return 0
}

// GenerateDDL 生成DDL语句
func (j *JSONToDDL) GenerateDDL() map[string]*ColumnInfo {

	// 按列名排序
	var columnNames []string
	for name := range j.Columns {
		columnNames = append(columnNames, name)
	}
	sort.Strings(columnNames)

	c := make(map[string]*ColumnInfo)
	for i, n := range columnNames {
		c[strconv.FormatInt(int64(i), 10)] = j.Columns[n]
	}

	return c
}

// GenerateIndexes 生成索引建议
func (j *JSONToDDL) GenerateIndexes() []string {
	var indexes []string

	for _, col := range j.Columns {
		// 为可能的外键字段创建索引
		if strings.HasSuffix(col.Name, "_id") {
			indexName := fmt.Sprintf("idx_%s_%s", j.TableName, col.Name)
			indexSQL := fmt.Sprintf("CREATE INDEX `%s` ON `%s` (`%s`);",
				indexName, j.TableName, col.Name)
			indexes = append(indexes, indexSQL)
		}

		// 为状态字段创建索引
		if strings.Contains(col.Name, "status") || strings.Contains(col.Name, "state") {
			indexName := fmt.Sprintf("idx_%s_%s", j.TableName, col.Name)
			indexSQL := fmt.Sprintf("CREATE INDEX `%s` ON `%s` (`%s`);",
				indexName, j.TableName, col.Name)
			indexes = append(indexes, indexSQL)
		}
	}

	return indexes
}

// readJSONFile 读取JSON文件
func readJSONFile(filename string) (string, error) {
	data, err := ioutil.ReadFile(filename)
	if err != nil {
		return "", fmt.Errorf("读取文件失败: %v", err)
	}
	return string(data), nil
}
