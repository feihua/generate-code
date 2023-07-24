/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>

*/
package entity

import (
	"bytes"
	"github.com/feihua/generate-code/utils"
	"github.com/spf13/cobra"
	"io/ioutil"
	"os"
	"text/template"
)

var Cmd = &cobra.Command{
	Use:   "entity",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
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

	//main.exe golang entity --dsn "root:ad879037-c7a4-4063-9236-6bfc35d54b7d@tcp(139.159.180.129:3306)/gozero" --tableNames sys_ --prefix sys_
	Cmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
	Cmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
	Cmd.Flags().StringVarP(&prefix, "prefix", "", "", "生成表时候去掉前缀")

	Cmd.Flags().StringVarP(&PackageName, "packageName", "", "", "请输入包名称")
}

func Generate(t utils.Table) error {
	tpl, err := template.ParseFiles("template/go/entity.tpl")

	err = tpl.Execute(os.Stdout, t)
	if err != nil {
		return err
	}

	var buf bytes.Buffer
	err = tpl.Execute(&buf, t)
	if err != nil {
		return err
	}

	var path = "generate/go/entity"
	if err = os.MkdirAll(path, 0755); err != nil {
		return err
	}

	return ioutil.WriteFile(path+string(os.PathSeparator)+t.GoName+".go", buf.Bytes(), 0755)
}
