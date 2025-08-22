/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package crow

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
	"text/template"
	"time"

	"github.com/feihua/generate-code/utils"
	"github.com/spf13/cobra"
)

var Cmd = &cobra.Command{
	Use:   "crow",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		tables := utils.New().QueryTables(Dsn, TableNames, prefix)
		var path = "generate/cpp/crow"
		for _, t := range tables {
			Generate(t, "template/cpp/crow/dto.tpl", path+"/dto/"+moduleName+"/"+t.GoName, "_dto", "")
			Generate(t, "template/cpp/crow/dtoh.tpl", path+"/dto/"+moduleName+"/"+t.GoName, "_dto", "")
			Generate(t, "template/cpp/crow/controller.tpl", path+"/controllers/"+moduleName+"/"+t.GoName, "_controller", "")
			Generate(t, "template/cpp/crow/controllerh.tpl", path+"/controllers/"+moduleName+"/"+t.GoName, "_controller", "")
			Generate(t, "template/cpp/crow/daoh.tpl", path+"/dao/"+moduleName+"/"+t.GoName, "_dao", "")
			Generate(t, "template/cpp/crow/dao_impl.tpl", path+"/dao/"+moduleName+"/"+t.GoName, "_dao", "")
			Generate(t, "template/cpp/crow/serviceh.tpl", path+"/service/"+moduleName+"/"+t.GoName, "_service", "")
			Generate(t, "template/cpp/crow/service_impl.tpl", path+"/service/"+moduleName+"/"+t.GoName, "_service", "")

		}

		GenerateRoute(tables, "template/cpp/crow/route.tpl", path+"/route/"+moduleName, "", "")
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

	// go run main.go cpp crow --dsn "root:12341qweqfsd2356@tcp(129.204.203.29:3306)/core-admin" --tableNames sys_ --prefix sys_  --author liufeihua --moduleName system
	Cmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
	Cmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
	Cmd.Flags().StringVarP(&prefix, "prefix", "", "", "生成表时候去掉前缀")

	Cmd.Flags().StringVarP(&PackageName, "packageName", "", "", "请输入包名称")
	Cmd.Flags().StringVarP(&Author, "author", "", "", "请输入包名称")
	Cmd.Flags().StringVarP(&ProjectName, "projectName", "", "test", "请输入项目名称")
	Cmd.Flags().StringVarP(&moduleName, "moduleName", "", "base", "请输入模块名称")
}

func Generate(t utils.Table, tplName, path, prefix, prefix1 string) error {
	htmlByte, err := utils.TemplateFileData.ReadFile(tplName)
	// htmlByte, err := ioutil.ReadFile(tplName)
	if err != nil {
		fmt.Println("read html failed, err:", err)
		return err
	}

	fmap := template.FuncMap{"isContain": utils.IsContain, "Replace": utils.Replace, "Sub": sub}
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

	daoh := strings.Contains(tplName, "daoh")
	serviceh := strings.Contains(tplName, "serviceh")
	dtoh := strings.Contains(tplName, "dtoh")
	controllerh := strings.Contains(tplName, "controllerh")
	if daoh || serviceh || dtoh || controllerh {
		return ioutil.WriteFile(path+string(os.PathSeparator)+prefix1+t.GoName+prefix+".h", buf.Bytes(), 0755)
	}
	return ioutil.WriteFile(path+string(os.PathSeparator)+prefix1+t.GoName+prefix+".cpp", buf.Bytes(), 0755)
}

func GenerateRoute(t []utils.Table, tplName, path, prefix, prefix1 string) error {
	htmlByte, err := utils.TemplateFileData.ReadFile(tplName)
	// htmlByte, err := ioutil.ReadFile(tplName)
	if err != nil {
		fmt.Println("read html failed, err:", err)
		return err
	}

	fmap := template.FuncMap{"isContain": utils.IsContain, "Replace": utils.Replace}
	tpl, _ := template.New("abc.html").Funcs(fmap).Parse(string(htmlByte))
	// tpl, err := template.ParseFiles(tplName)

	m1 := map[string]interface{}{"Tables": t, "ModuleName": moduleName}

	fmt.Print(m1)
	err = tpl.Execute(os.Stdout, m1)
	if err != nil {
		return err
	}

	var buf bytes.Buffer
	err = tpl.Execute(&buf, m1)
	if err != nil {
		return err
	}

	if err = os.MkdirAll(path, 0755); err != nil {
		return err
	}

	return ioutil.WriteFile(path+string(os.PathSeparator)+prefix1+"route"+prefix+".cpp", buf.Bytes(), 0755)
}
func sub(a, b int) int {
	return a - b
}
