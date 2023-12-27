ALTER TABLE `PlatformWindow`
    DROP FOREIGN KEY `PlatformWindow_PlatformWindowType_FK`,
    DROP COLUMN `PlatformWindowTypeId`,
    DROP COLUMN `SplitSeasonGroupIndex`;

DROP TABLE IF EXISTS `PlatformWindowType`;
