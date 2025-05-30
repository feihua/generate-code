/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package web_api

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
	Use:   "webapi",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		tables := utils.New().QueryTables(Dsn, TableNames, prefix)
		var path = "generate/net/webapi"
		for _, t := range tables {
			Generate(t, "template/net/webapi/dto/add_dto.tpl", path+"/Dto/Request/"+moduleName+"/"+t.JavaName, "Dto", "Add")
			Generate(t, "template/net/webapi/dto/delete_dto.tpl", path+"/Dto/Request/"+moduleName+"/"+t.JavaName, "Dto", "Delete")
			Generate(t, "template/net/webapi/dto/update_dto.tpl", path+"/Dto/Request/"+moduleName+"/"+t.JavaName, "Dto", "Update")
			Generate(t, "template/net/webapi/dto/update_status_dto.tpl", path+"/Dto/Request/"+moduleName+"/"+t.JavaName, "StatusDto", "Update")
			Generate(t, "template/net/webapi/dto/query_list_dto.tpl", path+"/Dto/Request/"+moduleName+"/"+t.JavaName, "ListDto", "Query")

			Generate(t, "template/net/webapi/vo/res_vo.tpl", path+"/Dto/Response/"+moduleName+"/"+t.JavaName, "Vo", "")
			Generate(t, "template/net/webapi/vo/res_detail_vo.tpl", path+"/Dto/Response/"+moduleName+"/"+t.JavaName, "DetailVo", "")
			Generate(t, "template/net/webapi/vo/res_list_vo.tpl", path+"/Dto/Response/"+moduleName+"/"+t.JavaName, "ListVo", "")

			Generate(t, "template/net/webapi/mapping.tpl", path+"/Mappings/"+moduleName, "MappingProfile", "")
			Generate(t, "template/net/webapi/controller.tpl", path+"/Controller/"+moduleName, "Controller", "")
			Generate(t, "template/net/webapi/service.tpl", path+"/Service/Interfaces/"+moduleName, "Service", "I")
			Generate(t, "template/net/webapi/service_impl.tpl", path+"/Service/"+moduleName, "Service", "")
			Generate(t, "template/net/webapi/dao.tpl", path+"/Repository/Interfaces/"+moduleName, "Repository", "I")
			Generate(t, "template/net/webapi/dao_impl.tpl", path+"/Repository/"+moduleName, "Repository", "")

		}

		// GenerateRoute(tables, "template/net/webapi/route.tpl", path+"/route/"+moduleName, "", "")
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

	// go run main.go net webapi --dsn "root:123456@tcp(127.0.0.1:3306)/gin" --tableNames sys_ --prefix sys_  --author liufeihua --moduleName System
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

	return ioutil.WriteFile(path+string(os.PathSeparator)+prefix1+t.JavaName+prefix+".cs", buf.Bytes(), 0755)
}

// func GenerateRoute(t []utils.Table, tplName, path, prefix, prefix1 string) error {
// 	htmlByte, err := utils.TemplateFileData.ReadFile(tplName)
// 	// htmlByte, err := ioutil.ReadFile(tplName)
// 	if err != nil {
// 		fmt.Println("read html failed, err:", err)
// 		return err
// 	}
//
// 	fmap := template.FuncMap{"isContain": utils.IsContain, "Replace": utils.Replace}
// 	tpl, _ := template.New("abc.html").Funcs(fmap).Parse(string(htmlByte))
// 	// tpl, err := template.ParseFiles(tplName)
//
// 	m1 := map[string]interface{}{"Tables": t, "ModuleName": moduleName}
//
// 	fmt.Print(m1)
// 	err = tpl.Execute(os.Stdout, m1)
// 	if err != nil {
// 		return err
// 	}
//
// 	var buf bytes.Buffer
// 	err = tpl.Execute(&buf, m1)
// 	if err != nil {
// 		return err
// 	}
//
// 	if err = os.MkdirAll(path, 0755); err != nil {
// 		return err
// 	}
//
// 	return ioutil.WriteFile(path+string(os.PathSeparator)+prefix1+"route"+prefix+".php", buf.Bytes(), 0755)
// }
