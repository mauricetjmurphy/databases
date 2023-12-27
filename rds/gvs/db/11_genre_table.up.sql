CREATE TABLE IF NOT EXISTS `Genre`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    `Code` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ProgrammeGenre`
(
    `ProgrammeId` bigint NOT NULL,
    `GenreId` bigint NOT NULL,
    PRIMARY KEY (`ProgrammeId`, `GenreId`),
    CONSTRAINT `ProgrammeGenre_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`),
    CONSTRAINT `ProgrammeGenre_Genre_FK` FOREIGN KEY (`GenreId`) REFERENCES `Genre` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `BundleContentPlatform`
    ADD `BundleId` bigint DEFAULT NULL AFTER `Id`,
    ADD CONSTRAINT `BundlePlatform_Bundle_FK` FOREIGN KEY (`BundleId`) REFERENCES `Bundle` (`Id`);

ALTER TABLE `BundleProgrammeType`
    DROP FOREIGN KEY `BundleProgrammeType_Bundle_FK`,
    DROP FOREIGN KEY `BundleProgrammeType_ProgrammeType_FK`;

DROP TABLE IF EXISTS `BundleProgrammeType`;

ALTER TABLE `BundleContent` DROP FOREIGN KEY `BundleContent_Brand_FK`;
ALTER TABLE `BundleContent` DROP COLUMN `BrandId`;

ALTER TABLE `BundleOptInPlatform` ADD `ServiceId` bigint DEFAULT NULL AFTER `BundleId`;

DROP PROCEDURE IF EXISTS migration_bundle_opt_in_platform_primary_service;
CREATE PROCEDURE migration_bundle_opt_in_platform_primary_service()
BEGIN
    DECLARE no_more_rows BOOLEAN DEFAULT FALSE;
    DECLARE service_pk BIGINT(20) DEFAULT 0;
    DECLARE bundle_pk BIGINT(20) DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT Id, PrimaryServiceId
        FROM `Bundle`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = true;

    SET no_more_rows = FALSE;

    OPEN cur;
    update_loop:
    WHILE(no_more_rows = FALSE)
        DO
            FETCH cur INTO bundle_pk, service_pk;
            IF no_more_rows = TRUE THEN
                LEAVE update_loop;
            END IF;

            UPDATE `BundleOptInPlatform`
            SET `ServiceId` = service_pk
            WHERE `BundleId` = bundle_pk;

        END WHILE update_loop;
    CLOSE cur;
END;

CALL migration_bundle_opt_in_platform_primary_service();
DROP PROCEDURE IF EXISTS migration_bundle_opt_in_platform_primary_service;

ALTER TABLE `BundleOptInPlatform` MODIFY `ServiceId` bigint NOT NULL;
ALTER TABLE `BundleOptInPlatform` ADD CONSTRAINT `BundleOptInPlatform_Service_FK` FOREIGN KEY (`ServiceId`) REFERENCES `Service` (`Id`);

ALTER TABLE `Bundle` DROP COLUMN `NumberOfAssets`;
