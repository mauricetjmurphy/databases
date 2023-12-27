ALTER TABLE `ImageWorklist` ADD `IsDeleted` BOOLEAN DEFAULT FALSE AFTER `RequiredByDate`;
ALTER TABLE `MasterImage` ADD `IsDeleted` BOOLEAN DEFAULT FALSE AFTER `ImageFileId`;
ALTER TABLE `PlatformImage` ADD `IsDeleted` BOOLEAN DEFAULT FALSE AFTER `ImageFileId`;
ALTER TABLE `ImageFile` ADD `ExpiredTimeout` DATETIME DEFAULT NULL AFTER `UploadStatus`;