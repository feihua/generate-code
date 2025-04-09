/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package gin

import (
	"bytes"
	"fmt"
	"github.com/feihua/generate-code/utils"
	"github.com/spf13/cobra"
	"io/ioutil"
	"os"
	"text/template"
	"time"
)

var Cmd = &cobra.Command{
	Use:   "gin",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		tables := utils.New().QueryTables(Dsn, TableNames, prefix)
		var path = "generate/go/gin"
		for _, t := range tables {
			Generate(t, "template/go/gin/entity.tpl", path+"/model/"+moduleName, "")
			Generate(t, "template/go/gin/req_vo.tpl", path+"/vo/"+moduleName+"/req", "_req")
			Generate(t, "template/go/gin/res_vo.tpl", path+"/vo/"+moduleName+"/resp", "_resp")
			Generate(t, "template/go/gin/dto.tpl", path+"/dto/"+moduleName, "_dto")
			Generate(t, "template/go/gin/router.tpl", path+"/router/"+moduleName, "_router")
			Generate(t, "template/go/gin/dao.tpl", path+"/dao/"+moduleName, "_dao")
			Generate(t, "template/go/gin/service.tpl", path+"/service/"+moduleName+"/"+t.GoName, "_service")
			Generate(t, "template/go/gin/impl.tpl", path+"/service/"+"/"+moduleName+"/"+t.GoName, "_service_impl")
			Generate(t, "template/go/gin/controller.tpl", path+"/controller/"+moduleName, "_controller")
		}
	},
}

var Dsn string
var TableNames string
var prefix string
var PackageName string
var Author string
var ProjectName string
var moduleName string

func init() {

	// go run main.go golang gin --dsn "root:123456@tcp(127.0.0.1:3306)/gin" --tableNames sys_ --prefix sys_  --author liufeihua --projectName github.com/feihua/simple-go --moduleName system
	Cmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
	Cmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
	Cmd.Flags().StringVarP(&prefix, "prefix", "", "", "生成表时候去掉前缀")

	Cmd.Flags().StringVarP(&PackageName, "packageName", "", "", "请输入包名称")
	Cmd.Flags().StringVarP(&Author, "author", "", "", "请输入包名称")
	Cmd.Flags().StringVarP(&ProjectName, "projectName", "", "test", "请输入项目名称")
	Cmd.Flags().StringVarP(&moduleName, "moduleName", "", "base", "请输入模块名称")
}

func Generate(t utils.Table, tplName, path, prefix string) error {
	htmlByte, err := utils.TemplateFileData.ReadFile(tplName)
	// htmlByte, err := ioutil.ReadFile(tplName)
	if err != nil {
		fmt.Println("read html failed, err:", err)
		return err
	}

	fmap := template.FuncMap{"isContain": utils.IsContain, "Replace": utils.Replace}
	tpl, _ := template.New("abc.html").Funcs(fmap).Parse(string(htmlByte))
	// tpl, err := template.ParseFiles(tplName)

	t.Author = Author
	t.ProjectName = ProjectName
	t.ModuleName = moduleName
	// t.GoName = strings.Replace(t.GoName, "_", "", -1)
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

	return ioutil.WriteFile(path+string(os.PathSeparator)+t.GoName+prefix+".go", buf.Bytes(), 0755)
}
