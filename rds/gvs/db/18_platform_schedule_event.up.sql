CREATE TABLE `EventType`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `EventType` VALUES (1, 'PlatformActiveEvent');

CREATE TABLE `PlatformScheduleEvent`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `PlatformScheduleId` bigint NOT NULL,
    `EventTypeId` bigint NOT NULL,
    `PlatformAvailabilityStart` datetime NOT NULL,
    `PlatformAvailabilityEnd` datetime NOT NULL,
    `IsChanged` boolean NOT NULL,
    `ApprovedBy` bigint NULL,
    `SerializedEvent` longtext NOT NULL,
    `CreatedDatim` datetime NOT NULL,
    `LastUpdatedDatim` datetime NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `PlatformScheduleEvent_EventType_FK` FOREIGN KEY (`EventTypeId`) REFERENCES `EventType` (`Id`),
    CONSTRAINT `PlatformScheduleEvent_SchedulePlatform_FK` FOREIGN KEY (`PlatformScheduleId`) REFERENCES `SchedulePlatform` (`Id`),
    CONSTRAINT `PlatformScheduleEvent_User_FK` FOREIGN KEY (`ApprovedBy`) REFERENCES `User` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;