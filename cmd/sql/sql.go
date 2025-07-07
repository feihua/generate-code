/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package sql

import (
	"fmt"
	"github.com/spf13/cobra"
)

var SqlCmd = &cobra.Command{
	Use:   "sql",
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("rust called")
	},
}

// var Dsn string
// var TableNames string
// var PackageName string
//
// func init() {
//	RustCmd.Flags().StringVarP(&Dsn, "dsn", "", "", "请输入数据库的地址")
//	RustCmd.Flags().StringVarP(&TableNames, "tableNames", "", "", "请输入表名称")
//	RustCmd.Flags().StringVarP(&PackageName, "packageName", "", "", "请输入包名称")
// }
