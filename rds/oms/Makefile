OMS_DB ?= omsdb
RUN_OMS_MIGRATE = $(CMD_RDS_MIGRATE) --project oms --database $(OMS_DB)

migrate-oms:
	go run $(MAIN_RDS_MIGRATE) --project oms --database $(OMS_DB)

migrate-oms-dev:
	$(DOCKER_RUN_GO) sh -c "make build"
	./$(RUN_OMS_MIGRATE) --secret-id oms-rds-db-credentials-dev

migrate-oms-stg:
	$(DOCKER_RUN_GO) sh -c "make build"
	./$(RUN_OMS_MIGRATE) --secret-id oms-rds-db-credentials-stg

migrate-oms-prod:
	$(DOCKER_RUN_GO) sh -c "make build"
	./$(RUN_OMS_MIGRATE) --secret-id oms-rds-db-credentials-prod

migrate-oms-dr:
	$(DOCKER_RUN_GO) sh -c "make build"
	./$(RUN_OMS_MIGRATE) --disable
