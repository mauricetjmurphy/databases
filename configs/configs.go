package configs

import (
	"context"

	"github.com/mauricetjmurphy/ms-common/db"
)

type RDS struct {
	Host     string `yaml:"host" envconfig:"DB_HOST" default:"localhost"`
	Port     int    `yaml:"port" envconfig:"DB_PORT" default:"3306"`
	User     string `yaml:"user" envconfig:"DB_USER" default:"root"`
	Password string `yaml:"password" envconfig:"DB_PASSWORD"`
	DBName   string `yaml:"dbname" envconfig:"DB_NAME"`

	AWSRegion   string `yaml:"aws_region" envconfig:"AWS_REGION"`
	AWSSecretID string `yaml:"aws_secret_id" envconfig:"AWS_SECRET_ID"`

	// https://github.com/golang-migrate/migrate
	MigrateSourceFiles string `yaml:"migrate_source_files" envconfig:"MIGRATE_SOURCE_FILE"`
}

func (r *RDS) Connect(ctx context.Context) (db.DB, error) {
	return db.New(ctx,
		db.Host(r.Host),
		db.Port(r.Port),
		db.Name(r.DBName),
		db.User(r.User),
		db.Password(r.Password),
		db.AWSRegion(r.AWSRegion),
		db.AWSSecretID(r.AWSSecretID),
		db.MigrationSourceURL(r.MigrateSourceFiles),
	)
}
