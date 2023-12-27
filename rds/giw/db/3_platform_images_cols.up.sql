ALTER TABLE `Language` MODIFY COLUMN Name VARCHAR (255);
ALTER TABLE `ImageFile`
    MODIFY COLUMN `FileName` VARCHAR (1000),
    MODIFY COLUMN `Error` VARCHAR (1000);
ALTER TABLE `ImageWorklist`
    ADD `SeriesId` BIGINT NULL AFTER `LevelId`,
    ADD `ProgrammeId` BIGINT NULL AFTER `SeriesId`,
    ADD `EpisodeId` BIGINT NULL AFTER `ProgrammeId`;
DROP TABLE IF EXISTS `PlatformImage`;
CREATE TABLE `PlatformImage`
(
    `Id`                      bigint      NOT NULL AUTO_INCREMENT,
    `MasterImageId`           BIGINT      NOT NULL,
    `FulfilmentProfileCode`   VARCHAR(45) NOT NULL,
    `PlatformCode`            VARCHAR(45) NOT NULL,
    `EditId`                  VARCHAR(255) NULL,
    `PlatformImageTemplateId` BIGINT NULL,
    `ImageFileId`             BIGINT NULL,
    `OrderId`                 BIGINT NULL,
    `CreatedBy`               BIGINT      NOT NULL,
    `CreatedDatim`            DATETIME    NOT NULL,
    `LastUpdatedBy`           BIGINT      NOT NULL,
    `LastUpdatedDatim`        DATETIME    NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `PlatformImage_MasterImage_FK` FOREIGN KEY (`MasterImageId`) REFERENCES `MasterImage` (`Id`),
    CONSTRAINT `PlatformImage_FileName_FK` FOREIGN KEY (`ImageFileId`) REFERENCES `ImageFile` (`Id`),
    CONSTRAINT `PlatformImage_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    CONSTRAINT `PlatformImage_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;