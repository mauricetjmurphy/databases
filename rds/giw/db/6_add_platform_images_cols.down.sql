ALTER TABLE `PlatformImage` DROP COLUMN `ServiceId`,
    DROP COLUMN `SeriesId`,
    DROP COLUMN `ProgrammeId`,
    DROP COLUMN `EpisodeId`;
ALTER TABLE `MasterImage` ADD COLUMN `NumberOfPRI` BIGINT NULL;
ALTER TABLE `ImageWorklist` ADD COLUMN `ServiceId` BIGINT NOT NULL,
    ADD COLUMN `ScheduleId` BIGINT NOT NULL,
    ADD COLUMN `RequiredByDate` DATE NULL;
