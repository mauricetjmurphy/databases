ALTER TABLE `Language` MODIFY COLUMN `Name` VARCHAR (25);
ALTER TABLE `ImageFile`
    MODIFY COLUMN `FileName` VARCHAR (255),
    MODIFY COLUMN `Error` VARCHAR (255);

ALTER TABLE `ImageWorklist`
    DROP COLUMN `SeriesId`,
    DROP COLUMN `ProgrammeId`,
    DROP COLUMN `EpisodeId`;