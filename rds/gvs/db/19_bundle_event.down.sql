DELETE FROM `EventType` WHERE `Id` IN (2, 3);

ALTER TABLE `PlatformScheduleEvent`
    MODIFY `PlatformScheduleId` bigint NOT NULL,
    DROP COLUMN `BundleContentScheduleId`,
    DROP CONSTRAINT `PlatformScheduleEvent_BundleContentSchedule_FK`;

ALTER TABLE `Platform`
    DROP COLUMN `StartDate`,
    DROP COLUMN `EndDate`;
