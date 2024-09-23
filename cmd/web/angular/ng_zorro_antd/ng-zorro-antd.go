package ng_zorro_antd

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
	Use:   "ng_zorro_antd",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		tables := utils.New().QueryTables(Dsn, TableNames, prefix)
		var path = "generate/web/angular/ng-zorro-antd/"
		for _, t := range tables {
			Generate(t, "template/web/angular/ng-zorro-antd/data.d.ts", path+t.LowerJavaName, "data.d.ts")
			Generate(t, "template/web/angular/ng-zorro-antd/component.css", path+t.LowerJavaName, t.LowerJavaName+".component.css")
			Generate(t, "template/web/angular/ng-zorro-antd/service.ts", path+t.LowerJavaName, t.LowerJavaName+".service.ts")
			Generate(t, "template/web/angular/ng-zorro-antd/component.ts", path+t.LowerJavaName, t.LowerJavaName+".component.ts")
			Generate(t, "template/web/angular/ng-zorro-antd/component.html", path+t.JavaName, t.LowerJavaName+".component.html")
		}
	},
}

var Dsn string
var TableNames string
var prefix string
var PackageName string
var Author string

func init() {

	//go run main.go web ng_zorro_antd --dsn "root:oMbPi5munxCsBSsiLoPV@tcp(110.41.179.89:3306)/better-pay" --tableNames pay_ --prefix pay_ --author liufeihua
	Cmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
	Cmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
	Cmd.Flags().StringVarP(&prefix, "prefix", "", "", "生成表时候去掉前缀")

	Cmd.Flags().StringVarP(&PackageName, "packageName", "", "", "请输入包名称")
	Cmd.Flags().StringVarP(&Author, "author", "", "", "请输入包名称")
}

func Generate(t utils.Table, tplName, path, fileName string) error {
	htmlByte, err := ioutil.ReadFile(tplName)
	if err != nil {
		fmt.Println("read html failed, err:", err)
		return err
	}

	fmap := template.FuncMap{"isContain": utils.IsContain}
	tpl, _ := template.New("abc.html").Funcs(fmap).Parse(string(htmlByte))
	//tpl, err := tpl.ParseFiles(tplName)

	t.Author = Author
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
