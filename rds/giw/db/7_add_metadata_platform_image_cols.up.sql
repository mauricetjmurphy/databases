ALTER TABLE `PlatformImage`
    ADD COLUMN `Description` VARCHAR(255) NULL AFTER `ImageFileId`,
ADD COLUMN `Width` INT NULL AFTER `Description`,
ADD COLUMN `Height` INT NULL AFTER `Width`,
ADD COLUMN `Format` VARCHAR(25) NULL AFTER `Height`,
ADD COLUMN `IncludeInOrder` BOOLEAN DEFAULT FALSE AFTER `Format`;
