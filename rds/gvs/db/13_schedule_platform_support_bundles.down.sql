ALTER TABLE `ProgrammeType` DROP `Code`;

ALTER TABLE `Programme` DROP `SeriesId`;

ALTER TABLE `SchedulePlatform`
    DROP INDEX `SchedulePlatform_BundleID_Idx`,
    DROP `BundleId`;