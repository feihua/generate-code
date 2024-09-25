/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package main

import (
	"embed"
	"github.com/feihua/generate-code/cmd"
	"github.com/feihua/generate-code/utils"
)

//go:embed template
var FileData embed.FS

func main() {

	utils.TemplateFileData = FileData
	cmd.Execute()
}
