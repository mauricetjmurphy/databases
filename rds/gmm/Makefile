GMM_DB ?= gmmdb
RUN_GMM_MIGRATE = $(CMD_RDS_MIGRATE) --project gmm --database $(GMM_DB)

migrate-gmm:
	go run $(MAIN_RDS_MIGRATE) --project gmm --database $(GMM_DB)

migrate-gmm-dev:
	./$(RUN_GMM_MIGRATE) --secret-id gmm-rds-db-credentials-dev

migrate-gmm-stg:
	./$(RUN_GMM_MIGRATE) --secret-id gmm-rds-db-credentials-stg

migrate-gmm-prod:
	./$(RUN_GMM_MIGRATE) --secret-id gmm-rds-db-credentials-prod

migrate-gmm-dr:
	./$(RUN_GMM_MIGRATE) --disable