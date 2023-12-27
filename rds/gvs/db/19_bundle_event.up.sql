INSERT INTO `EventType` VALUES (2, 'RightsUpdateSchedulesEvent');
INSERT INTO `EventType` VALUES (3, 'RightsUpdateBundlesEvent');

ALTER TABLE `PlatformScheduleEvent`
    MODIFY `PlatformScheduleId` bigint NULL,
    ADD COLUMN `BundleContentScheduleId` bigint NULL AFTER `PlatformScheduleId`,
    ADD CONSTRAINT `PlatformScheduleEvent_BundleContentSchedule_FK` FOREIGN KEY (`BundleContentScheduleId`) REFERENCES `BundleContentSchedule` (`Id`);

ALTER TABLE `Platform`
    ADD COLUMN `StartDate` datetime NULL AFTER `Code`,
    ADD COLUMN `EndDate` datetime NULL AFTER `StartDate`;