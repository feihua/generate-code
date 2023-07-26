/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>

*/
package gf

import (
	"bytes"
	"github.com/feihua/generate-code/utils"
	"github.com/spf13/cobra"
	"io/ioutil"
	"os"
	"strings"
	"text/template"
)

var Cmd = &cobra.Command{
	Use:   "gf",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		tables := utils.New().QueryTables(Dsn, TableNames, prefix)
		var path = "generate/go/gf"
		for _, t := range tables {
			Generate(t, "template/go/gf/api.tpl", path+"/api/"+moduleName+"/v1")
			Generate(t, "template/go/gf/logic.tpl", path+"/logic/"+moduleName+"_"+t.GoName)
			Generate(t, "template/go/gf/model.tpl", path+"/model")

			pathName := path + "/controller/" + moduleName
			Generate(t, "template/go/gf/ctrl_add.tpl", pathName)
			Generate(t, "template/go/gf/ctrl_delete.tpl", pathName)
			Generate(t, "template/go/gf/ctrl_update.tpl", pathName)
			Generate(t, "template/go/gf/ctrl_list.tpl", pathName)
		}
	},
}

var Dsn string
var TableNames string
var prefix string
var moduleName string
var projectName string

func init() {
	//main.exe golang gf --dsn "root:ad879037-c7a4-4063-9236-6bfc35d54b7d@tcp(139.159.180.129:3306)/gozero" --tableNames sys_ --prefix sys_ --moduleName base --projectName uaf-devops-project
	Cmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
	Cmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
	Cmd.Flags().StringVarP(&prefix, "prefix", "", "", "生成表时候去掉前缀")

	Cmd.Flags().StringVarP(&moduleName, "moduleName", "", "base", "请输入模块名称")
	Cmd.Flags().StringVarP(&projectName, "projectName", "", "test", "请输入项目名称")
}

func Generate(t utils.Table, tplName, path string) error {
	tpl, err := template.ParseFiles(tplName)

	t.ModuleName = moduleName
	t.ProjectName = projectName
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

	fileName := t.GoName
	if strings.Contains(tplName, "model") {
		fileName = moduleName + "_" + fileName
	}

	if strings.Contains(tplName, "ctrl_add") {
		fileName = moduleName + "_v1_" + fileName + "_add"
	}
	if strings.Contains(tplName, "ctrl_delete") {
		fileName = moduleName + "_v1_" + fileName + "_delete"
	}
	if strings.Contains(tplName, "ctrl_update") {
		fileName = moduleName + "_v1_" + fileName + "_update"
	}
	if strings.Contains(tplName, "ctrl_list") {
		fileName = moduleName + "_v1_" + fileName + "_list"
	}

	return ioutil.WriteFile(path+string(os.PathSeparator)+fileName+".go", buf.Bytes(), 0755)
}
