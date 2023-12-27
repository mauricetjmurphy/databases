ALTER TABLE `BundleOptInService` RENAME TO `BundleService`;
ALTER TABLE `BundleContentSchedule` RENAME TO `BundleSchedule`;
ALTER TABLE `BundleContentPlatform` RENAME TO `BundlePlatform`;

ALTER TABLE `BundlePlatform` CHANGE `BundleContentScheduleId` `BundleScheduleId` bigint;

ALTER TABLE `BundleOptInPlatformProgrammeType` DROP FOREIGN KEY `BundleOptInPlatformProgrammeType_BundleOptInPlatform_FK`;
ALTER TABLE `BundleOptInPlatformProgrammeType` ADD CONSTRAINT `BundleOptInPlatformProgrammeType_BundleOptInPlatform_FK` FOREIGN KEY (`BundleOptInPlatformId`) REFERENCES `BundleOptInPlatform` (`Id`);

ALTER TABLE `BundleOptInPlatformBrand` DROP FOREIGN KEY `BundleOptInPlatformBrand_BundleOptInPlatform_FK`;
ALTER TABLE `BundleOptInPlatformBrand` ADD CONSTRAINT `BundleOptInPlatformBrand_BundleOptInPlatform_FK` FOREIGN KEY (`BundleOptInPlatformId`) REFERENCES `BundleOptInPlatform` (`Id`);

ALTER TABLE `Bundle`
    DROP INDEX `Bundle_Name_Idx`,
    ADD CONSTRAINT `Bundle_Name_PrimaryServiceId` UNIQUE (`Name`,`PrimaryServiceId`);
