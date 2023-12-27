GIW_DB ?= giwdb
RUN_GIW_MIGRATE = $(CMD_RDS_MIGRATE) --project giw --database $(GIW_DB)

migrate-giw:
	go run $(MAIN_RDS_MIGRATE) --project giw --database $(GIW_DB)

migrate-giw-dev:
	./$(RUN_GIW_MIGRATE) --secret-id giw-rds-db-credentials-dev

migrate-giw-stg:
	./$(RUN_GIW_MIGRATE) --secret-id giw-rds-db-credentials-stg

migrate-giw-prod:
	./$(RUN_GIW_MIGRATE) --secret-id giw-rds-db-credentials-prod

migrate-giw-dr:
	./$(RUN_GIW_MIGRATE) --disable