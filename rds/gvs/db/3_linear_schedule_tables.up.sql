CREATE TABLE IF NOT EXISTS `LinearScheduleStatus`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `LinearScheduleStatus_Name_Uni` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `LinearScheduleStatus` VALUES (1, 'Updated'), (2, 'Acknowledge');

CREATE TABLE IF NOT EXISTS `LinearSchedule`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `SchedulePlatformId` bigint NOT NULL,
    `ChannelId` bigint NOT NULL,
    `ProgrammeId` BIGINT NOT NULL,
    `EpisodeId` bigint,
    `LinearEventId` bigint NOT NULL,
    `ScheduleStartDateTime` varchar(255),
    `PrePlatformWindowStart` datetime NULL,
    `LinearScheduleStatusId` bigint NULL,
    `CreatedDatim` datetime NOT NULL,
    `LastUpdatedDatim` datetime NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `LinearSchedule_SchedulePlatform_FK` FOREIGN KEY (`SchedulePlatformId`) REFERENCES `SchedulePlatform` (`Id`),
    CONSTRAINT `LinearSchedule_Channel_FK` FOREIGN KEY (`ChannelId`) REFERENCES `Channel` (`Id`),
    CONSTRAINT `LinearSchedule_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`),
    CONSTRAINT `LinearSchedule_Episode_FK` FOREIGN KEY (`EpisodeId`) REFERENCES `Episode` (`Id`),
    CONSTRAINT `LinearSchedule_LinearScheduleStatus_FK` FOREIGN KEY (`LinearScheduleStatusId`) REFERENCES `LinearScheduleStatus` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `LinearScheduleAction`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `ScheduleId` bigint NOT NULL,
    `UserId` bigint NULL,
    `LinearScheduleStatusId` bigint NULL,
    `CreatedDatim` datetime NOT NULL,
    `LastUpdatedDatim` datetime NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `LinearScheduleAction_Schedule_FK` FOREIGN KEY (`ScheduleId`) REFERENCES `Schedule` (`Id`),
    CONSTRAINT `LinearScheduleAction_UserId_FK` FOREIGN KEY (`UserId`) REFERENCES `User` (`Id`),
    CONSTRAINT `LinearScheduleAction_LinearScheduleStatus_FK` FOREIGN KEY (`LinearScheduleStatusId`) REFERENCES `LinearScheduleStatus` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;