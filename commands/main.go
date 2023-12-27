package commands

import (
	"context"
	"fmt"

	"github.com/mauricetjmurphy/databases/configs"
	"github.com/mauricetjmurphy/ms-common/logx"
	"github.com/spf13/cobra"
)

func init() {
	MainCmd.Flags().StringVar(&options.project, "project", "", "specify the project")
	MainCmd.Flags().StringVar(&options.DBName, "database", "", "specify the database name")
	MainCmd.Flags().StringVar(&options.DBName, "source", "", "specify the source file database scripts")
	MainCmd.Flags().BoolVar(&options.disable, "disable", false, "skip db migration")

	MainCmd.Flags().StringVar(&options.Host, "host", "127.0.0.1", "specify the database hostname/ip")
	MainCmd.Flags().IntVar(&options.Port, "port", 3306, "specify the database port")
	MainCmd.Flags().StringVar(&options.User, "username", "root", "specify the database username")
	MainCmd.Flags().StringVar(&options.Password, "password", "", "specify the database password")

	MainCmd.Flags().StringVar(&options.AWSRegion, "region", "us-east-1", "specify the aws region")
	MainCmd.Flags().StringVar(&options.AWSSecretID, "secret-id", "", "specify the aws secret manage identifier")
}

var (
	options struct {
		project string
		disable bool
		configs.RDS
	}

	defaultSourceFilePatter = "file://./rds/%v/db"

	MainCmd = &cobra.Command{
		Use:   "rds-migrate [<OPTIONS>]",
		Short: "Run the RDS database migration tool.",
		Run: func(cmd *cobra.Command, args []string) {
			if len(options.project) == 0 {
				logx.Panicf("rds-migrate : must specify --project")
			}

			if len(options.DBName) == 0 {
				logx.Panicf("rds-migrate : must specify --database")
			}

			if options.disable {
				logx.Infof("rds-migrate : skip db migration [%v] on project [%v]", options.DBName, options.project)
				return
			}

			if len(options.MigrateSourceFiles) == 0 {
				options.MigrateSourceFiles = fmt.Sprintf(defaultSourceFilePatter, options.project)
			}

			logx.Infof("rds-migrate : run db migration [%v] on project [%v] from source files %v", options.DBName, options.project, options.MigrateSourceFiles)

			db, err := options.RDS.Connect(context.Background())
			if err != nil {
				logx.Panicf("rds-migrate: ran db [%v] migration failure on project [%v] with errors %v", options.DBName, options.project, err)
			}

			defer func() {
				if err := db.Close(); err != nil {
					logx.Warnf("rds-migrate : ran on err on close db %v", err)
				}
			}()

			logx.Infof("rds-migrate : ran db migration [%v] on project [%v] success", options.DBName, options.project)
		},
	}
)
