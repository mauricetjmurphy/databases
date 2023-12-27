OFFER_DB ?= offerdb
RUN_OFFER_MIGRATE = $(CMD_RDS_MIGRATE) --project offer --database $(OFFER_DB)

migrate-offer:
	go run $(MAIN_RDS_MIGRATE) --project offer --database $(OFFER_DB)

migrate-offer-stg:
	$(DOCKER_RUN_GO) sh -c "make build"
	./$(RUN_OFFER_MIGRATE) --secret-id vodoffer-rds-db-credentials-stg

migrate-offer-prod:
	$(DOCKER_RUN_GO) sh -c "make build"
	./$(RUN_OFFER_MIGRATE) --secret-id vodoffer-rds-db-credentials-prod

migrate-offer-dr:
	$(DOCKER_RUN_GO) sh -c "make build"
	./$(RUN_OFFER_MIGRATE) --disable
