ALTER TABLE SchedulePlatform
    ADD COLUMN AvailabilityStart DATETIME AFTER PlatformAvailabilityId,
    ADD COLUMN AvailabilityEnd DATETIME AFTER AvailabilityStart,
    ADD COLUMN WindowStart DATETIME AFTER PlatformWindowId,
    ADD COLUMN WindowEnd DATETIME AFTER WindowStart;

ALTER TABLE PlatformWindow
    ADD COLUMN PlatformScheduleId bigint AFTER Id;

CREATE PROCEDURE `migrate-platform-dates`()
BEGIN
    DECLARE no_more_rows BOOLEAN DEFAULT FALSE;
    DECLARE platformScheduleId BIGINT;
    DECLARE platformWindowId BIGINT;
    DECLARE platformAvailabilityStart DATETIME;
    DECLARE platformAvailabilityEnd DATETIME;
    DECLARE platformWindowStart DATETIME;
    DECLARE platformWindowEnd DATETIME;
    DECLARE cur CURSOR FOR
        SELECT sp.Id, pw.Id, pa.StartDate, pa.EndDate, pw.StartDate, pw.EndDate
        FROM SchedulePlatform sp
             LEFT JOIN PlatformWindow pw ON sp.PlatformWindowId = pw.Id
             JOIN PlatformAvailability pa ON sp.PlatformAvailabilityId = pa.Id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = TRUE;
    SET no_more_rows = FALSE;
    OPEN cur;
    update_loop:
    WHILE(no_more_rows = FALSE)
        DO
            FETCH cur INTO platformScheduleId, platformWindowId, platformAvailabilityStart, platformAvailabilityEnd, platformWindowStart, platformWindowEnd;
            IF no_more_rows = TRUE THEN
                LEAVE update_loop;
            END IF;

            UPDATE SchedulePlatform
            SET WindowStart = platformWindowStart,
                WindowEnd = platformWindowEnd,
                AvailabilityStart = platformAvailabilityStart,
                AvailabilityEnd = platformAvailabilityEnd
            WHERE Id = platformScheduleId;

            IF platformWindowId IS NOT NULL THEN
                UPDATE PlatformWindow
                SET PlatformScheduleId = platformScheduleId
                WHERE Id = platformWindowId;
            END IF;

        END WHILE update_loop;
    CLOSE cur;
END;

CALL `migrate-platform-dates` ();

DROP PROCEDURE `migrate-platform-dates`;

ALTER TABLE Schedule
    DROP FOREIGN KEY Schedule_PlatformAvailability_FK,
    DROP FOREIGN KEY Schedule_PlatformWindow_FK,
    DROP COLUMN PlatformAvailabilityId,
    DROP COLUMN PlatformWindowId;

DELETE FROM PlatformWindow WHERE PlatformScheduleId IS NULL;

ALTER TABLE PlatformWindow
    MODIFY COLUMN PlatformScheduleId BIGINT NOT NULL,
    ADD CONSTRAINT FK_PlatformWindow_SchedulePlatform FOREIGN KEY (PlatformScheduleId) REFERENCES SchedulePlatform (Id);

ALTER TABLE SchedulePlatform
    DROP FOREIGN KEY SchedulePlatform_PlatformAvailability_FK,
    DROP FOREIGN KEY SchedulePlatform_PlatformWindow_FK,
    DROP COLUMN PlatformAvailabilityId,
    DROP COLUMN PlatformWindowId;

DROP TABLE PlatformAvailability;