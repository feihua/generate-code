/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package eureka

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
	Use:   "eureka",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("mybatis called")
		eureka := utils.Eureka{}
		eureka.ParentArtifactId = parentArtifactId
		eureka.ArtifactId = artifactId
		eureka.GroupId = groupId
		eureka.PackageName = packageName
		eureka.CreateTime = time.Now().Format("2006-01-02 15:04:05")
		eureka.Author = author

		var path = "generate/java/" + parentArtifactId + "/" + artifactId
		var tPath = "template/java/eureka"

		Generate(eureka, tPath+"/pom.xml.tpl", path, "pom.xml")

		rPath := path + "/src/main/resources"
		Generate(eureka, tPath+"/src/main/resources/application.yml.tpl", rPath, "application.yml")

		jPath := path + "/src/main/java/" + strings.ReplaceAll(packageName, ".", "/")
		Generate(eureka, tPath+"/src/main/java/EurekaApplication.java.tpl", jPath, "EurekaApplication.java")

	},
}

var artifactId string
var groupId string
var parentArtifactId string
var packageName string
var author string

func init() {

	//go run main.go java eureka --parentArtifactId  uaf-devops-test   --artifactId uaf-devops-eureka  --groupId com.demo --packageName com.demo.test  --author 刘飞华
	Cmd.Flags().StringVarP(&artifactId, "artifactId", "", "", "请输入项目的artifactId")
	Cmd.Flags().StringVarP(&groupId, "groupId", "", "", "请输入项目的groupId")
	Cmd.Flags().StringVarP(&parentArtifactId, "parentArtifactId", "", "", "请输入父项目的parentArtifactId")
	Cmd.Flags().StringVarP(&packageName, "packageName", "", "", "请输入项目包名称")
	Cmd.Flags().StringVarP(&author, "author", "", "", "请输入作者")
}

func Generate(t utils.Eureka, tplName, path, fileName string) {
	htmlByte, err := utils.TemplateFileData.ReadFile(tplName)
	//htmlByte, err := ioutil.ReadFile(tplName)
	if err != nil {
		fmt.Println("read html failed, err:", err)
		return
	}

	fmap := template.FuncMap{"isContain": utils.IsContain, "Replace": utils.Replace}
	tpl, _ := template.New("abc.html").Funcs(fmap).Parse(string(htmlByte))
	//tpl, err := template.ParseFiles(tplName)

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
