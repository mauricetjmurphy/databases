ALTER TABLE `MediaType`
    ADD `Code` VARCHAR(20) NULL;

ALTER TABLE `Language`
    ADD `CultureCode` VARCHAR(20) NULL,
    ADD `Code` VARCHAR(20) NULL;

ALTER TABLE `Vendor`
    ADD `Description` VARCHAR(20) NULL;

CREATE TABLE `Channel`
(
    `Id`          BIGINT      NOT NULL,
    `Name`        VARCHAR(45) NOT NULL,
    `DisplayName` VARCHAR(45) NULL,
    `Code`        VARCHAR(45) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `Series`
(
    `Id`    BIGINT       NOT NULL,
    `Title` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `ProgrammeType`
(
    `Id`   bigint       NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Programme`
(
    `Id`              BIGINT NOT NULL,
    `Title`           VARCHAR(255) NULL,
    `SeasonNumber`    INT NULL,
    `SlotDuration`    INT NULL,
    `ProgrammeTypeId` bigint NOT NULL,
    PRIMARY KEY (`Id`),
    INDEX             `Programme_Title_Idx` (`Title`),
    CONSTRAINT `Programme_ProgrammeType_FK` FOREIGN KEY (`ProgrammeTypeId`) REFERENCES `ProgrammeType` (`Id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `Episode`
(
    `Id`           BIGINT       NOT NULL,
    `Title`        VARCHAR(255) NOT NULL,
    `Number`       INT NULL,
    `SlotDuration` INT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `Contract`
(
    `Id`        BIGINT       NOT NULL,
    `Title`     VARCHAR(255) NULL,
    `Reference` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `POStatus`
(
    `Id`   INT         NOT NULL,
    `Name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `LanguageTracker`
(
    `Id`               BIGINT      NOT NULL AUTO_INCREMENT,
    `PONumber`         VARCHAR(25) NULL,
    `POStatusId`       INT NULL,
    `POCreated`        DATETIME NULL,
    `ChannelId`        BIGINT NULL,
    `LanguageId`       VARCHAR(25) NOT NULL,
    `MediaTypeId`      BIGINT      NOT NULL,
    `VendorId`         BIGINT      NOT NULL,
    `GroupKey`         VARCHAR(25) NOT NULL,
    `CreatedBy`        BIGINT      NOT NULL,
    `CreatedDatim`     DATETIME    NOT NULL,
    `LastUpdatedBy`    BIGINT      NOT NULL,
    `LastUpdatedDatim` DATETIME    NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `GroupKey_Uni` (`GroupKey`),
    CONSTRAINT `LanguageTracker_POStatus_FK` FOREIGN KEY (`POStatusId`) REFERENCES `POStatus` (`Id`),
    CONSTRAINT `LanguageTracker_Channel_FK` FOREIGN KEY (`ChannelId`) REFERENCES `Channel` (`Id`),
    CONSTRAINT `LanguageTracker_Language_FK` FOREIGN KEY (`LanguageId`) REFERENCES `Language` (`Id`),
    CONSTRAINT `LanguageTracker_MediaType_FK` FOREIGN KEY (`MediaTypeId`) REFERENCES `MediaType` (`Id`),
    CONSTRAINT `LanguageTracker_Vendor_FK` FOREIGN KEY (`VendorId`) REFERENCES `Vendor` (`Id`),
    CONSTRAINT `LanguageTracker_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    CONSTRAINT `LanguageTracker_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `OrderTracker`
(
    `Id`                      BIGINT   NOT NULL AUTO_INCREMENT,
    `LanguageTrackerId`       BIGINT   NOT NULL,
    `PONumber`                VARCHAR(25) NULL,
    `POStatusId`              INT NULL,
    `POCreated`               DATETIME NULL,
    `SeriesId`                BIGINT NULL,
    `ProgrammeId`             BIGINT   NOT NULL,
    `EpisodeId`               BIGINT   NOT NULL,
    `LanguageVersionId`       BIGINT NULL,
    `RateCardProgrammeTypeId` BIGINT NULL,
    `ServiceLevelId`          BIGINT NULL,
    `RateTypeId`              BIGINT NULL,
    `Component`               VARCHAR(255) NULL,
    `PlacedOrderDate`         DATETIME NULL,
    `ComponentStatus`         VARCHAR(255) NULL,
    `RequiredByDate`          DATETIME NULL,
    `VersionNumber`           VARCHAR(255) NULL,
    `Duration`                INT NULL,
    `Price`                   DECIMAL(15, 2) NULL,
    `CurrencyId`              BIGINT NULL,
    `OrderId`                 BIGINT NULL,
    `OrderStatus`             VARCHAR(255) NULL,
    `IsRemoved`               BOOLEAN  NOT NULL,
    `RightsId`                BIGINT NULL,
    `ContractId`              BIGINT NULL,
    `CreatedBy`               BIGINT   NOT NULL,
    `CreatedDatim`            DATETIME NOT NULL,
    `LastUpdatedBy`           BIGINT   NOT NULL,
    `LastUpdatedDatim`        DATETIME NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `OrderTracker_POStatus_FK` FOREIGN KEY (`POStatusId`) REFERENCES `POStatus` (`Id`),
    CONSTRAINT `OrderTracker_LanguageTracker_FK` FOREIGN KEY (`LanguageTrackerId`) REFERENCES `LanguageTracker` (`Id`),
    CONSTRAINT `OrderTracker_Series_FK` FOREIGN KEY (`SeriesId`) REFERENCES `Series` (`Id`),
    CONSTRAINT `OrderTracker_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`),
    CONSTRAINT `OrderTracker_Episode_FK` FOREIGN KEY (`EpisodeId`) REFERENCES `Episode` (`Id`),
    CONSTRAINT `OrderTracker_LanguageVersion_FK` FOREIGN KEY (`LanguageVersionId`) REFERENCES `LanguageVersion` (`Id`),
    CONSTRAINT `OrderTracker_RateCardProgrammeType_FK` FOREIGN KEY (`RateCardProgrammeTypeId`) REFERENCES `RateCardProgrammeType` (`Id`),
    CONSTRAINT `OrderTracker_ServiceLevel_FK` FOREIGN KEY (`ServiceLevelId`) REFERENCES `ServiceLevel` (`Id`),
    CONSTRAINT `OrderTracker_RateType_FK` FOREIGN KEY (`RateTypeId`) REFERENCES `RateType` (`Id`),
    CONSTRAINT `OrderTracker_Currency_FK` FOREIGN KEY (`CurrencyId`) REFERENCES `Currency` (`Id`),
    CONSTRAINT `OrderTracker_Contract_FK` FOREIGN KEY (`ContractId`) REFERENCES `Contract` (`Id`),
    CONSTRAINT `OrderTracker_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    CONSTRAINT `OrderTracker_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
