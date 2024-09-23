/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package zero

import (
	"bytes"
	"fmt"
	"github.com/feihua/generate-code/utils"
	"github.com/spf13/cobra"
	"io/ioutil"
	"os"
	"strings"
	"text/template"
	"time"
)

var Cmd = &cobra.Command{
	Use:   "zero",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		tables := utils.New().QueryTables(Dsn, TableNames, prefix)
		var path = "generate/go/zero"
		for _, t := range tables {
			Generate(t, "template/go/zero/api.tpl", path+"/api", t.GoName+".api")
			Generate(t, "template/go/zero/proto.tpl", path+"/proto", t.GoName+".proto")

			name := strings.Replace(t.GoName, "_", "", -1)
			Generate(t, "template/go/zero/logic/add.tpl", path+"/api/logic/"+name, "add"+name+"logic.go")
			Generate(t, "template/go/zero/logic/delete.tpl", path+"/api/logic/"+name, "delete"+name+"logic.go")
			Generate(t, "template/go/zero/logic/update.tpl", path+"/api/logic/"+name, "update"+name+"logic.go")
			Generate(t, "template/go/zero/logic/updatestatus.tpl", path+"/api/logic/"+name, "update"+name+"statuslogic.go")
			Generate(t, "template/go/zero/logic/querydetail.tpl", path+"/api/logic/"+name, "query"+name+"detaillogic.go")
			Generate(t, "template/go/zero/logic/querylist.tpl", path+"/api/logic/"+name, "query"+name+"listlogic.go")

			Generate(t, "template/go/zero/service/add.tpl", path+"/proto/service/"+name+"service", "add"+name+"logic.go")
			Generate(t, "template/go/zero/service/delete.tpl", path+"/proto/service/"+name+"service", "delete"+name+"logic.go")
			Generate(t, "template/go/zero/service/update.tpl", path+"/proto/service/"+name+"service", "update"+name+"logic.go")
			Generate(t, "template/go/zero/service/updatestatus.tpl", path+"/proto/service/"+name+"service", "update"+name+"statuslogic.go")
			Generate(t, "template/go/zero/service/querydetail.tpl", path+"/proto/service/"+name+"service", "query"+name+"detaillogic.go")
			Generate(t, "template/go/zero/service/querylist.tpl", path+"/proto/service/"+name+"service", "query"+name+"listlogic.go")
		}
	},
}

var Dsn string
var TableNames string
var prefix string
var PackageName string
var Author string
var RpcClient string

func init() {

	//go run main.go golang zero --dsn "root:oMbPi5munxCsBSsiLoPV@tcp(110.41.179.89:3306)/better-pay" --tableNames sys_ --prefix sys_  --rpcClient sysclient --author liufeihua
	Cmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
	Cmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
	Cmd.Flags().StringVarP(&prefix, "prefix", "", "", "生成表时候去掉前缀")

	Cmd.Flags().StringVarP(&PackageName, "packageName", "", "", "请输入包名称")
	Cmd.Flags().StringVarP(&Author, "author", "", "", "请输入包名称")
	Cmd.Flags().StringVarP(&RpcClient, "rpcClient", "", "", "请输入rpc client")
}

func Generate(t utils.Table, tplName, path, fileName string) error {
	htmlByte, err := ioutil.ReadFile(tplName)
	if err != nil {
		fmt.Println("read html failed, err:", err)
		return err
	}

	fmap := template.FuncMap{"isContain": utils.IsContain, "Replace": utils.Replace}
	tpl, _ := template.New("abc.html").Funcs(fmap).Parse(string(htmlByte))
	//tpl, err := template.ParseFiles(tplName)

	t.Author = Author
	t.RpcClient = RpcClient
	t.GoName = strings.Replace(t.GoName, "_", "", -1)
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
