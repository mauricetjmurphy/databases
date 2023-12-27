CREATE TABLE `User`
(
    `Id`    BIGINT      NOT NULL AUTO_INCREMENT,
    `SsoId` VARCHAR(25) NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `SsoId_Uni` (`SsoId`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `Language`
(
    `Id`   VARCHAR(25) NOT NULL,
    `Name` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `Vendor`
(
    `Id`          BIGINT      NOT NULL,
    `Name`        VARCHAR(25) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `MediaType`
(
    `Id`          BIGINT      NOT NULL,
    `Description` VARCHAR(255) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `LanguageVersion`
(
    `Id`          BIGINT      NOT NULL,
    `Version`     VARCHAR(25) NOT NULL,
    `Description` VARCHAR(255) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `RateCardProgrammeType`
(
    `Id`          BIGINT      NOT NULL,
    `Type`        VARCHAR(25) NOT NULL,
    `Description` VARCHAR(255) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `ServiceLevel`
(
    `Id`          BIGINT      NOT NULL,
    `Level`       VARCHAR(25) NOT NULL,
    `Description` VARCHAR(255) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `RateType`
(
    `Id`   BIGINT      NOT NULL,
    `Name` VARCHAR(25) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `Currency`
(
    `Id`          BIGINT      NOT NULL,
    `Currency`    VARCHAR(25) NOT NULL,
    `Description` VARCHAR(255) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `RateCard`
(
    `Id`                      BIGINT         NOT NULL AUTO_INCREMENT,
    `VendorId`                BIGINT         NOT NULL,
    `LanguageId`              VARCHAR(25)    NOT NULL,
    `MediaTypeId`             BIGINT         NOT NULL,
    `LanguageVersionId`       BIGINT         NULL,
    `RateCardProgrammeTypeId` BIGINT         NULL,
    `ServiceLevelId`          BIGINT         NULL,
    `RateTypeId`              BIGINT         NOT NULL,
    `CurrencyId`              BIGINT         NOT NULL,
    `NumberOfVoices`          INT            NULL,
    `RateNumber`              DECIMAL(15, 2) NOT NULL,
    `DurationFrom`            INT            NULL,
    `DurationTo`              INT            NULL,
    `ValidityStartDate`       DATETIME       NULL,
    `ValidityEndDate`         DATETIME       NULL,
    `HashId`                  VARCHAR(45)    NOT NULL,
    `CreatedBy`               BIGINT         NOT NULL,
    `CreatedDatim`            DATETIME       NOT NULL,
    `LastUpdatedBy`           BIGINT         NOT NULL,
    `LastUpdatedDatim`        DATETIME       NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `HashId_Uni` (`HashId`),
    CONSTRAINT `RateCard_Vendor_FK` FOREIGN KEY (`VendorId`) REFERENCES `Vendor` (`Id`),
    CONSTRAINT `RateCard_Language_FK` FOREIGN KEY (`LanguageId`) REFERENCES `Language` (`Id`),
    CONSTRAINT `RateCard_MediaType_FK` FOREIGN KEY (`MediaTypeId`) REFERENCES `MediaType` (`Id`),
    CONSTRAINT `RateCard_LanguageVersion_FK` FOREIGN KEY (`LanguageVersionId`) REFERENCES `LanguageVersion` (`Id`),
    CONSTRAINT `RateCard_RateCardProgrammeType_FK` FOREIGN KEY (`RateCardProgrammeTypeId`) REFERENCES `RateCardProgrammeType` (`Id`),
    CONSTRAINT `RateCard_ServiceLevel_FK` FOREIGN KEY (`ServiceLevelId`) REFERENCES `ServiceLevel` (`Id`),
    CONSTRAINT `RateCard_RateType_FK` FOREIGN KEY (`RateTypeId`) REFERENCES `RateType` (`Id`),
    CONSTRAINT `RateCard_Currency_FK` FOREIGN KEY (`CurrencyId`) REFERENCES `Currency` (`Id`),
    CONSTRAINT `RateCard_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    CONSTRAINT `RateCard_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

INSERT INTO `RateType` (Id, Name) VALUES (1, 'Rate per min'), (2, 'Flat rate');
