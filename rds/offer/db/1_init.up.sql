CREATE TABLE IF NOT EXISTS `MediaStatus`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`),
    INDEX `MediaStatus_Name_IDX` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Media`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `Affiliate` varchar(255) NOT NULL,
    `Product` varchar(255) NOT NULL,
    `MediaStatusId` bigint NOT NULL,
    `CreatedDatim` datetime NOT NULL,
    `LastUpdatedDatim` datetime NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `Media_Affiliate_Product_UNI` (`Affiliate`, `Product`),
    CONSTRAINT `Media_MediaStatus_FK` FOREIGN KEY (`MediaStatusId`) REFERENCES `MediaStatus` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Offer`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `MediaId` bigint NOT NULL,
    `SourceMaterialId` varchar(255) NOT NULL,
    `ChannelName` varchar(255) NOT NULL,
    `ProgrammeName` varchar(255) NOT NULL,
    `LicensingWindowStartUTC` datetime NOT NULL,
    `LicensingWindowEndUTC` datetime NOT NULL,
    `EpisodeNumber` int NOT NULL,
    `SeasonNumber` int NOT NULL,
    `CreatedDatim` datetime NOT NULL,
    `LastUpdatedDatim` datetime NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `Offer_Key_UNI` (`MediaId`, `SourceMaterialId`, `ChannelName`),
    CONSTRAINT `Offer_Media_FK` FOREIGN KEY (`MediaId`) REFERENCES `Media` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `MediaStatus` VALUES (1, 'Provisional'), (2, 'Updated'), (3, 'Completed');
