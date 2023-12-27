ALTER TABLE `PlatformSchedule` ADD `WindowId` BIGINT DEFAULT NULL AFTER `ScheduleStatusId`;
ALTER TABLE `Allocation`ADD `IsDeleted` BOOLEAN DEFAULT FALSE AFTER `LandmarkRightsID`;