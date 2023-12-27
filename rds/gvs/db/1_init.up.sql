CREATE TABLE `User`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `SsoId` varchar(25) NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `SsoId_Uni` (`SsoId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Service`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Country`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    `Code` varchar(255) NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Territory`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ChannelType`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `Name` varchar(255) NOT NULL,
    `IsLinear` BOOLEAN NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Channel`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `Name` varchar(255) NOT NULL,
    `Code` varchar(255) NOT NULL,
    `ChannelTypeId` bigint NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `Channel_ChannelType_FK` FOREIGN KEY (`ChannelTypeId`) REFERENCES `ChannelType` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TerritoryCountry`
(
    `TerritoryId` bigint NOT NULL,
    `CountryId` bigint NOT NULL,
    PRIMARY KEY (`TerritoryId`, `CountryId`),
    CONSTRAINT `TerritoryCountry_Territory_FK` FOREIGN KEY (`TerritoryId`) REFERENCES `Territory` (`Id`),
    CONSTRAINT `TerritoryCountry_Country_FK` FOREIGN KEY (`CountryId`) REFERENCES `Country` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ProgrammeType`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Programme`
(
    `Id` bigint NOT NULL,
    `ProgrammeTypeId` bigint NOT NULL,
    `Title` varchar(255) NOT NULL,
    `NumberOfEpisodes` int,
    `SlotDuration` int,
    `SeasonNumber` int,
    `NumberOfSeasons` int,
    `Year` int,
    PRIMARY KEY (`Id`),
    INDEX `Programme_Title_Idx` (`Title`),
    CONSTRAINT `Programme_ProgrammeType_FK` FOREIGN KEY (`ProgrammeTypeId`) REFERENCES `ProgrammeType` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Episode`
(
    `Id` bigint NOT NULL,
    `ProgrammeId` bigint NOT NULL,
    `Title` varchar(255) NOT NULL,
    `Number` int NOT NULL,
    `YearOfProduction` int,
    PRIMARY KEY (`Id`),
    CONSTRAINT `Episode_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ContractStatus`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Contract`
(
    `Id` bigint NOT NULL,
    `Title` varchar(255) NOT NULL,
    `Reference` varchar(255) NOT NULL,
    `ContractStatusId` bigint NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `Contract_ContractStatus_FK` FOREIGN KEY (`ContractStatusId`) REFERENCES `ContractStatus` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Rights`
(
    `Id` bigint NOT NULL,
    `LandmarkRightsId` varchar(255) NOT NULL,
    `ContractId` bigint NOT NULL,
    `ProgrammeId` bigint NOT NULL,
    `StartDate` datetime NOT NULL,
    `EndDate` datetime NOT NULL,
    `LicensedEpisodes` int,
    `NumberOfEpisodes` int,
    PRIMARY KEY (`Id`),
    CONSTRAINT `rights_Contract_FK` FOREIGN KEY (`ContractId`) REFERENCES `Contract` (`Id`),
    CONSTRAINT `Rights_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `RightsType`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `RightsId` bigint NOT NULL,
    `Type` varchar(255) NOT NULL,
    `OnDemandRule` varchar(255),
    `OffsetFrom` varchar(255),
    `OffsetFor` varchar(255),
    `Availability` varchar(255),
    PRIMARY KEY (`Id`),
    UNIQUE KEY `RightsType_Uni` (`RightsId`, `Type`),
    CONSTRAINT `RightsType_Rights_FK` FOREIGN KEY (`RightsId`) REFERENCES `Rights` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `RightsChannel`
(
    `RightsId` bigint NOT NULL,
    `ChannelId` bigint NOT NULL,
    PRIMARY KEY (`RightsId`, `ChannelId`),
    CONSTRAINT `RightsChannel_Rights_FK` FOREIGN KEY (`RightsId`) REFERENCES `Rights` (`Id`),
    CONSTRAINT `RightsChannel_Channel_FK` FOREIGN KEY (`ChannelId`) REFERENCES `Channel` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `RightsTerritory`
(
    `RightsId` bigint NOT NULL,
    `TerritoryId` bigint NOT NULL,
    PRIMARY KEY (`RightsId`, `TerritoryId`),
    CONSTRAINT `RightsTerritory_Rights_FK` FOREIGN KEY (`RightsId`) REFERENCES `Rights` (`Id`),
    CONSTRAINT `RightsTerritory_Territory_FK` FOREIGN KEY (`TerritoryId`) REFERENCES `Territory` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PlatformType`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Platform`
(
    `Id` bigint NOT NULL,
    `PlatformTypeId` bigint DEFAULT NULL,
    `Name` varchar(255) NOT NULL,
    `DisplayName` varchar(255) NOT NULL,
    `Code` varchar(255),
    PRIMARY KEY (`Id`),
    CONSTRAINT `Platform_PlatformType_FK` FOREIGN KEY (`PlatformTypeId`) REFERENCES `PlatformType` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `OfferType`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TransmissionType`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE TransmissionType_Name_Uni(`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Timezone`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    `Time` varchar(255) NOT NULL,
    `IanaTimezone` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ScheduleStatus`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `ScheduleStatus_Name_Uni` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PlatformAvailability`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `StartDate` datetime NOT NULL,
    `EndDate` datetime NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `PlatformWindow`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `StartDate` datetime NOT NULL,
    `EndDate` datetime NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Schedule`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `ServiceId` bigint NOT NULL,
    `ProgrammeId` bigint NOT NULL,
    `RightsTypeId` bigint NOT NULL,
    `PlatformAvailabilityId` bigint NOT NULL,
    `PlatformWindowId` bigint DEFAULT NULL,
    `ScheduleStatusId` bigint NOT NULL,
    `CreatedBy` bigint NOT NULL,
    `CreatedDatim` datetime NOT NULL,
    `LastUpdatedBy` bigint NOT NULL,
    `LastUpdatedDatim` datetime NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE ServiceProgrammeRightsType_Uni(`ServiceId`, `ProgrammeId`, `RightsTypeId`),
    CONSTRAINT `Schedule_Service_FK` FOREIGN KEY (`ServiceId`) REFERENCES `Service` (`Id`),
    CONSTRAINT `Schedule_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`),
    CONSTRAINT `Schedule_RightsType_FK` FOREIGN KEY (`RightsTypeId`) REFERENCES `RightsType` (`Id`),
    CONSTRAINT `Schedule_PlatformAvailability_FK` FOREIGN KEY (`PlatformAvailabilityId`) REFERENCES `PlatformAvailability` (`Id`),
    CONSTRAINT `Schedule_PlatformWindow_FK` FOREIGN KEY (`PlatformWindowId`) REFERENCES `PlatformWindow` (`Id`),
    CONSTRAINT `Schedule_ScheduleStatus_FK` FOREIGN KEY (`ScheduleStatusId`) REFERENCES `ScheduleStatus` (`Id`),
    CONSTRAINT `Schedule_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    CONSTRAINT `Schedule_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `SchedulePlatform`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `ServiceId` bigint NOT NULL,
    `PlatformId` bigint NOT NULL,
    `TerritoryId` bigint NOT NULL,
    `OfferTypeId` bigint NOT NULL,
    `TransmissionTypeId` bigint DEFAULT NULL,
    `PlatformAvailabilityId` bigint NOT NULL,
    `ScheduleTimezoneId` bigint NOT NULL,
    `PlatformWindowId` bigint DEFAULT NULL,
    `ScheduleStatusId` bigint NOT NULL,
    PRIMARY KEY (Id),
    CONSTRAINT `SchedulePlatform_ServiceId_FK` FOREIGN KEY (`ServiceId`) REFERENCES `Service` (`Id`),
    CONSTRAINT `SchedulePlatform_Platform_FK` FOREIGN KEY (`PlatformId`) REFERENCES `Platform` (`Id`),
    CONSTRAINT `SchedulePlatform_Territory_FK` FOREIGN KEY (`TerritoryId`) REFERENCES `Territory` (`Id`),
    CONSTRAINT `SchedulePlatform_OfferType_FK` FOREIGN KEY (`OfferTypeId`) REFERENCES `OfferType` (`Id`),
    CONSTRAINT `SchedulePlatform_TransmissionType_FK` FOREIGN KEY (`TransmissionTypeId`) REFERENCES `TransmissionType` (`Id`),
    CONSTRAINT `SchedulePlatform_PlatformAvailability_FK` FOREIGN KEY (`PlatformAvailabilityId`) REFERENCES `PlatformAvailability` (`Id`),
    CONSTRAINT `SchedulePlatform_Timezone_FK` FOREIGN KEY (`ScheduleTimezoneId`) REFERENCES `Timezone` (`Id`),
    CONSTRAINT `SchedulePlatform_PlatformWindow_FK` FOREIGN KEY (`PlatformWindowId`) REFERENCES `PlatformWindow` (`Id`),
    CONSTRAINT `SchedulePlatform_ScheduleStatus_FK` FOREIGN KEY (`ScheduleStatusId`) REFERENCES `ScheduleStatus` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ScheduleEpisode`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `ScheduleId` bigint NOT NULL,
    `EpisodeId` bigint NOT NULL,
    `SchedulePlatformId` bigint NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `ScheduleEpisode_Schedule_FK` FOREIGN KEY (`ScheduleId`) REFERENCES `Schedule` (`Id`),
    CONSTRAINT `ScheduleEpisode_Episode_FK` FOREIGN KEY (`EpisodeId`) REFERENCES `Episode` (`Id`),
    CONSTRAINT `ScheduleEpisode_SchedulePlatform_FK` FOREIGN KEY (`SchedulePlatformId`) REFERENCES `SchedulePlatform` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ScheduleTitle`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `ScheduleId` bigint NOT NULL,
    `ProgrammeId` bigint NOT NULL,
    `SchedulePlatformId` bigint NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `ScheduleTitle_Schedule_FK` FOREIGN KEY (`ScheduleId`) REFERENCES `Schedule` (`Id`),
    CONSTRAINT `ScheduleTitle_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`),
    CONSTRAINT `ScheduleTitle_SchedulePlatform_FK` FOREIGN KEY (`SchedulePlatformId`) REFERENCES `SchedulePlatform` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;