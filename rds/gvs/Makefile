GVS_DB ?= gvsdb
RUN_GVS_MIGRATE = $(CMD_RDS_MIGRATE) --project gvs --database $(GVS_DB)

migrate-gvs:
	go run $(MAIN_RDS_MIGRATE) --project gvs --database $(GVS_DB)

migrate-gvs-dev:
	./$(RUN_GVS_MIGRATE) --secret-id rds-db-credentials-dev

migrate-gvs-stg:
	./$(RUN_GVS_MIGRATE) --secret-id rds-db-credentials-stg

migrate-gvs-prod:
	./$(RUN_GVS_MIGRATE) --secret-id rds-db-credentials-prod

migrate-gvs-dr:
	./$(RUN_GVS_MIGRATE) --disable