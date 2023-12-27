CREATE TABLE IF NOT EXISTS `OrderType`
(
    `Id` BIGINT NOT NULL,
    `Name` VARCHAR(255),
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

INSERT INTO `OrderType` VALUES (1, 'MI');

CREATE TABLE IF NOT EXISTS `FileNameTemplate`
(
    `Id` BIGINT NOT NULL,
    `MasterImageTypeId` BIGINT NOT NULL,
    `LevelId` BIGINT NOT NULL,
    `OrderTypeId` BIGINT NOT NULL,
    `FileName` VARCHAR(255),
    `IsDeleted`        BOOLEAN DEFAULT FALSE,
    `CreatedDatim`     DATETIME NOT NULL,
    `LastUpdatedDatim` DATETIME NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `FileNameTemplate_MasterImageType_FK` FOREIGN KEY (`MasterImageTypeId`) REFERENCES `MasterImageType` (`Id`),
    CONSTRAINT `FileNameTemplate_Level_FK` FOREIGN KEY (`LevelId`) REFERENCES `Level` (`Id`),
    CONSTRAINT `FileNameTemplate_OrderType_FK` FOREIGN KEY (`OrderTypeId`) REFERENCES `OrderType` (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

ALTER TABLE `MasterImage`
    ADD `FileNameTemplateId` BIGINT NULL AFTER `NumberOfPRI`,
    ADD CONSTRAINT `MasterImage_FileNameTemplate_FK` FOREIGN KEY (`FileNameTemplateId`) REFERENCES `FileNameTemplate` (`Id`);