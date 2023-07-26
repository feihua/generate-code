/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>

*/
package mybatis

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
	Use:   "mybatis",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("mybatis called")
		tables := utils.New().QueryTables(Dsn, TableNames, prefix)
		var path = "generate/java"
		var tPath = "template/java/mybatis"
		for _, t := range tables {
			Generate(t, tPath+"/entity/entity.tpl", path+"/entity", t.JavaName+"Bean.java")
			Generate(t, tPath+"/dao/dao.tpl", path+"/dao", t.JavaName+"Dao.java")
			Generate(t, tPath+"/mapper/mapper.tpl", path+"/mapper", t.JavaName+"Mapper.xml")
			Generate(t, tPath+"/biz/biz.tpl", path+"/biz", t.JavaName+"Biz.java")
			Generate(t, tPath+"/biz/bizImpl.tpl", path+"/biz/impl", t.JavaName+"BizImpl.java")
			Generate(t, tPath+"/service/service.tpl", path+"/service", t.JavaName+"Service.java")
			Generate(t, tPath+"/service/serviceImpl.tpl", path+"/service/impl", t.JavaName+"ServiceImpl.java")
			Generate(t, tPath+"/ctrl/ctrl.tpl", path+"/controller", t.JavaName+"Controller.java")
			Generate(t, tPath+"/vo/result.tpl", path+"/vo", "Result.java")
			Generate(t, tPath+"/vo/resultPage.tpl", path+"/vo", "ResultPage.java")
			Generate(t, tPath+"/enum/enum.tpl", path+"/enums", "ResponseExceptionEnum.java")

			reqPath := path + "/vo/req"
			Generate(t, tPath+"/vo/req/addReq.tpl", reqPath, t.JavaName+"AddReqVo.java")
			Generate(t, tPath+"/vo/req/deleteReq.tpl", reqPath, t.JavaName+"DeleteReqVo.java")
			Generate(t, tPath+"/vo/req/updateReq.tpl", reqPath, t.JavaName+"UpdateReqVo.java")
			Generate(t, tPath+"/vo/req/req.tpl", reqPath, t.JavaName+"ReqVo.java")
			Generate(t, tPath+"/vo/req/listReq.tpl", reqPath, t.JavaName+"ListReqVo.java")

			Generate(t, tPath+"/vo/resp/resp.tpl", path+"/vo/resp", t.JavaName+"RespVo.java")

		}
	},
}

var Dsn string
var TableNames string
var prefix string
var PackageName string
var Author string

func init() {

	//go run main.go java mybatis --dsn "root:ad879037-c7a4-4063-9236-6bfc35d54b7d@tcp(139.159.180.129:3306)/gozero" --tableNames sys_ --prefix sys_ --packageName com.demo.test --author liufeihua
	Cmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
	Cmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
	Cmd.Flags().StringVarP(&prefix, "prefix", "", "", "生成表时候去掉前缀")

	Cmd.Flags().StringVarP(&PackageName, "packageName", "", "", "请输入包名称")
	Cmd.Flags().StringVarP(&Author, "author", "", "", "请输入作者名称")
}

func Generate(t utils.Table, tplName, path, fileName string) {
	tpl, err := template.ParseFiles(tplName)
	//tpl := template.Must(template.New("sql2proto").Parse(t.structTpl))

	t.PackageName = PackageName
	t.Author = Author
	t.CreateTime = time.Now().Format("2006-01-02 15:04:05")
	err = tpl.Execute(os.Stdout, t)
	if err != nil {
		fmt.Println(err)
		return
	}

	var buf bytes.Buffer
	err = tpl.Execute(&buf, t)
	if err != nil {
		return
	}

	if err = os.MkdirAll(path, 0755); err != nil {
		return
	}

	ioutil.WriteFile(path+string(os.PathSeparator)+fileName, buf.Bytes(), 0755)
}
