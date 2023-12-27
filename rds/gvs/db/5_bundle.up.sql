CREATE TABLE IF NOT EXISTS `TitleValidationStatus`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `TitleValidationStatus_Name_Uni` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `TitleValidationStatus` (`Id`, `Name`) VALUES ('1', 'In Progress');
INSERT INTO `TitleValidationStatus` (`Id`, `Name`) VALUES ('2', 'Done');

CREATE TABLE IF NOT EXISTS `Bundle`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `Name` varchar(255) NOT NULL,
    `PrimaryServiceId` bigint NOT NULL,
    `NumberOfHours` bigint NOT NULL,
    `NumberOfTitles` bigint NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `Bundle_Name_PrimaryServiceId` UNIQUE (`Name`,`PrimaryServiceId`),
    CONSTRAINT `Bundle_PrimaryService_FK` FOREIGN KEY (`PrimaryServiceId`) REFERENCES `Service` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `BundleProgrammeType`
(
    `BundleId` bigint NOT NULL,
    `ProgrammeTypeId` bigint NOT NULL,
    PRIMARY KEY (`BundleId`, `ProgrammeTypeId`),
    CONSTRAINT `BundleProgrammeType_Bundle_FK` FOREIGN KEY (`BundleId`) REFERENCES `Bundle` (`Id`),
    CONSTRAINT `BundleProgrammeType_ProgrammeType_FK` FOREIGN KEY (`ProgrammeTypeId`) REFERENCES `ProgrammeType` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `BundleService`
(
    `BundleId` bigint NOT NULL,
    `ServiceId` bigint NOT NULL,
    PRIMARY KEY (`BundleId`, `ServiceId`),
    CONSTRAINT `BundleService_Service_FK` FOREIGN KEY (`ServiceId`) REFERENCES `Service` (`Id`),
    CONSTRAINT `BundleService_Bundle_FK` FOREIGN KEY (`BundleId`) REFERENCES `Bundle` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `BundlePlatform`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `BundleId` bigint NOT NULL,
    `PlatformId` bigint NOT NULL,
    `TerritoryId` bigint NOT NULL,
    `OfferTypeId` bigint NOT NULL,
    `PlatformStart` datetime DEFAULT NULL,
    `PlatformEnd` datetime DEFAULT NULL,
    `NumberOfHours` bigint NOT NULL,
    `NumberOfTitles` bigint NOT NULL,
    `TitleValidationStatusID` bigint NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `BundlePlatform_Bundle_FK` FOREIGN KEY (`BundleId`) REFERENCES `Bundle` (`Id`),
    CONSTRAINT `BundlePlatform_TitleValidationStatus_FK` FOREIGN KEY (`TitleValidationStatusID`) REFERENCES `TitleValidationStatus` (`Id`),
    CONSTRAINT `BundlePlatform_Platform_FK` FOREIGN KEY (`PlatformId`) REFERENCES `Platform` (`Id`),
    CONSTRAINT `BundlePlatform_Territory_FK` FOREIGN KEY (`TerritoryId`) REFERENCES `Territory` (`Id`),
    CONSTRAINT `BundlePlatform_OfferType_FK` FOREIGN KEY (`OfferTypeId`) REFERENCES `OfferType` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Brand`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `BundlePlatformBrand`
(
    `BundlePlatformId` bigint NOT NULL,
    `BrandId` bigint NOT NULL,
    PRIMARY KEY (`BundlePlatformId`, `BrandId`),
    CONSTRAINT `BundlePlatformBrand_BundlePlatform_FK` FOREIGN KEY (`BundlePlatformId`) REFERENCES `BundlePlatform` (`Id`),
    CONSTRAINT `BundlePlatformBrand_Brand_FK` FOREIGN KEY (`BrandId`) REFERENCES `Brand` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
