ALTER TABLE `BundleContentPlatform`
    DROP FOREIGN KEY `BundleContentPlatform_BundleOptInPlatform_FK`,
    DROP COLUMN `BundleOptInPlatformId`;

ALTER TABLE `BundleContentPlatform`
    ADD `TerritoryId` bigint DEFAULT NULL,
    ADD CONSTRAINT `BundlePlatform_Territory_FK` FOREIGN KEY (`TerritoryId`) REFERENCES `Territory` (`Id`),
    ADD `OfferTypeId` bigint DEFAULT NULL,
    ADD CONSTRAINT `BundlePlatform_OfferType_FK` FOREIGN KEY (`OfferTypeId`) REFERENCES `OfferType` (`Id`),
    ADD `PlatformId` bigint DEFAULT NULL,
    ADD CONSTRAINT `BundlePlatform_Platform_FK` FOREIGN KEY (`PlatformId`) REFERENCES `Platform` (`Id`);

DROP TABLE IF EXISTS `EpisodeGenre`;