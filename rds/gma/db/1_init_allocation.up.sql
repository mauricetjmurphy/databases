CREATE TABLE `User`
(
    `Id`    bigint      NOT NULL AUTO_INCREMENT,
    `SsoId` varchar(25) NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `SsoId_Uni` (`SsoId`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Service`
(
    `Id`   BIGINT      NOT NULL,
    `Name` VARCHAR(45) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ProgrammeType`
(
    `Id`              BIGINT      NOT NULL,
    `Name`            VARCHAR(45) NULL,
    `Code`            VARCHAR(45) NULL,
    `IsSingleProgram` BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Programme`
(
    `Id`              BIGINT       NOT NULL,
    `Title`           VARCHAR(255) NULL,
    `ProgrammeTypeId` BIGINT       NOT NULL,
    `SeasonNumber`    INT          NULL,
    `SeriesId`        BIGINT       NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `Programme_ProgrammeType_FK` FOREIGN KEY (`ProgrammeTypeId`) REFERENCES `ProgrammeType` (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Episode`
(
    `Id`          BIGINT       NOT NULL,
    `ProgrammeId` BIGINT       NOT NULL,
    `Title`       VARCHAR(255) NULL,
    `Number`      INT          NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `Episode_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ScheduleStatus`
(
    `Id`   BIGINT      NOT NULL,
    `Name` VARCHAR(45) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ApprovalStatus`
(
    `Id`   BIGINT      NOT NULL,
    `Name` VARCHAR(45) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Territory`
(
    `Id`   BIGINT     NOT NULL,
    `Name` MEDIUMTEXT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `OfferType`
(
    `Id`   BIGINT      NOT NULL,
    `Name` VARCHAR(45) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Platform`
(
    `Id`          BIGINT      NOT NULL,
    `Name`        VARCHAR(45) NULL,
    `DisplayName` VARCHAR(45) NULL,
    `Code`        VARCHAR(45) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Channel`
(
    `Id`          BIGINT      NOT NULL,
    `Name`        VARCHAR(45) NULL,
    `DisplayName` VARCHAR(45) NULL,
    `Code`        VARCHAR(45) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Allocation`
(
    `Id`               BIGINT   NOT NULL AUTO_INCREMENT,
    `ServiceId`        BIGINT   NOT NULL,
    `ScheduleId`       BIGINT   NOT NULL,
    `ProgrammeId`      BIGINT   NOT NULL,
    `CreatedBy`        BIGINT   NOT NULL,
    `CreatedDatim`     DATETIME NOT NULL,
    `LastUpdatedBy`    BIGINT   NOT NULL,
    `LastUpdatedDatim` DATETIME NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `ScheduleId_Uni` (`ScheduleId`),
    CONSTRAINT `Allocation_AllocationService_FK` FOREIGN KEY (`ServiceId`) REFERENCES `Service` (`Id`),
    CONSTRAINT `Allocation_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`),
    CONSTRAINT `Allocation_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    CONSTRAINT `Allocation_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Profile`
(
    `Id`               BIGINT       NOT NULL AUTO_INCREMENT,
    `AllocationId`     BIGINT       NOT NULL,
    `ProgrammeId`      BIGINT       NOT NULL,
    `EpisodeId`        BIGINT       NULL,
    `PlatformId`       BIGINT       NULL,
    `AggregatorId`     BIGINT       NULL,
    `ChannelId`        BIGINT       NOT NULL,
    `IsDirty`          TINYINT      NULL,
    `DeliveryDate`     DATE         NULL,
    `PlatformStart`    DATETIME     NULL,
    `PlatformEnd`      DATETIME     NULL,
    `DurationDays`     INT          NULL,
    `Version`          VARCHAR(255) NULL,
    `EditId`           VARCHAR(255) NULL,
    `Format`           VARCHAR(255) NULL,
    `EventId`          VARCHAR(255) NULL,
    `ApprovalStatusId` BIGINT       NULL,
    `IsDeleted`        BOOLEAN DEFAULT FALSE,
    `CreatedBy`        BIGINT       NOT NULL,
    `CreatedDatim`     DATETIME     NOT NULL,
    `LastUpdatedBy`    BIGINT       NOT NULL,
    `LastUpdatedDatim` DATETIME     NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `Profile_Allocation_FK` FOREIGN KEY (`AllocationId`) REFERENCES `Allocation` (`Id`),
    CONSTRAINT `Profile_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`),
    CONSTRAINT `Profile_Episode_FK` FOREIGN KEY (`EpisodeId`) REFERENCES `Episode` (`Id`),
    CONSTRAINT `Profile_Platform_FK` FOREIGN KEY (`PlatformId`) REFERENCES `Platform` (`Id`),
    CONSTRAINT `Profile_Aggregator_FK` FOREIGN KEY (`AggregatorId`) REFERENCES `Platform` (`Id`),
    CONSTRAINT `Profile_Channel_FK` FOREIGN KEY (`ChannelId`) REFERENCES `Channel` (`Id`),
    CONSTRAINT `Profile_ApprovalStatus_FK` FOREIGN KEY (`ApprovalStatusId`) REFERENCES `ApprovalStatus` (`Id`),
    CONSTRAINT `Profile_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    CONSTRAINT `Profile_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `PlatformSchedule`
(
    `Id`                 BIGINT   NOT NULL AUTO_INCREMENT,
    `ProfileId`          BIGINT   NOT NULL,
    `PlatformScheduleId` BIGINT   NOT NULL,
    `ProgrammeId`        BIGINT   NOT NULL,
    `EpisodeId`          BIGINT   NULL,
    `PlatformId`         BIGINT   NOT NULL,
    `TerritoryId`        BIGINT   NOT NULL,
    `OfferTypeId`        BIGINT   NOT NULL,
    `PlatformStart`      DATETIME NULL,
    `PlatformEnd`        DATETIME NULL,
    `ScheduleStatusId`   BIGINT   NOT NULL,
    `IsDeleted`          BOOLEAN DEFAULT FALSE,
    `CreatedDatim`       DATETIME NOT NULL,
    `LastUpdatedDatim`   DATETIME NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `PlatformSchedule_Profile_FK` FOREIGN KEY (`ProfileId`) REFERENCES `Profile` (`Id`),
    CONSTRAINT `PlatformSchedule_Platform_FK` FOREIGN KEY (`PlatformId`) REFERENCES `Platform` (`Id`),
    CONSTRAINT `PlatformSchedule_Territory_FK` FOREIGN KEY (`TerritoryId`) REFERENCES `Territory` (`Id`),
    CONSTRAINT `PlatformSchedule_OfferType_FK` FOREIGN KEY (`OfferTypeId`) REFERENCES `OfferType` (`Id`),
    CONSTRAINT `PlatformSchedule_ScheduleStatus_FK` FOREIGN KEY (`ScheduleStatusId`) REFERENCES `ScheduleStatus` (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

INSERT INTO `ApprovalStatus`
VALUES (1, 'Action Needed'),
       (2, 'Pending Approval'),
       (3, 'Approved');
