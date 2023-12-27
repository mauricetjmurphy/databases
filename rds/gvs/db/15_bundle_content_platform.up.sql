ALTER TABLE `BundleContentPlatform`
    ADD `BundleOptInPlatformId` bigint DEFAULT NULL AFTER `BundleContentScheduleId`,
    ADD CONSTRAINT `BundleContentPlatform_BundleOptInPlatform_FK` FOREIGN KEY (`BundleOptInPlatformId`) REFERENCES `BundleOptInPlatform` (`Id`);

CREATE PROCEDURE migration_bundle_content_platform()
BEGIN
    DECLARE no_more_rows BOOLEAN DEFAULT FALSE;
    DECLARE optin_platform_pk BIGINT(20) DEFAULT 0;
    DECLARE bundle_pk BIGINT(20) DEFAULT 0;
    DECLARE platform_pk BIGINT(20) DEFAULT 0;
    DECLARE territory_pk BIGINT(20) DEFAULT 0;
    DECLARE offer_type_pk BIGINT(20) DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT Id, BundleId, PlatformId, TerritoryId, OfferTypeId
        FROM `BundleOptInPlatform`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = true;

    SET no_more_rows = FALSE;

    OPEN cur;
    update_loop:
        WHILE(no_more_rows = FALSE)
            DO
                FETCH cur INTO optin_platform_pk, bundle_pk, platform_pk, territory_pk, offer_type_pk;
                IF no_more_rows = TRUE THEN
                    LEAVE update_loop;
                END IF;

                UPDATE `BundleContentPlatform`
                SET `BundleOptInPlatformId` = optin_platform_pk
                WHERE `BundleId` = bundle_pk AND `PlatformId` = platform_pk AND `TerritoryId` = territory_pk AND `OfferTypeId` = offer_type_pk;

    END WHILE update_loop;
    CLOSE cur;
END;

CALL migration_bundle_content_platform();
DROP PROCEDURE IF EXISTS migration_bundle_content_platform;


ALTER TABLE `BundleContentPlatform`
    DROP FOREIGN KEY `BundlePlatform_Territory_FK`,
    DROP COLUMN `TerritoryId`,
    DROP FOREIGN KEY `BundlePlatform_Platform_FK`,
    DROP COLUMN `PlatformId`,
    DROP FOREIGN KEY `BundlePlatform_OfferType_FK`,
    DROP COLUMN `OfferTypeId`;

CREATE TABLE IF NOT EXISTS `EpisodeGenre`
(
    `EpisodeId` bigint NOT NULL,
    `GenreId` bigint NOT NULL,
    PRIMARY KEY (`EpisodeId`, `GenreId`),
    CONSTRAINT `EpisodeGenre_Episode_FK` FOREIGN KEY (`EpisodeId`) REFERENCES `Episode` (`Id`),
    CONSTRAINT `EpisodeGenre_Genre_FK` FOREIGN KEY (`GenreId`) REFERENCES `Genre` (`Id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;