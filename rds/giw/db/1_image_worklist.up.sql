CREATE TABLE `User`
(
    `Id`    bigint      NOT NULL AUTO_INCREMENT,
    `SsoId` varchar(25) NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `SsoId_Uni` (`SsoId`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `Level`
(
    `Id`   bigint      NOT NULL,
    `Name` varchar(25) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `AspectRatio`
(
    `Id`   bigint      NOT NULL,
    `Name` varchar(25) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `Language`
(
    `Id`   varchar(25) NOT NULL,
    `Name` varchar(25) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `MasterImageType`
(
    `Id`        bigint       NOT NULL,
    `Name`      varchar(25)  NOT NULL,
    `FileTypes` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `Orientation`
(
    `Id`   bigint      NOT NULL,
    `Name` varchar(25) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `ImageFile`
(
    `Id`           bigint NOT NULL AUTO_INCREMENT,
    `Width`        INT    NOT NULL,
    `Height`       INT    NOT NULL,
    `Size`         INT    NOT NULL,
    `Extension`    VARCHAR(255) NULL,
    `FileName`     VARCHAR(255) NULL,
    `UploadStatus` VARCHAR(255) NULL,
    `Error`        VARCHAR(255) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `ImageWorklist`
(
    `Id`               bigint   NOT NULL AUTO_INCREMENT,
    `ServiceId`        BIGINT   NOT NULL,
    `ScheduleId`       BIGINT   NOT NULL,
    `TitleId`          BIGINT   NOT NULL,
    `LevelId`          BIGINT   NOT NULL,
    `RequiredByDate`   DATE NULL,
    `CreatedBy`        BIGINT   NOT NULL,
    `CreatedDatim`     DATETIME NOT NULL,
    `LastUpdatedBy`    BIGINT   NOT NULL,
    `LastUpdatedDatim` DATETIME NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `ImageWorklist_Level_FK` FOREIGN KEY (`LevelId`) REFERENCES `Level` (`Id`),
    CONSTRAINT `ImageWorklist_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    CONSTRAINT `ImageWorklist_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `MasterImage`
(
    `Id`               bigint   NOT NULL AUTO_INCREMENT,
    `ImageWorklistId`  BIGINT   NOT NULL,
    `TypeId`           BIGINT   NOT NULL,
    `LevelId`          BIGINT   NOT NULL,
    `OrientationId`    BIGINT   NOT NULL,
    `LanguageId`       VARCHAR(25) NULL,
    `AspectRatioId`    BIGINT NULL,
    `SecondaryTags`    VARCHAR(255) NULL,
    `NumberOfPRI`      INT NULL,
    `ImageFileId`      BIGINT NULL,
    `CreatedBy`        BIGINT   NOT NULL,
    `CreatedDatim`     DATETIME NOT NULL,
    `LastUpdatedBy`    BIGINT   NOT NULL,
    `LastUpdatedDatim` DATETIME NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `MasterImage_ImageWorklist_FK` FOREIGN KEY (`ImageWorklistId`) REFERENCES `ImageWorklist` (`Id`),
    CONSTRAINT `MasterImage_Type_FK` FOREIGN KEY (`TypeId`) REFERENCES `MasterImageType` (`Id`),
    CONSTRAINT `MasterImage_Level_FK` FOREIGN KEY (`LevelId`) REFERENCES `Level` (`Id`),
    CONSTRAINT `MasterImage_Orientation_FK` FOREIGN KEY (`OrientationId`) REFERENCES `Orientation` (`Id`),
    CONSTRAINT `MasterImage_Language_FK` FOREIGN KEY (`LanguageId`) REFERENCES `Language` (`Id`),
    CONSTRAINT `MasterImage_AspectRatio_FK` FOREIGN KEY (`AspectRatioId`) REFERENCES `AspectRatio` (`Id`),
    CONSTRAINT `MasterImage_FileName_FK` FOREIGN KEY (`ImageFileId`) REFERENCES `ImageFile` (`Id`),
    CONSTRAINT `MasterImage_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    CONSTRAINT `MasterImage_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `PlatformImage`
(
    `Id`            bigint   NOT NULL AUTO_INCREMENT,
    `MasterImageId` BIGINT   NOT NULL,
    `ProfileId`     BIGINT   NOT NULL,
    `ChannelId`     BIGINT   NOT NULL,
    `PlatformId`    BIGINT   NOT NULL,
    `ImageFileId`   BIGINT NULL,
    `EditId`        VARCHAR(255) NULL,
    `UploadedBy`    BIGINT   NOT NULL,
    `UploadedDatim` DATETIME NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `PlatformImage_MasterImage_FK` FOREIGN KEY (`MasterImageId`) REFERENCES `MasterImage` (`Id`),
    CONSTRAINT `PlatformImage_FileName_FK` FOREIGN KEY (`ImageFileId`) REFERENCES `ImageFile` (`Id`),
    CONSTRAINT `PlatformImage_UploadedBy_FK` FOREIGN KEY (`UploadedBy`) REFERENCES `User` (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;