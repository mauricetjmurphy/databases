include rds/gvs/Makefile
include rds/offer/Makefile
include rds/gma/Makefile
include rds/giw/Makefile
include rds/oms/Makefile
include rds/gmm/Makefile
include rds/sfp/Makefile

GO_VERSION = 1.18
GO_BUILD_FLAGS = -ldflags "-s -w"
CMD_RDS_MIGRATE = bin/rds-migrate
MAIN_RDS_MIGRATE = cmd/rds-migrate/main.go

tidy:
	go mod tidy && go mod vendor

lint:
	 golangci-lint run

test:
	go test ./...

build:
	CGO_ENABLED=0 go build $(GO_BUILD_FLAGS) -o $(CMD_RDS_MIGRATE) cmd/rds-migrate/*.go

migrate:
	make migrate-gvs
	make migrate-gma
	make migrate-offer
	make migrate-giw
	make migrate-oms
	make migrate-gmm
	make migrate-sfp

migrate-dev:
	@echo "**************************make build started*****************************"
	make build
	@echo "**************************make build completed*****************************"
	
	@echo "**************************migrate-gvs-dev started*****************************"
	make migrate-gvs-dev
	@echo "**************************migrate-gvs-dev completed*****************************"
	
	@echo "**************************migrate-gma-dev started*****************************"
	make migrate-gma-dev
	@echo "**************************migrate-gma-dev completed*****************************"

	@echo "**************************migrate-giw-dev started*****************************"
	make migrate-giw-dev
	@echo "**************************migrate-giw-dev completed*****************************"

	@echo "**************************migrate-oms-dev started*****************************"
	make migrate-oms-dev
	@echo "**************************migrate-oms-dev completed*****************************"

	@echo "**************************migrate-gmm-dev started*****************************"
	make migrate-gmm-dev
	@echo "**************************migrate-gmm-dev completed*****************************"

	@echo "**************************migrate-sfp-dev started*****************************"
	make migrate-sfp-dev
	@echo "**************************migrate-sfp-dev completed*****************************"

migrate-stg:
	@echo "**************************make build started*****************************"
	make build
	@echo "**************************make build completed*****************************"
	
	@echo "**************************migrate-gvs-stg started*****************************"
	make migrate-gvs-stg
	@echo "**************************migrate-gvs-stg completed*****************************"

	@echo "**************************migrate-gma-stg completed*****************************"
	make migrate-gma-stg
	@echo "**************************migrate-gma-stg started*****************************"

	@echo "**************************migrate-offer-stg started*****************************"
	make migrate-offer-stg
	@echo "**************************migrate-offer-stg completed*****************************"

	@echo "**************************migrate-giw-stg started*****************************"
	make migrate-giw-stg
	@echo "**************************migrate-giw-stg completed*****************************"

	@echo "**************************migrate-oms-stg started*****************************"
	make migrate-oms-stg
	@echo "**************************migrate-oms-stg completed*****************************"

	@echo "**************************migrate-gmm-stg started*****************************"
	make migrate-gmm-stg
	@echo "**************************migrate-gmm-stg completed*****************************"
	
	@echo "**************************migrate-sfp-stg started*****************************"
	make migrate-sfp-stg
	@echo "**************************migrate-sfp-stg completed*****************************"

migrate-prod:
	@echo "**************************migrate-build started*****************************"
	make build
	@echo "**************************migrate-build completed*****************************"

	@echo "**************************migrate-gvs-stg started*****************************"
	make migrate-gvs-prod
	@echo "**************************migrate-gvs-stg completed*****************************"
	
	@echo "**************************migrate-gma-stg started*****************************"
	make migrate-gma-prod
	@echo "**************************migrate-gma-stg completed*****************************"
	
	@echo "**************************migrate-offer-prod started*****************************"
	make migrate-offer-prod
	@echo "**************************migrate-offer-prod completed*****************************"

	@echo "**************************migrate-giw-prod started*****************************"
	make migrate-giw-prod
	@echo "**************************migrate-giw-prod completed*****************************"

	@echo "**************************migrate-oms-prod started*****************************"
	make migrate-oms-prod
	@echo "**************************migrate-oms-prod completed***************************"

	@echo "**************************migrate-gmm-prod started*****************************"
	make migrate-gmm-prod
	@echo "**************************migrate-gmm-prod completed***************************"
