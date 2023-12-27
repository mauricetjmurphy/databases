CREATE TABLE IF NOT EXISTS `PlatformWindowType`
(
    `Id` bigint NOT NULL,
    `Name` varchar(255) NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `WindowConfigurationType_Name_Uni` (`Name`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `PlatformWindowType` (`Id`, `Name`) VALUES ('1', 'Multi Avails');
INSERT INTO `PlatformWindowType` (`Id`, `Name`) VALUES ('2', 'Split Season');

ALTER TABLE `PlatformWindow`
    ADD COLUMN `PlatformWindowTypeId` bigint DEFAULT null,
    ADD COLUMN `SplitSeasonGroupIndex` bigint DEFAULT null,
    ADD CONSTRAINT `PlatformWindow_PlatformWindowType_FK` FOREIGN KEY (`PlatformWindowTypeId`) REFERENCES `PlatformWindowType` (`Id`);