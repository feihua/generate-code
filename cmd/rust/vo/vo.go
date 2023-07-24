/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>

*/
package vo

import (
	"bytes"
	"github.com/feihua/generate-code/utils"
	"io/ioutil"
	"os"
	"text/template"

	"github.com/spf13/cobra"
)

var VoCmd = &cobra.Command{
	Use:   "vo",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

`,
	Run: func(c *cobra.Command, args []string) {
		tables := utils.QueryTables(Dsn, TableNames, prefix)
		for _, t := range tables {
			Generate(t)
		}
	},
}

var Dsn string
var TableNames string
var prefix string
var PackageName string

func init() {

	//rust vo --dsn "root:ad879037-c7a4-4063-9236-6bfc35d54b7d@tcp(139.159.180.129:3306)/gozero" --tableNames sys_ --prefix sys_
	VoCmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
	VoCmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
	VoCmd.Flags().StringVarP(&prefix, "prefix", "", "", "生成表时候去掉前缀")

	VoCmd.Flags().StringVarP(&PackageName, "packageName", "", "", "请输入包名称")
}

func Generate(t utils.Table) error {
	tpl, err := template.ParseFiles("template/rust/entity.tpl")
	//tpl := template.Must(template.New("sql2proto").Parse(t.structTpl))

	err = tpl.Execute(os.Stdout, t)
	if err != nil {
		return err
	}

	var buf bytes.Buffer
	err = tpl.Execute(&buf, t)
	if err != nil {
		return err
	}

	var path = "generate/rust/entity"
	if err = os.MkdirAll(path, 0755); err != nil {
		return err
	}

	return ioutil.WriteFile(path+string(os.PathSeparator)+t.RustName+".rs", buf.Bytes(), 0755)
}
