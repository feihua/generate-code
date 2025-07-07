/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"github.com/feihua/generate-code/cmd/golang"
	"github.com/feihua/generate-code/cmd/golang/gf"
	"github.com/feihua/generate-code/cmd/golang/gin"
	"github.com/feihua/generate-code/cmd/golang/gorm"
	"github.com/feihua/generate-code/cmd/golang/hertz"
	"github.com/feihua/generate-code/cmd/golang/zero"
	"github.com/feihua/generate-code/cmd/java"
	"github.com/feihua/generate-code/cmd/java/eureka"
	"github.com/feihua/generate-code/cmd/java/gateway"
	"github.com/feihua/generate-code/cmd/java/modules"
	"github.com/feihua/generate-code/cmd/java/mybatis"
	"github.com/feihua/generate-code/cmd/java/project"
	net "github.com/feihua/generate-code/cmd/net"
	"github.com/feihua/generate-code/cmd/net/web_api"
	"github.com/feihua/generate-code/cmd/php"
	"github.com/feihua/generate-code/cmd/php/think"
	"github.com/feihua/generate-code/cmd/php/webman"
	"github.com/feihua/generate-code/cmd/rust"
	"github.com/feihua/generate-code/cmd/rust/actix"
	"github.com/feihua/generate-code/cmd/rust/axum"
	"github.com/feihua/generate-code/cmd/rust/ntex"
	"github.com/feihua/generate-code/cmd/rust/rocket"
	"github.com/feihua/generate-code/cmd/rust/salvo"
	"github.com/feihua/generate-code/cmd/sql"
	"github.com/feihua/generate-code/cmd/sql/mysql"
	"github.com/feihua/generate-code/cmd/sql/oracle"
	"github.com/feihua/generate-code/cmd/sql/postgresql"
	"github.com/feihua/generate-code/cmd/web"
	"github.com/feihua/generate-code/cmd/web/angular/ng_zorro_antd"
	"github.com/feihua/generate-code/cmd/web/react/antd"
	"github.com/feihua/generate-code/cmd/web/react/antd_state"
	react_pro "github.com/feihua/generate-code/cmd/web/react/pro"
	"github.com/feihua/generate-code/cmd/web/vue/antdv"
	"github.com/feihua/generate-code/cmd/web/vue/element_plus"
	"github.com/feihua/generate-code/cmd/web/vue/element_plus_state"
	"github.com/spf13/cobra"
	"os"
)

// RootCmd represents the base command when called without any subcommands
var RootCmd = &cobra.Command{
	Use:   "generate-code",
	Short: "A brief description of your application",
	Long: `A longer description that spans multiple lines and likely contains
examples and usage of using your application. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	// Uncomment the following line if your bare application
	// has an action associated with it:
	// Run: func(cmd *cobra.Command, args []string) { },
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := RootCmd.Execute()

	if err != nil {
		os.Exit(1)
	}
}

func init() {

	RootCmd.AddCommand(golang.GoCmd)
	golang.GoCmd.AddCommand(gorm.Cmd)
	golang.GoCmd.AddCommand(gf.Cmd)
	golang.GoCmd.AddCommand(zero.Cmd)
	golang.GoCmd.AddCommand(hertz.Cmd)
	golang.GoCmd.AddCommand(gin.Cmd)

	RootCmd.AddCommand(rust.RustCmd)
	rust.RustCmd.AddCommand(axum.Cmd)
	rust.RustCmd.AddCommand(actix.Cmd)
	rust.RustCmd.AddCommand(rocket.Cmd)
	rust.RustCmd.AddCommand(salvo.Cmd)
	rust.RustCmd.AddCommand(ntex.Cmd)

	RootCmd.AddCommand(java.JavaCmd)
	java.JavaCmd.AddCommand(project.Cmd)
	java.JavaCmd.AddCommand(eureka.Cmd)
	java.JavaCmd.AddCommand(gateway.Cmd)
	java.JavaCmd.AddCommand(modules.Cmd)
	java.JavaCmd.AddCommand(mybatis.Cmd)

	RootCmd.AddCommand(web.WebCmd)
	web.WebCmd.AddCommand(react_pro.Cmd)
	web.WebCmd.AddCommand(antd.Cmd)
	web.WebCmd.AddCommand(antd_state.Cmd)
	web.WebCmd.AddCommand(element_plus.Cmd)
	web.WebCmd.AddCommand(antdv.Cmd)
	web.WebCmd.AddCommand(element_plus_state.Cmd)
	web.WebCmd.AddCommand(ng_zorro_antd.Cmd)

	RootCmd.AddCommand(php.PhpCmd)
	php.PhpCmd.AddCommand(webman.Cmd)
	php.PhpCmd.AddCommand(think.Cmd)

	RootCmd.AddCommand(net.NetCmd)
	net.NetCmd.AddCommand(web_api.Cmd)

	RootCmd.AddCommand(sql.SqlCmd)
	sql.SqlCmd.AddCommand(mysql.Cmd)
	sql.SqlCmd.AddCommand(oracle.Cmd)
	sql.SqlCmd.AddCommand(postgresql.Cmd)
}
