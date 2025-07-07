package postgresql

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
	TableName string
	Name      string
	DataType  string
	NotNull   bool
	Comment   string
}

// JSONToPostgreSQLDDL 结构体用于处理JSON到PostgreSQL DDL的转换
type JSONToPostgreSQLDDL struct {
	TableName string
	Columns   map[string]*ColumnInfo
}

// NewJSONToPostgreSQLDDL 创建一个新的JSONToPostgreSQLDDL实例
func NewJSONToPostgreSQLDDL(tableName string) *JSONToPostgreSQLDDL {
	return &JSONToPostgreSQLDDL{
		TableName: strings.ToLower(tableName), // PostgreSQL表名通常小写
		Columns:   make(map[string]*ColumnInfo),
	}
}

// AnalyzeJSON 分析JSON结构
func (j *JSONToPostgreSQLDDL) AnalyzeJSON(jsonStr string) error {
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
func (j *JSONToPostgreSQLDDL) analyzeObject(obj map[string]interface{}) {
	for key, value := range obj {
		columnName := j.sanitizeColumnName(key)
		dataType := j.inferPostgreSQLDataType(value)
		notNull := value != nil

		// 如果列已存在，更新数据类型（选择更宽泛的类型）
		if existingCol, exists := j.Columns[columnName]; exists {
			existingCol.DataType = j.mergePostgreSQLDataTypes(existingCol.DataType, dataType)
			existingCol.NotNull = existingCol.NotNull && notNull
		} else {
			j.Columns[columnName] = &ColumnInfo{
				TableName: j.TableName,
				Name:      utils.CamelToSnake(columnName),
				DataType:  dataType,
				NotNull:   notNull,
				Comment:   fmt.Sprintf("字段: %s", key),
			}
		}
	}
}

// sanitizeColumnName 清理列名，确保符合PostgreSQL标准
func (j *JSONToPostgreSQLDDL) sanitizeColumnName(name string) string {
	// PostgreSQL列名转换为小写
	// result := strings.ToLower(name)
	result := name

	// 替换特殊字符为下划线
	result = strings.ReplaceAll(result, "-", "_")
	result = strings.ReplaceAll(result, " ", "_")
	result = strings.ReplaceAll(result, ".", "_")

	// 如果以数字开头，添加前缀
	if len(result) > 0 && result[0] >= '0' && result[0] <= '9' {
		result = "col_" + result
	}

	// PostgreSQL列名长度限制为63个字符
	if len(result) > 63 {
		result = result[:63]
	}

	return result
}

// inferPostgreSQLDataType 推断PostgreSQL数据类型
func (j *JSONToPostgreSQLDDL) inferPostgreSQLDataType(value interface{}) string {
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
			return "TIMESTAMP"
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
		return "INTEGER"

	case reflect.Int64:
		return "BIGINT"

	case reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64:
		return "BIGINT"

	case reflect.Float32:
		return "REAL"

	case reflect.Float64:
		// 检查是否是整数值的浮点数
		floatVal := value.(float64)
		if floatVal == float64(int64(floatVal)) {
			if floatVal >= -2147483648 && floatVal <= 2147483647 {
				return "INTEGER"
			}
			return "BIGINT"
		}
		return "DOUBLE PRECISION"

	case reflect.Bool:
		return "BOOLEAN"

	case reflect.Slice, reflect.Array:
		return "JSONB" // PostgreSQL原生支持JSONB

	case reflect.Map:
		return "JSONB"

	default:
		return "JSONB"
	}
}

// isDateTime 检查字符串是否是日期时间格式
func (j *JSONToPostgreSQLDDL) isDateTime(s string) bool {
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
func (j *JSONToPostgreSQLDDL) isDate(s string) bool {
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
func (j *JSONToPostgreSQLDDL) isTime(s string) bool {
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

// mergePostgreSQLDataTypes 合并PostgreSQL数据类型，选择更宽泛的类型
func (j *JSONToPostgreSQLDDL) mergePostgreSQLDataTypes(type1, type2 string) string {
	// 如果类型相同，直接返回
	if type1 == type2 {
		return type1
	}

	// 数值类型优先级：DOUBLE PRECISION > REAL > BIGINT > INTEGER
	numericTypes := map[string]int{
		"INTEGER":          1,
		"BIGINT":           2,
		"REAL":             3,
		"DOUBLE PRECISION": 4,
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

	// 如果一个是JSONB，另一个不是，选择JSONB
	if type1 == "JSONB" || type2 == "JSONB" {
		return "JSONB"
	}

	// 时间类型优先级：TIMESTAMP > DATE > TIME
	timeTypes := map[string]int{
		"TIME":      1,
		"DATE":      2,
		"TIMESTAMP": 3,
	}

	if priority1, ok1 := timeTypes[type1]; ok1 {
		if priority2, ok2 := timeTypes[type2]; ok2 {
			if priority1 >= priority2 {
				return type1
			}
			return type2
		}
	}

	// 默认选择VARCHAR(255)
	return "VARCHAR(255)"
}

// extractVarcharLength 提取VARCHAR长度
func (j *JSONToPostgreSQLDDL) extractVarcharLength(varcharType string) int {
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

// GeneratePostgreSQLDDL 生成PostgreSQL DDL语句
func (j *JSONToPostgreSQLDDL) GeneratePostgreSQLDDL() map[string]*ColumnInfo {

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

// GeneratePostgreSQLIndexes 生成PostgreSQL索引建议
func (j *JSONToPostgreSQLDDL) GeneratePostgreSQLIndexes() []string {
	var indexes []string

	for _, col := range j.Columns {
		// 为可能的外键字段创建索引
		if strings.HasSuffix(col.Name, "_id") {
			indexName := fmt.Sprintf("idx_%s_%s", j.TableName, col.Name)
			// PostgreSQL索引名长度限制为63个字符
			if len(indexName) > 63 {
				indexName = indexName[:63]
			}
			indexSQL := fmt.Sprintf("CREATE INDEX %s ON %s (%s);", indexName, j.TableName, col.Name)
			indexes = append(indexes, indexSQL)
		}

		// 为状态字段创建索引
		if strings.Contains(col.Name, "status") || strings.Contains(col.Name, "state") {
			indexName := fmt.Sprintf("idx_%s_%s", j.TableName, col.Name)
			if len(indexName) > 63 {
				indexName = indexName[:63]
			}
			indexSQL := fmt.Sprintf("CREATE INDEX %s ON %s (%s);", indexName, j.TableName, col.Name)
			indexes = append(indexes, indexSQL)
		}

		// 为JSONB字段创建GIN索引
		if col.DataType == "JSONB" {
			indexName := fmt.Sprintf("idx_%s_%s_gin", j.TableName, col.Name)
			if len(indexName) > 63 {
				indexName = indexName[:63]
			}
			indexSQL := fmt.Sprintf("CREATE INDEX %s ON %s USING GIN (%s);", indexName, j.TableName, col.Name)
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
