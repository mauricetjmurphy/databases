ALTER TABLE PlatformWindow
    DROP FOREIGN KEY `PlatformWindow_EventType_FK`,
    DROP COLUMN `EventTypeId`,
    DROP COLUMN `PreviousStartDate`;

ALTER TABLE SchedulePlatform
    DROP FOREIGN KEY `SchedulePlatform_Channel_FK`,
    DROP COLUMN `ChannelId`;

DELETE FROM EventType WHERE Id = 3;

DROP PROCEDURE IF EXISTS `migrate-linear-schedule`;





