ALTER TABLE PlatformWindow
    DROP FOREIGN KEY FK_PlatformWindow_PlatformWindowSourceType,
    DROP COLUMN PlatformWindowSourceTypeId;

DROP TABLE IF EXISTS PlatformWindowSourceType;