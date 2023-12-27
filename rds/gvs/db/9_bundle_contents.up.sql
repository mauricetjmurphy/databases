ALTER TABLE `Bundle`
    DROP COLUMN `NumberOfHours`,
    DROP COLUMN `NumberOfTitles`,
    ADD COLUMN `NumberOfAssets` bigint DEFAULT NULL AFTER `PrimaryServiceId`,
    ADD COLUMN `CreatedBy` bigint DEFAULT NULL AFTER `NumberOfAssets`,
    ADD COLUMN `CreatedDatim` datetime DEFAULT CURRENT_TIMESTAMP AFTER `CreatedBy`,
    ADD COLUMN `LastUpdatedBy` bigint DEFAULT NULL AFTER `CreatedDatim`,
    ADD COLUMN `LastUpdatedDatim` datetime DEFAULT CURRENT_TIMESTAMP AFTER `LastUpdatedBy`,
    ADD CONSTRAINT `Bundle_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    ADD CONSTRAINT `Bundle_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`);

ALTER TABLE `BundlePlatformBrand` DROP FOREIGN KEY `BundlePlatformBrand_BundlePlatform_FK`;
ALTER TABLE `BundlePlatformProgrammeType` DROP FOREIGN KEY `BundlePlatformProgrammeType_BundlePlatform_FK`;

CREATE TABLE IF NOT EXISTS `OptInStatus`
(
    `Id` bigint NOT NULL,
    `Status` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `OptInStatus` (`Id`, `Status`) VALUES ('1', 'In');
INSERT INTO `OptInStatus` (`Id`, `Status`) VALUES ('2', 'Out');

CREATE TABLE IF NOT EXISTS `BundleContent`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `BundleId` bigint NOT NULL,
    `ScheduleId` bigint NULL,
    `ProgrammeId` bigint NOT NULL,
    `RightsId` bigint NOT NULL,
    `RightsTypeId` bigint NOT NULL,
    `TXTypeId` bigint DEFAULT NULL,
    `TXDetails` varchar(255) DEFAULT NULL,
    `BrandId` bigint DEFAULT NULL,
    `AvailabilityStart` datetime DEFAULT NULL,
    `AvailabilityEnd` datetime DEFAULT NULL,
    `TimezoneId` bigint NOT NULL,
    `WindowStart` datetime DEFAULT NULL,
    `WindowEnd` datetime DEFAULT NULL,
    `OptInStatusId` bigint DEFAULT NULL,
    `StatusReason` varchar(255) DEFAULT NULL,
    `CreatedBy` bigint NOT NULL,
    `CreatedDatim` datetime NOT NULL,
    `LastUpdatedBy` bigint NOT NULL,
    `LastUpdatedDatim` datetime NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `BundleContent_Bundle_FK` FOREIGN KEY (`BundleId`) REFERENCES `Bundle` (`Id`),
    CONSTRAINT `BundleContent_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`),
    CONSTRAINT `BundleContent_Rights_FK` FOREIGN KEY (`RightsId`) REFERENCES `Rights` (`Id`),
    CONSTRAINT `BundleContent_RightsType_FK` FOREIGN KEY (`RightsTypeId`) REFERENCES `RightsType` (`Id`),
    CONSTRAINT `BundleContent_TXType_FK` FOREIGN KEY (`TXTypeId`) REFERENCES `TransmissionType` (`Id`),
    CONSTRAINT `BundleContent_Brand_FK` FOREIGN KEY (`BrandId`) REFERENCES `Brand` (`Id`),
    CONSTRAINT `BundleContent_Timezone_FK` FOREIGN KEY (`TimezoneId`) REFERENCES `Timezone` (`Id`),
    CONSTRAINT `BundleContent_OptInStatus_FK` FOREIGN KEY (`OptInStatusId`) REFERENCES `OptInStatus` (`Id`),
    CONSTRAINT `BundleContent_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    CONSTRAINT `BundleContent_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`),
    INDEX `BundleContent_Schedule_Idx` (`ScheduleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `BundleSchedule`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `BundleContentId` bigint NOT NULL,
    `ProgrammeId` bigint NOT NULL,
    `EpisodeId` bigint DEFAULT NULL,
    `TXTypeId` bigint DEFAULT NULL,
    `TXDetails` varchar(255) DEFAULT NULL,
    `AvailabilityStart` datetime DEFAULT NULL,
    `AvailabilityEnd` datetime DEFAULT NULL,
    `TimezoneId` bigint NOT NULL,
    `WindowStart` datetime DEFAULT NULL,
    `WindowEnd` datetime DEFAULT NULL,
    `OptInStatusId` bigint DEFAULT NULL,
    `StatusReason` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `BundleSchedule_BundleContent_FK` FOREIGN KEY (`BundleContentId`) REFERENCES `BundleContent` (`Id`),
    CONSTRAINT `BundleSchedule_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`),
    CONSTRAINT `BundleSchedule_TXType_FK` FOREIGN KEY (`TXTypeId`) REFERENCES `TransmissionType` (`Id`),
    CONSTRAINT `BundleSchedule_Timezone_FK` FOREIGN KEY (`TimezoneId`) REFERENCES `Timezone` (`Id`),
    CONSTRAINT `BundleSchedule_OptInStatus_FK` FOREIGN KEY (`OptInStatusId`) REFERENCES `OptInStatus` (`Id`),
    INDEX `BundleSchedule_Episode_Idx` (`EpisodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `BundlePlatform`;

CREATE TABLE IF NOT EXISTS `BundlePlatform`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `BundleScheduleId` bigint NOT NULL,
    `PlatformId` bigint NOT NULL,
    `TerritoryId` bigint NOT NULL,
    `OfferTypeId` bigint NOT NULL,
    `SchedulePlatformId` bigint DEFAULT NULL,
    `CreatedDatim` datetime NOT NULL,
    `LastUpdatedDatim` datetime NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `BundlePlatform_BundleSchedule_FK` FOREIGN KEY (`BundleScheduleId`) REFERENCES `BundleSchedule` (`Id`),
    CONSTRAINT `BundlePlatform_Platform_FK` FOREIGN KEY (`PlatformId`) REFERENCES `Platform` (`Id`),
    CONSTRAINT `BundlePlatform_Territory_FK` FOREIGN KEY (`TerritoryId`) REFERENCES `Territory` (`Id`),
    CONSTRAINT `BundlePlatform_OfferType_FK` FOREIGN KEY (`OfferTypeId`) REFERENCES `OfferType` (`Id`),
    INDEX `BundlePlatform_SchedulePlatform_Idx` (`SchedulePlatformId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `BundleOptInPlatform`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `BundleId` bigint NOT NULL,
    `PlatformId` bigint NOT NULL,
    `TerritoryId` bigint NOT NULL,
    `OfferTypeId` bigint NOT NULL,
    `PlatformStart` datetime DEFAULT NULL,
    `PlatformEnd` datetime DEFAULT NULL,
    `NumberOfAssets` bigint DEFAULT NULL,
    `TitleValidationStatusId` bigint NOT NULL,
    `CreatedDatim` datetime NOT NULL,
    `LastUpdatedDatim` datetime NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `BundleOptInPlatform_Bundle_FK` FOREIGN KEY (`BundleId`) REFERENCES `Bundle` (`Id`),
    CONSTRAINT `BundleOptInPlatform_Platform_FK` FOREIGN KEY (`PlatformId`) REFERENCES `Platform` (`Id`),
    CONSTRAINT `BundleOptInPlatform_Territory_FK` FOREIGN KEY (`TerritoryId`) REFERENCES `Territory` (`Id`),
    CONSTRAINT `BundleOptInPlatform_OfferType_FK` FOREIGN KEY (`OfferTypeId`) REFERENCES `OfferType` (`Id`),
    CONSTRAINT `BundleOptInPlatform_TitleValidationStatus_FK` FOREIGN KEY (`TitleValidationStatusId`) REFERENCES `TitleValidationStatus` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

TRUNCATE TABLE `BundlePlatformBrand`;
TRUNCATE TABLE `BundlePlatformProgrammeType`;

ALTER TABLE `BundlePlatformBrand`
    RENAME TO `BundleOptInPlatformBrand`,
    CHANGE `BundlePlatformId` `BundleOptInPlatformId` bigint,
    ADD CONSTRAINT `BundleOptInPlatformBrand_BundleOptInPlatform_FK` FOREIGN KEY (`BundleOptInPlatformId`) REFERENCES `BundleOptInPlatform` (`Id`);

ALTER TABLE `BundlePlatformProgrammeType`
    RENAME TO `BundleOptInPlatformProgrammeType`,
    CHANGE `BundlePlatformId` `BundleOptInPlatformId` bigint,
    ADD CONSTRAINT `BundleOptInPlatformProgrammeType_BundleOptInPlatform_FK` FOREIGN KEY (`BundleOptInPlatformId`) REFERENCES `BundleOptInPlatform` (`Id`);