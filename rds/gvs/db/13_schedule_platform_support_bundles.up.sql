ALTER TABLE `BundleContent`
    DROP INDEX `BundleContent_Schedule_Idx`,
    DROP COLUMN `ScheduleId`;

ALTER TABLE `BundleContentPlatform`
    DROP INDEX `BundlePlatform_SchedulePlatform_Idx`,
    DROP COLUMN `SchedulePlatformId`;

ALTER TABLE `ProgrammeType` ADD `Code` varchar(255) DEFAULT NULL AFTER `Name`;

ALTER TABLE `Programme` ADD `SeriesId` bigint DEFAULT NULL AFTER `ProgrammeTypeId`;

ALTER TABLE `SchedulePlatform`
    ADD `BundleId` bigint DEFAULT NULL AFTER `OfferTypeId`,
    ADD INDEX `SchedulePlatform_BundleID_Idx` (`BundleId`);