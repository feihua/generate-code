/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package modules

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
	Use:   "module",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("mybatis called")
		t := utils.Modules{}
		t.ParentArtifactId = parentArtifactId
		t.ArtifactId = artifactId
		t.GroupId = groupId
		t.PackageName = packageName
		t.CreateTime = time.Now().Format("2006-01-02 15:04:05")
		t.Author = author
		t.MapperPath = strings.ReplaceAll(packageName, ".", "/")

		var path = "generate/java/" + parentArtifactId + "/" + artifactId
		var tPath = "template/java/modules"
		Generate(t, tPath+"/pom.xml.tpl", path, "pom.xml")

		rPath := path + "/src/main/resources"
		Generate(t, tPath+"/src/main/resources/application.yml.tpl", rPath, "application.yml")

		jPath := path + "/src/main/java/" + strings.ReplaceAll(packageName, ".", "/")
		Generate(t, tPath+"/src/main/java/Application.java.tpl", jPath, "Application.java")

		Generate(t, tPath+"/src/main/java/advice/ExceptionAdvice.java.tpl", jPath+"/advice", "ExceptionAdvice.java")
		Generate(t, tPath+"/src/main/java/aop/LogAspect.java.tpl", jPath+"/aop", "LogAspect.java")
		Generate(t, tPath+"/src/main/java/enums/ExceptionEnum.java.tpl", jPath+"/enums", "ExceptionEnum.java")
		Generate(t, tPath+"/src/main/java/config/Config.java.tpl", jPath+"/config", "Config.java")
		Generate(t, tPath+"/src/main/java/config/SwaggerConfig.java.tpl", jPath+"/config", "SwaggerConfig.java")

		Generate(t, tPath+"/src/main/java/exception/ServiceException.java.tpl", jPath+"/exception", "CustomException.java")

		Generate(t, tPath+"/src/main/java/utils/Constant.java.tpl", jPath+"/utils", "Constant.java")

	},
}

var artifactId string
var groupId string
var parentArtifactId string
var packageName string
var author string

func init() {

	//go run main.go java module --parentArtifactId  uaf-devops-test   --artifactId uaf-devops-base  --groupId com.demo --packageName com.demo.test  --author 刘飞华
	Cmd.Flags().StringVarP(&artifactId, "artifactId", "", "", "请输入项目的artifactId")
	Cmd.Flags().StringVarP(&groupId, "groupId", "", "", "请输入项目的groupId")
	Cmd.Flags().StringVarP(&parentArtifactId, "parentArtifactId", "", "", "请输入父项目的parentArtifactId")
	Cmd.Flags().StringVarP(&packageName, "packageName", "", "", "请输入项目包名称")
	Cmd.Flags().StringVarP(&author, "author", "", "", "请输入作者")
}

func Generate(t utils.Modules, tplName, path, fileName string) {
	htmlByte, err := utils.TemplateFileData.ReadFile(tplName)
	//htmlByte, err := ioutil.ReadFile(tplName)
	if err != nil {
		fmt.Println("read html failed, err:", err)
		return
	}

	fmap := template.FuncMap{"isContain": utils.IsContain, "Replace": utils.Replace}
	tpl, _ := template.New("abc.html").Funcs(fmap).Parse(string(htmlByte))
	//tpl, err := template.ParseFiles(tplName)

	t.CreateTime = time.Now().Format("2006/01/02 15:04:05")
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
