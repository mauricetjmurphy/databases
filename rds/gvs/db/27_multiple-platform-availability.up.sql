CREATE TABLE IF NOT EXISTS `PlatformAvailability`
(
    `Id` bigint NOT NULL AUTO_INCREMENT,
    `PlatformScheduleId` bigint NOT NULL,
    `StartDate` datetime NOT NULL,
    `EndDate` datetime NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT FK_PlatformAvailability_SchedulePlatform FOREIGN KEY (PlatformScheduleId) REFERENCES SchedulePlatform (Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE PROCEDURE `migrate-platform-availability`()
BEGIN
    DECLARE no_more_rows BOOLEAN DEFAULT FALSE;
    DECLARE platformScheduleId BIGINT;
    DECLARE platformAvailabilityStart DATETIME;
    DECLARE platformAvailabilityEnd DATETIME;
    DECLARE cur CURSOR FOR
        SELECT Id, AvailabilityStart, AvailabilityEnd FROM SchedulePlatform;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = TRUE;
    SET no_more_rows = FALSE;
    OPEN cur;
    update_loop:
        WHILE(no_more_rows = FALSE)
            DO
                FETCH cur INTO platformScheduleId, platformAvailabilityStart, platformAvailabilityEnd;
                IF no_more_rows = TRUE THEN
                    LEAVE update_loop;
                END IF;

                INSERT INTO PlatformAvailability (Id, PlatformScheduleId, StartDate, EndDate)
                VALUES (platformScheduleId, platformScheduleId, platformAvailabilityStart, platformAvailabilityEnd);

            END WHILE update_loop;
    CLOSE cur;
END;

CALL `migrate-platform-availability` ();

DROP PROCEDURE `migrate-platform-availability`;