SFP_DB ?= sfpdb
RUN_SFP_MIGRATE = $(CMD_RDS_MIGRATE) --project sfp --database $(SFP_DB)

migrate-sfp:
	go run $(MAIN_RDS_MIGRATE) --project sfp --database $(SFP_DB)

migrate-sfp-dev:
	./$(RUN_SFP_MIGRATE) --secret-id sfp-rds-db-credentials-dev

migrate-sfp-stg:
	./$(RUN_SFP_MIGRATE) --secret-id sfp-rds-db-credentials-stg

migrate-sfp-prod:
	./$(RUN_SFP_MIGRATE) --secret-id sfp-rds-db-credentials-prod

migrate-sfp-dr:
	./$(RUN_SFP_MIGRATE) --disable
