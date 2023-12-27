ALTER TABLE `Episode`
    DROP CONSTRAINT `Episode_EpisodeType_FK`,
    DROP COLUMN `EpisodeTypeId`;

DROP TABLE `EpisodeType`;