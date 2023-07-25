/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>

*/
package actix

import (
	"bytes"
	"github.com/feihua/generate-code/utils"
	"io/ioutil"
	"os"
	"text/template"

	"github.com/spf13/cobra"
)

var Cmd = &cobra.Command{
	Use:   "actix",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

`,
	Run: func(c *cobra.Command, args []string) {
		tables := utils.New().QueryTables(Dsn, TableNames, prefix)
		var path = "generate/rust/actix"
		for _, t := range tables {
			Generate(t, "template/rust/actix/vo.tpl", path+"/vo", t.RustName+"_vo.rs")
			Generate(t, "template/rust/actix/model.tpl", path+"/model", t.RustName+".rs")
			Generate(t, "template/rust/actix/handler.tpl", path+"/handler", t.RustName+"_handler.rs")
		}
	},
}

var Dsn string
var TableNames string
var prefix string
var PackageName string

func init() {

	//rust actix --dsn "root:ad879037-c7a4-4063-9236-6bfc35d54b7d@tcp(139.159.180.129:3306)/gozero" --tableNames sys_ --prefix sys_
	Cmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
	Cmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
	Cmd.Flags().StringVarP(&prefix, "prefix", "", "", "生成表时候去掉前缀")

	Cmd.Flags().StringVarP(&PackageName, "packageName", "", "", "请输入包名称")
}

func Generate(t utils.Table, tplName, path, fileName string) error {
	tpl, err := template.ParseFiles(tplName)

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

	return ioutil.WriteFile(path+string(os.PathSeparator)+fileName, buf.Bytes(), 0755)
}
