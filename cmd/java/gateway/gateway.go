/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>

*/
package gateway

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
	Use:   "gateway",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("mybatis called")
		gateway := utils.Gateway{}
		gateway.ParentArtifactId = parentArtifactId
		gateway.ArtifactId = artifactId
		gateway.GroupId = groupId
		gateway.PackageName = packageName
		gateway.CreateTime = time.Now().Format("2006-01-02 15:04:05")
		gateway.Author = author

		var path = "generate/java/" + parentArtifactId + "/" + artifactId
		var tPath = "template/java/gateway"
		Generate(gateway, tPath+"/pom.xml.tpl", path, "pom.xml")

		rPath := path + "/src/main/resources"
		Generate(gateway, tPath+"/src/main/resources/application.yml.tpl", rPath, "application.yml")

		jPath := path + "/src/main/java/" + strings.ReplaceAll(packageName, ".", "/")
		Generate(gateway, tPath+"/src/main/java/GatewayApplication.java.tpl", jPath, "GatewayApplication.java")

		Generate(gateway, tPath+"/src/main/java/config/GateWayConfig.java.tpl", jPath+"/config", "GateWayConfig.java")
		Generate(gateway, tPath+"/src/main/java/config/SwaggerHeaderFilter.java.tpl", jPath+"/config", "SwaggerHeaderFilter.java")
		Generate(gateway, tPath+"/src/main/java/config/SwaggerResourceConfig.java.tpl", jPath+"/config", "SwaggerResourceConfig.java")

		Generate(gateway, tPath+"/src/main/java/filter/JwtFilter.java.tpl", jPath+"/filter", "JwtFilter.java")

		Generate(gateway, tPath+"/src/main/java/handler/SwaggerHandler.java.tpl", jPath+"/handler", "SwaggerHandler.java")

	},
}

var artifactId string
var groupId string
var parentArtifactId string
var packageName string
var author string

func init() {

	//go run main.go java gateway --parentArtifactId  uaf-devops-test   --artifactId uaf-devops-gateway  --groupId com.demo --packageName com.demo.test  --author 刘飞华
	Cmd.Flags().StringVarP(&artifactId, "artifactId", "", "", "请输入项目的artifactId")
	Cmd.Flags().StringVarP(&groupId, "groupId", "", "", "请输入项目的groupId")
	Cmd.Flags().StringVarP(&parentArtifactId, "parentArtifactId", "", "", "请输入父项目的parentArtifactId")
	Cmd.Flags().StringVarP(&packageName, "packageName", "", "", "请输入项目包名称")
	Cmd.Flags().StringVarP(&author, "author", "", "", "请输入作者")
}

func Generate(t utils.Gateway, tplName, path, fileName string) {
	tpl, err := template.ParseFiles(tplName)

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
