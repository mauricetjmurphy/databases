ALTER TABLE `BundleOptInPlatformProgrammeType` DROP FOREIGN KEY `BundleOptInPlatformProgrammeType_BundleOptInPlatform_FK`;
ALTER TABLE `BundleOptInPlatformProgrammeType` ADD CONSTRAINT `BundleOptInPlatformProgrammeType_BundleOptInPlatform_FK` FOREIGN KEY (`BundleOptInPlatformId`) REFERENCES `BundleOptInPlatform` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `BundleOptInPlatformBrand` DROP FOREIGN KEY `BundleOptInPlatformBrand_BundleOptInPlatform_FK`;
ALTER TABLE `BundleOptInPlatformBrand` ADD CONSTRAINT `BundleOptInPlatformBrand_BundleOptInPlatform_FK` FOREIGN KEY (`BundleOptInPlatformId`) REFERENCES `BundleOptInPlatform` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Bundle`
    DROP INDEX `Bundle_Name_PrimaryServiceId`,
    ADD INDEX `Bundle_Name_Idx` (`Name`);

ALTER TABLE `BundleService` RENAME TO `BundleOptInService`;
ALTER TABLE `BundleSchedule` RENAME TO `BundleContentSchedule`;
ALTER TABLE `BundlePlatform` RENAME TO `BundleContentPlatform`;

ALTER TABLE `BundleContentPlatform` CHANGE `BundleScheduleId` `BundleContentScheduleId` bigint;
