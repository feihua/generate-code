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
	"strings"
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

		for _, t := range tables {
			var path = "generate/java/mybatis"
			var tPath = "template/java/mybatis"
			Generate(t, tPath+"/entity/entity.tpl", path+"/entity", t.JavaName+"Bean.java")
			Generate(t, tPath+"/dao/dao.tpl", path+"/dao", t.JavaName+"Dao.java")
			Generate(t, tPath+"/mapper/mapper.tpl", path+"/mapper", t.JavaName+"Mapper.xml")
			Generate(t, tPath+"/biz/biz.tpl", path+"/biz", t.JavaName+"Biz.java")
			Generate(t, tPath+"/biz/bizImpl.tpl", path+"/biz/impl", t.JavaName+"BizImpl.java")
			Generate(t, tPath+"/service/service.tpl", path+"/service", t.JavaName+"Service.java")
			Generate(t, tPath+"/service/serviceImpl.tpl", path+"/service/impl", t.JavaName+"ServiceImpl.java")
			if swaggerVersion == 2 {
				Generate(t, tPath+"/ctrl/ctrl.tpl", path+"/controller", t.JavaName+"Controller.java")
			} else {
				Generate(t, tPath+"/openapi/ctrl.tpl", path+"/controller", t.JavaName+"Controller.java")
			}

			//Generate(t, tPath+"/vo/result.tpl", path+"/vo", "Result.java")
			//Generate(t, tPath+"/vo/resultPage.tpl", path+"/vo", "ResultPage.java")
			Generate(t, tPath+"/enum/enum.tpl", path+"/enums", "ResponseExceptionEnum.java")

			reqPath := path + "/vo/req"

			if swaggerVersion == 2 {
				tPath = tPath + "/vo"
			} else {
				tPath = tPath + "/openapi"
			}
			Generate(t, tPath+"/req/addReq.tpl", reqPath, "Add"+t.JavaName+"ReqVo.java")
			Generate(t, tPath+"/req/deleteReq.tpl", reqPath, "Delete"+t.JavaName+"ReqVo.java")
			Generate(t, tPath+"/req/updateReq.tpl", reqPath, "Update"+t.JavaName+"ReqVo.java")
			Generate(t, tPath+"/req/updateStatusReq.tpl", reqPath, "Update"+t.JavaName+"StatusReqVo.java")
			Generate(t, tPath+"/req/queryDetailReq.tpl", reqPath, "Query"+t.JavaName+"DetailReqVo.java")
			Generate(t, tPath+"/req/queryListReq.tpl", reqPath, "Query"+t.JavaName+"ListReqVo.java")

			Generate(t, tPath+"/resp/queryDetailResp.tpl", path+"/vo/resp", "Query"+t.JavaName+"DetailRespVo.java")
			Generate(t, tPath+"/resp/queryListResp.tpl", path+"/vo/resp", "Query"+t.JavaName+"ListRespVo.java")

		}
	},
}

var Dsn string
var TableNames string
var prefix string
var PackageName string
var Author string
var groupId string
var swaggerVersion int64

func init() {

	//go run main.go java mybatis --dsn "root:oMbPi5munxCsBSsiLoPV@tcp(110.41.179.89:3306)/better-pay" --tableNames pay_ --prefix pay_  --groupId com.example.springboottpl --packageName com.example.springboottpl --author 刘飞华
	//generate-code.exe java mybatis --dsn "dba_msginfo:UA9655pwd_msg@tcp(10.168.11.61:3309)/msg_db" --tableNames uaf_ --prefix uaf_  --groupId com.demo --packageName com.demo.test --author liufeihua
	Cmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
	Cmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
	Cmd.Flags().StringVarP(&prefix, "prefix", "", "", "生成表时候去掉前缀")

	Cmd.Flags().StringVarP(&PackageName, "packageName", "", "", "请输入包名称")
	Cmd.Flags().StringVarP(&Author, "author", "", "", "请输入作者名称")
	Cmd.Flags().StringVarP(&groupId, "groupId", "", "", "请输入作者名称")
	Cmd.Flags().Int64VarP(&swaggerVersion, "swaggerVersion", "", 2, "请输入swagger版本")
}

func Generate(t utils.Table, tplName, path, fileName string) {
	htmlByte, err := ioutil.ReadFile(tplName)
	if err != nil {
		fmt.Println("read html failed, err:", err)
		return
	}

	fmap := template.FuncMap{"isContain": IsContain}
	tpl, _ := template.New("abc.html").Funcs(fmap).Parse(string(htmlByte))
	//tpl, err := template.ParseFiles(tplName)
	//tpl := template.Must(template.New("sql2proto").Parse(t.structTpl))

	t.PackageName = PackageName
	t.Author = Author
	t.CreateTime = time.Now().Format("2006-01-02 15:04:05")
	t.GroupId = groupId
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

// IsContain 判断是否包含
func IsContain(a, b string) bool {

	return strings.Contains(a, b)
}
