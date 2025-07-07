/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package oracle

import (
	"bytes"
	"fmt"
	"github.com/feihua/generate-code/utils"
	"github.com/spf13/cobra"
	"io/ioutil"
	"os"
	"text/template"
)

var Cmd = &cobra.Command{
	Use:   "oracle",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

`,
	Run: func(c *cobra.Command, args []string) {
		jsonStr, err := readJSONFile(JsonFile)
		if err != nil {
			fmt.Printf("读取JSON文件失败: %v", err)
			return
		}
		fmt.Printf("正在分析文件: %s\n", JsonFile)
		fmt.Printf("表名: %s\n\n", TableName)

		converter := NewJSONToOracleDDL(TableName)

		err = converter.AnalyzeJSON(jsonStr)
		if err != nil {
			fmt.Printf("分析JSON失败: %v", err)
			return
		}

		var path = "generate/sql/oracle"
		var params map[string]interface{}
		params = map[string]interface{}{
			"TableName": converter.TableName,
			"Indexes":   converter.GenerateOracleIndexes(),
			"Columns":   converter.GenerateOracleDDL(),
		}
		Generate(params, "template/sql/oracle_dll.tpl", path)
	},
}

var TableName string
var JsonFile string

func init() {

	// go run main.go sql oracle --tableName test --jsonFile test.json
	Cmd.Flags().StringVarP(&TableName, "tableName", "", "", "请输入表名称")
	Cmd.Flags().StringVarP(&JsonFile, "jsonFile", "", "", "请输入JSON文件路径")

}

func Generate(t map[string]interface{}, tplName, path string) error {
	htmlByte, err := utils.TemplateFileData.ReadFile(tplName)
	// htmlByte, err := ioutil.ReadFile(tplName)
	if err != nil {
		fmt.Println("read html failed, err:", err)
		return err
	}

	fmap := template.FuncMap{"isContain": utils.IsContain}
	tpl, _ := template.New("abc.html").Funcs(fmap).Parse(string(htmlByte))
	// tpl, err := template.ParseFiles(tplName)

	err = tpl.Execute(os.Stdout, t)
	if err != nil {
		return err
	}

	var buf bytes.Buffer
	err = tpl.Execute(&buf, t)
	if err != nil {
		return err
	}

	if err = os.MkdirAll(path, 0755); err != nil {
		return err
	}

	return ioutil.WriteFile(path+string(os.PathSeparator)+TableName+".sql", buf.Bytes(), 0755)
}
