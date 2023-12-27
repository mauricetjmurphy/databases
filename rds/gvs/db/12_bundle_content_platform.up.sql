ALTER TABLE `BundleContentPlatform`
    ADD `OptInStatusId` bigint DEFAULT NULL,
    ADD `StatusReason` varchar(255) DEFAULT NULL,
    ADD  CONSTRAINT `BundlePlatform_OptInStatus_FK` FOREIGN KEY (`OptInStatusId`) REFERENCES `OptInStatus` (`Id`);

ALTER TABLE Schedule
    DROP FOREIGN KEY Schedule_Service_FK,
    DROP FOREIGN KEY Schedule_Programme_FK,
    DROP FOREIGN KEY Schedule_RightsType_FK,
    DROP INDEX ServiceProgrammeRightsType_Uni;

INSERT INTO ScheduleStatus(Id, Name) VALUES (5, 'Deleted');

ALTER TABLE `BundleContent` DROP FOREIGN KEY `BundleContent_OptInStatus_FK`;
ALTER TABLE `BundleContent`
    DROP COLUMN `OptInStatusId`,
    DROP COLUMN `StatusReason`;

ALTER TABLE `BundleContentSchedule` DROP FOREIGN KEY `BundleSchedule_OptInStatus_FK`;
ALTER TABLE `BundleContentSchedule`
    DROP COLUMN `OptInStatusId`,
    DROP COLUMN `StatusReason`;

INSERT INTO `OptInStatus` (`Id`, `Status`) VALUES ('3', 'Custom offer');