/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>

*/
package project

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
	Use:   "project",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("mybatis called")
		t := utils.Project{}
		t.GroupId = groupId
		t.ArtifactId = artifactId

		var path = "generate/java/" + artifactId
		var tPath = "template/java/project"
		Generate(t, tPath+"/pom.xml.tpl", path, "pom.xml")

	},
}

var artifactId string
var groupId string

func init() {

	//go run main.go java project --artifactId uaf-devops-test --groupId com.demo
	Cmd.Flags().StringVarP(&artifactId, "artifactId", "", "", "请输入项目名称")
	Cmd.Flags().StringVarP(&groupId, "groupId", "", "", "请输入项目包名称")
}

func Generate(t utils.Project, tplName, path, fileName string) {
	tpl, err := template.ParseFiles(tplName)

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
