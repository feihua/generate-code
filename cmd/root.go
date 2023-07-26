/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (
	"github.com/feihua/generate-code/cmd/golang"
	"github.com/feihua/generate-code/cmd/golang/gf"
	"github.com/feihua/generate-code/cmd/golang/gorm"
	"github.com/feihua/generate-code/cmd/golang/zero"
	"github.com/feihua/generate-code/cmd/java"
	"github.com/feihua/generate-code/cmd/java/mybatis"
	"github.com/feihua/generate-code/cmd/rust"
	"github.com/feihua/generate-code/cmd/rust/actix"
	"github.com/feihua/generate-code/cmd/rust/axum"
	"github.com/feihua/generate-code/cmd/rust/rocket"
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

	RootCmd.AddCommand(rust.RustCmd)
	rust.RustCmd.AddCommand(axum.Cmd)
	rust.RustCmd.AddCommand(actix.Cmd)
	rust.RustCmd.AddCommand(rocket.Cmd)

	RootCmd.AddCommand(java.JavaCmd)
	java.JavaCmd.AddCommand(mybatis.Cmd)

}
