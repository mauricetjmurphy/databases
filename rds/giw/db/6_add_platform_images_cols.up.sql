ALTER TABLE `ImageWorklist` DROP COLUMN `ServiceId`, DROP COLUMN `ScheduleId`, DROP COLUMN `RequiredByDate`;
ALTER TABLE `MasterImage` DROP COLUMN `NumberOfPRI`;
ALTER TABLE `PlatformImage` ADD COLUMN `ServiceId` BIGINT NOT NULL AFTER `MasterImageId`,
ADD COLUMN `SeriesId` BIGINT NOT NULL AFTER `PlatformCode`,
ADD COLUMN `ProgrammeId` BIGINT NOT NULL AFTER `SeriesId`,
ADD COLUMN `EpisodeId` BIGINT NOT NULL AFTER `ProgrammeId`;