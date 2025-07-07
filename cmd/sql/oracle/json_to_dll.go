package oracle

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

// JSONToOracleDDL 结构体用于处理JSON到Oracle DDL的转换
type JSONToOracleDDL struct {
	TableName string
	Columns   map[string]*ColumnInfo
}

// NewJSONToOracleDDL 创建一个新的JSONToOracleDDL实例
func NewJSONToOracleDDL(tableName string) *JSONToOracleDDL {
	return &JSONToOracleDDL{
		TableName: strings.ToUpper(tableName), // Oracle表名通常大写
		Columns:   make(map[string]*ColumnInfo),
	}
}

// AnalyzeJSON 分析JSON结构
func (j *JSONToOracleDDL) AnalyzeJSON(jsonStr string) error {
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
func (j *JSONToOracleDDL) analyzeObject(obj map[string]interface{}) {
	for key, value := range obj {
		columnName := j.sanitizeColumnName(key)
		dataType := j.inferOracleDataType(value)
		notNull := value != nil

		// 如果列已存在，更新数据类型（选择更宽泛的类型）
		if existingCol, exists := j.Columns[columnName]; exists {
			existingCol.DataType = j.mergeOracleDataTypes(existingCol.DataType, dataType)
			existingCol.NotNull = existingCol.NotNull && notNull
		} else {
			j.Columns[columnName] = &ColumnInfo{
				TableName: j.TableName,
				Name:      columnName,
				DataType:  dataType,
				NotNull:   notNull,
				Comment:   fmt.Sprintf("字段: %s", key),
			}
		}
	}
}

// sanitizeColumnName 清理列名，确保符合Oracle标准
func (j *JSONToOracleDDL) sanitizeColumnName(name string) string {
	// Oracle列名转换为大写
	name = utils.CamelToSnake(name)
	result := strings.ToUpper(name)

	// 替换特殊字符为下划线
	result = strings.ReplaceAll(result, "-", "_")
	result = strings.ReplaceAll(result, " ", "_")
	result = strings.ReplaceAll(result, ".", "_")

	// 如果以数字开头，添加前缀
	if len(result) > 0 && result[0] >= '0' && result[0] <= '9' {
		result = "COL_" + result
	}

	// Oracle列名长度限制为30个字符
	if len(result) > 30 {
		result = result[:30]
	}

	return result
}

// inferOracleDataType 推断Oracle数据类型
func (j *JSONToOracleDDL) inferOracleDataType(value interface{}) string {
	if value == nil {
		return "VARCHAR2(255)"
	}

	v := reflect.ValueOf(value)
	switch v.Kind() {
	case reflect.String:
		strVal := value.(string)
		strLen := len(strVal)

		// 检查是否是日期时间格式
		if j.isDateTime(strVal) {
			return "DATE"
		}

		// 检查是否是日期格式
		if j.isDate(strVal) {
			return "DATE"
		}

		// 检查是否是时间格式
		if j.isTime(strVal) {
			return "TIMESTAMP"
		}

		// 根据长度选择字符串类型
		if strLen <= 50 {
			return "VARCHAR2(50)"
		} else if strLen <= 255 {
			return "VARCHAR2(255)"
		} else if strLen <= 1000 {
			return "VARCHAR2(1000)"
		} else if strLen <= 4000 {
			return "VARCHAR2(4000)"
		} else {
			return "CLOB"
		}

	case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32:
		return "NUMBER(10)"

	case reflect.Int64:
		return "NUMBER(19)"

	case reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64:
		return "NUMBER(20)"

	case reflect.Float32:
		return "NUMBER(7,2)"

	case reflect.Float64:
		// 检查是否是整数值的浮点数
		floatVal := value.(float64)
		if floatVal == float64(int64(floatVal)) {
			if floatVal >= -2147483648 && floatVal <= 2147483647 {
				return "NUMBER(10)"
			}
			return "NUMBER(19)"
		}
		return "NUMBER(15,4)"

	case reflect.Bool:
		return "NUMBER(1)" // Oracle中用NUMBER(1)表示布尔值，0=false, 1=true

	case reflect.Slice, reflect.Array:
		return "CLOB" // Oracle中用CLOB存储JSON

	case reflect.Map:
		return "CLOB"

	default:
		return "CLOB"
	}
}

// isDateTime 检查字符串是否是日期时间格式
func (j *JSONToOracleDDL) isDateTime(s string) bool {
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
func (j *JSONToOracleDDL) isDate(s string) bool {
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
func (j *JSONToOracleDDL) isTime(s string) bool {
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

// mergeOracleDataTypes 合并Oracle数据类型，选择更宽泛的类型
func (j *JSONToOracleDDL) mergeOracleDataTypes(type1, type2 string) string {
	// 如果类型相同，直接返回
	if type1 == type2 {
		return type1
	}

	// NUMBER类型优先级处理
	if strings.HasPrefix(type1, "NUMBER") && strings.HasPrefix(type2, "NUMBER") {
		// 提取精度和标度
		prec1, scale1 := j.extractNumberPrecisionScale(type1)
		prec2, scale2 := j.extractNumberPrecisionScale(type2)

		// 选择更大的精度和标度
		maxPrec := prec1
		if prec2 > maxPrec {
			maxPrec = prec2
		}

		maxScale := scale1
		if scale2 > maxScale {
			maxScale = scale2
		}

		if maxScale > 0 {
			return fmt.Sprintf("NUMBER(%d,%d)", maxPrec, maxScale)
		}
		return fmt.Sprintf("NUMBER(%d)", maxPrec)
	}

	// VARCHAR2类型优先级处理
	if strings.HasPrefix(type1, "VARCHAR2") && strings.HasPrefix(type2, "VARCHAR2") {
		len1 := j.extractVarchar2Length(type1)
		len2 := j.extractVarchar2Length(type2)
		maxLen := len1
		if len2 > maxLen {
			maxLen = len2
		}

		// 如果长度超过4000，使用CLOB
		if maxLen > 4000 {
			return "CLOB"
		}
		return fmt.Sprintf("VARCHAR2(%d)", maxLen)
	}

	// 如果一个是CLOB，另一个是VARCHAR2，选择CLOB
	if type1 == "CLOB" || type2 == "CLOB" {
		return "CLOB"
	}

	// 如果一个是DATE，另一个是TIMESTAMP，选择TIMESTAMP
	if (type1 == "DATE" && type2 == "TIMESTAMP") || (type1 == "TIMESTAMP" && type2 == "DATE") {
		return "TIMESTAMP"
	}

	// 默认选择VARCHAR2(255)
	return "VARCHAR2(255)"
}

// extractNumberPrecisionScale 提取NUMBER的精度和标度
func (j *JSONToOracleDDL) extractNumberPrecisionScale(numberType string) (int, int) {
	start := strings.Index(numberType, "(")
	end := strings.Index(numberType, ")")
	if start == -1 || end == -1 || end <= start {
		return 38, 0 // 默认精度
	}

	params := numberType[start+1 : end]
	parts := strings.Split(params, ",")

	precision := 38
	scale := 0

	if len(parts) >= 1 {
		if p, err := strconv.Atoi(strings.TrimSpace(parts[0])); err == nil {
			precision = p
		}
	}

	if len(parts) >= 2 {
		if s, err := strconv.Atoi(strings.TrimSpace(parts[1])); err == nil {
			scale = s
		}
	}

	return precision, scale
}

// extractVarchar2Length 提取VARCHAR2长度
func (j *JSONToOracleDDL) extractVarchar2Length(varchar2Type string) int {
	start := strings.Index(varchar2Type, "(")
	end := strings.Index(varchar2Type, ")")
	if start != -1 && end != -1 && end > start {
		lengthStr := varchar2Type[start+1 : end]
		if length, err := strconv.Atoi(lengthStr); err == nil {
			return length
		}
	}
	return 255
}

// GenerateOracleDDL 生成Oracle DDL语句
func (j *JSONToOracleDDL) GenerateOracleDDL() map[string]*ColumnInfo {

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

// GenerateOracleIndexes 生成Oracle索引建议
func (j *JSONToOracleDDL) GenerateOracleIndexes() []string {
	var indexes []string

	for _, col := range j.Columns {
		// 为可能的外键字段创建索引
		if strings.HasSuffix(col.Name, "_ID") {
			indexName := fmt.Sprintf("IDX_%s_%s", j.TableName, col.Name)
			// Oracle索引名长度限制为30个字符
			if len(indexName) > 30 {
				indexName = indexName[:30]
			}
			indexSQL := fmt.Sprintf("CREATE INDEX %s ON %s (%s);", indexName, j.TableName, col.Name)
			indexes = append(indexes, indexSQL)
		}

		// 为状态字段创建索引
		if strings.Contains(col.Name, "STATUS") || strings.Contains(col.Name, "STATE") {
			indexName := fmt.Sprintf("IDX_%s_%s", j.TableName, col.Name)
			if len(indexName) > 30 {
				indexName = indexName[:30]
			}
			indexSQL := fmt.Sprintf("CREATE INDEX %s ON %s (%s);", indexName, j.TableName, col.Name)
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
