CREATE TABLE EpisodeType (
    Id bigint NOT NULL,
    Name varchar(20) NOT NULL,
    PRIMARY KEY (Id),
    UNIQUE KEY `EpisodeType_Name_Uni` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `EpisodeType` VALUES (1, 'Licensed');
INSERT INTO `EpisodeType` VALUES (2, 'Unlicensed');

ALTER TABLE `Episode`
    ADD `EpisodeTypeId` bigint DEFAULT 1,
    ADD CONSTRAINT `Episode_EpisodeType_FK` FOREIGN KEY (`EpisodeTypeId`) REFERENCES `EpisodeType` (`Id`);