ALTER TABLE `BundleContent` ADD COLUMN `BrandId` bigint DEFAULT NULL AFTER `TXDetails`;
DROP TABLE IF EXISTS `ProgrammeGenre`;
DROP TABLE IF EXISTS `Genre`;

ALTER TABLE `BundleContentPlatform`
    DROP FOREIGN KEY `BundlePlatform_Bundle_FK`,
    DROP `BundleId`;

ALTER TABLE `BundleOptInPlatform` DROP FOREIGN KEY `BundleOptInPlatform_PrimaryService_FK`;
ALTER TABLE `BundleOptInPlatform` DROP COLUMN `ServiceId`;