package main

import (
	"github.com/mauricetjmurphy/databases/commands"

	_ "github.com/golang-migrate/migrate/v4/source/file"
)

func main() {
	err := commands.MainCmd.Execute()
	if err != nil {
		panic(any(err))
	}
}
