/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package actix

import (
	"bytes"
	"fmt"
	"github.com/feihua/generate-code/utils"
	"io/ioutil"
	"os"
	"text/template"
	"time"

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
		var path = "generate/rust/actix/" + OrmType + "/" + PackageName
		if OrmType == "rbatis" {

			for _, t := range tables {
				Generate(t, "template/rust/actix/rbatis/vo.tpl", path+"/vo", t.RustName+"_vo.rs")
				Generate(t, "template/rust/actix/rbatis/model.tpl", path+"/model", t.RustName+".rs")
				Generate(t, "template/rust/actix/rbatis/handler.tpl", path+"/handler", t.RustName+"_handler.rs")
			}

		} else if OrmType == "sea" {
			for _, t := range tables {
				Generate(t, "template/rust/actix/sea/vo.tpl", path+"/vo", t.RustName+"_vo.rs")
				Generate(t, "template/rust/actix/sea/model.tpl", path+"/model", t.RustName+".rs")
				Generate(t, "template/rust/actix/sea/handler.tpl", path+"/handler", t.RustName+"_handler.rs")
			}

		} else if OrmType == "diesel" {
			for _, t := range tables {
				Generate(t, "template/rust/actix/diesel/vo.tpl", path+"/vo", t.RustName+"_vo.rs")
				Generate(t, "template/rust/actix/diesel/model.tpl", path+"/model", t.RustName+".rs")
				Generate(t, "template/rust/actix/diesel/handler.tpl", path+"/handler", t.RustName+"_handler.rs")
			}

		}

	},
}

var Dsn string
var TableNames string
var prefix string
var PackageName string
var OrmType string
var Author string

func init() {

	//go run main.go rust actix --dsn "root:oMbPi5munxCsBSsiLoPV@tcp(110.41.179.89:3306)/salvodb" --tableNames sys_ --prefix sys_  --orm diesel --author LiuFeiHua --packageName sys
	Cmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
	Cmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
	Cmd.Flags().StringVarP(&prefix, "prefix", "", "", "生成表时候去掉前缀")

	Cmd.Flags().StringVarP(&PackageName, "packageName", "", "", "请输入包名称")
	Cmd.Flags().StringVarP(&OrmType, "orm", "", "", "请输入持久层")
	Cmd.Flags().StringVarP(&Author, "author", "", "", "请输入作者名称")
}

func Generate(t utils.Table, tplName, path, fileName string) error {
	htmlByte, err := utils.TemplateFileData.ReadFile(tplName)
	//htmlByte, err := ioutil.ReadFile(tplName)
	if err != nil {
		fmt.Println("read html failed, err:", err)
		return err
	}

	fmap := template.FuncMap{"isContain": utils.IsContain}
	tpl, _ := template.New("abc.html").Funcs(fmap).Parse(string(htmlByte))
	//tpl, err := template.ParseFiles(tplName)

	t.Author = Author
	t.PackageName = PackageName
	t.CreateTime = time.Now().Format("2006/01/02 15:04:05")
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
