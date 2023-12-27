ALTER TABLE PlatformWindow
    ADD COLUMN `PreviousStartDate` datetime,
    ADD COLUMN `EventTypeId` bigint,
    ADD CONSTRAINT `PlatformWindow_EventType_FK` FOREIGN KEY (`EventTypeId`) REFERENCES `EventType` (`Id`);


ALTER TABLE SchedulePlatform
    ADD COLUMN `ChannelId` bigint AFTER `TXDetails`,
    ADD CONSTRAINT `SchedulePlatform_Channel_FK` FOREIGN KEY (`ChannelId`) REFERENCES `Channel` (`Id`);

INSERT INTO EventType VALUES (3, "LinearEventUpdate");

CREATE PROCEDURE `migrate-linear-schedule`()
BEGIN
    DECLARE no_more_rows BOOLEAN DEFAULT FALSE;
    DECLARE platformScheduleId BIGINT;
    DECLARE newChannelId BIGINT;
    DECLARE txEventId BIGINT;
    DECLARE previousStartDate DATETIME;
    DECLARE platformWindowId BIGINT;
    DECLARE cur CURSOR FOR
    SELECT ls.SchedulePlatformId, ls.ChannelId, ls.LinearEventId, ls.PrePlatformWindowStart, pw.Id FROM LinearSchedule AS ls
        INNER JOIN PlatformWindow AS pw ON ls.SchedulePlatformId = pw.PlatformScheduleId;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = TRUE;
        SET no_more_rows = FALSE;
    OPEN cur;
    update_loop:
            WHILE(no_more_rows = FALSE)
                DO
                    FETCH cur INTO platformScheduleId, newChannelId, txEventId, previousStartDate, platformWindowId;
                    IF no_more_rows = TRUE THEN
                        LEAVE update_loop;
                    END IF;

                    UPDATE SchedulePlatform SET ChannelId = newChannelId WHERE Id = platformScheduleId;

                    UPDATE PlatformWindow SET TxEventId = txEventId, PreviousStartDate = previousStartDate WHERE Id = platformWindowId;

            END WHILE update_loop;
    CLOSE cur;
END;

CALL `migrate-linear-schedule` ();

DROP PROCEDURE `migrate-linear-schedule`;

DROP TABLE LinearScheduleAction;

DROP TABLE LinearSchedule;

DROP TABLE LinearScheduleStatus;


