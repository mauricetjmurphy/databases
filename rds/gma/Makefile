GMA_DB ?= gmadb
RUN_GMA_MIGRATE = $(CMD_RDS_MIGRATE) --project gma --database $(GMA_DB)

migrate-gma:
	go run $(MAIN_RDS_MIGRATE) --project gma --database $(GMA_DB)

migrate-gma-dev:
	./$(RUN_GMA_MIGRATE) --secret-id gma-rds-db-credentials-dev

migrate-gma-stg:
	./$(RUN_GMA_MIGRATE) --secret-id gma-rds-db-credentials-stg

migrate-gma-prod:
	./$(RUN_GMA_MIGRATE) --secret-id gma-rds-db-credentials-prod

migrate-gma-dr:
	./$(RUN_GMA_MIGRATE) --disable
