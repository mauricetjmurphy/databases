ALTER TABLE `ImageWorklist` DROP COLUMN `IsDeleted`;
ALTER TABLE `MasterImage` DROP COLUMN `IsDeleted`;
ALTER TABLE `PlatformImage` DROP COLUMN `IsDeleted`;
ALTER TABLE `ImageFile` DROP COLUMN `ExpiredTimeout`;