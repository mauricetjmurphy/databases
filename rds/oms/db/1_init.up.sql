CREATE TABLE IF NOT EXISTS `Order`
(
    `Id`                           bigint       NOT NULL AUTO_INCREMENT,
    `OrderID`                      varchar(255) NOT NULL,
    `FulfilmentProfileCode`        varchar(45)  NOT NULL,
    `Platform`                     varchar(45)  NOT NULL,
    `SourceVersionID`              varchar(255) NOT NULL,
    `SourceVersionCode`            varchar(255) NOT NULL,
    `Format`                       varchar(25)  NOT NULL,
    `PlacingID`                    varchar(255) NOT NULL,
    `PlatformWindowStartTimestamp` datetime     NOT NULL,
    `PlatformWindowEndTimestamp`   datetime     NOT NULL,
    `PackageDeliveryDateTimestamp` datetime     NULL,
    `EventID`                      varchar(255) NOT NULL,
    `Brand`                        varchar(255) NULL,
    `ServiceType`                  varchar(255) NULL,
    `TiedLinearChannel`            varchar(255) NULL,
    `CommercialInsertionAllowed`   varchar(25)  NULL,
    `FulfilmentSystem`             varchar(255) NULL,
    `RightsID`                     varchar(255) NULL,
    `ProgrammeID`                  BIGINT       NULL,
    `EpisodeID`                    BIGINT       NULL,
    `CountryCode`                  varchar(255) NULL,
    `PlatformImageStatus`          varchar(255) NULL,
    `CreatedDatim`                 datetime     NOT NULL,
    `LastUpdatedDatim`             datetime     NOT NULL,
    PRIMARY KEY (`Id`),
    INDEX `Order_OrderID_IDX` (`OrderID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
