DROP TABLE IF EXISTS `SchedulePlatform_Temp`;
CREATE TABLE `SchedulePlatform_Temp`
(
    `ScheduleId`         bigint NOT NULL,
    `ProgrammeId`        bigint NOT NULL,
    `EpisodeId`          bigint NULL,
    `SchedulePlatformId` bigint NOT NULL,
    PRIMARY KEY (`SchedulePlatformId`),
    CONSTRAINT `SchedulePlatform_Temp_Schedule_FK` FOREIGN KEY (`ScheduleId`) REFERENCES `Schedule` (`Id`),
    CONSTRAINT `SchedulePlatform_Temp_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`),
    CONSTRAINT `SchedulePlatform_Temp_Episode_FK` FOREIGN KEY (`EpisodeId`) REFERENCES `Episode` (`Id`),
    CONSTRAINT `SchedulePlatform_Temp_SchedulePlatform_FK` FOREIGN KEY (`SchedulePlatformId`) REFERENCES `SchedulePlatform` (`Id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

INSERT INTO `SchedulePlatform_Temp`(`ScheduleId`, `ProgrammeId`, `EpisodeId`, `SchedulePlatformId`)
SELECT DISTINCT st.ScheduleId, s.ProgrammeId, e.Id as EpisodeId, st.SchedulePlatformId
FROM `Schedule` s
         JOIN `ScheduleTitle` st ON st.ScheduleId = s.Id
         JOIN `Programme` p ON p.Id = s.ProgrammeId
         JOIN `SchedulePlatform` sp ON sp.Id = st.SchedulePlatformId
         JOIN `Episode` e ON e.ProgrammeId = p.Id;

INSERT INTO `SchedulePlatform_Temp`(`ScheduleId`, `ProgrammeId`, `EpisodeId`, `SchedulePlatformId`)
SELECT DISTINCT se.ScheduleId, s.ProgrammeId, se.EpisodeId, se.SchedulePlatformId
FROM `Schedule` s
         JOIN `ScheduleEpisode` se ON se.ScheduleId = s.Id
         JOIN `Programme` p ON p.Id = s.ProgrammeId
         JOIN `SchedulePlatform` sp ON sp.Id = se.SchedulePlatformId;

ALTER TABLE `SchedulePlatform`
    ADD COLUMN `ScheduleId`  BIGINT NULL AFTER `ServiceId`,
    ADD COLUMN `ProgrammeId` BIGINT NULL AFTER `ScheduleId`,
    ADD COLUMN `EpisodeId`   BIGINT NULL AFTER `ProgrammeId`;

DROP PROCEDURE IF EXISTS migration_schedule_platform;
CREATE PROCEDURE migration_schedule_platform()
BEGIN
    DECLARE no_more_rows BOOLEAN DEFAULT FALSE;
    DECLARE schedule_pk BIGINT(20) DEFAULT 0;
    DECLARE programme_pk BIGINT(20) DEFAULT 0;
    DECLARE episode_pk BIGINT(20) DEFAULT 0;
    DECLARE schedule_platform_pk BIGINT(20) DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT ScheduleId, ProgrammeId, EpisodeId, SchedulePlatformId
        FROM `SchedulePlatform_Temp`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = true;

    SET no_more_rows = FALSE;

    OPEN cur;
    update_loop:
    WHILE(no_more_rows = FALSE)
        DO
            FETCH cur INTO schedule_pk, programme_pk, episode_pk,schedule_platform_pk;
            IF no_more_rows = TRUE THEN
                LEAVE update_loop;
            END IF;

            UPDATE `SchedulePlatform`
            SET `ScheduleId`  = schedule_pk,
                `ProgrammeId` = programme_pk,
                `EpisodeId`   = episode_pk
            WHERE Id = schedule_platform_pk;

        END WHILE update_loop;
    CLOSE cur;
END;

CALL migration_schedule_platform();
DROP PROCEDURE IF EXISTS migration_schedule_platform;

DELETE FROM `SchedulePlatform` Where `ScheduleId` IS NULL;

ALTER TABLE `SchedulePlatform`
    CHANGE COLUMN `ScheduleId` `ScheduleId` BIGINT NOT NULL,
    CHANGE COLUMN `ProgrammeId` `ProgrammeId` BIGINT NOT NULL;

ALTER TABLE `SchedulePlatform`
    ADD CONSTRAINT `SchedulePlatform_Schedule_FK` FOREIGN KEY (`ScheduleId`) REFERENCES `Schedule` (`Id`),
    ADD CONSTRAINT `SchedulePlatform_Programme_FK` FOREIGN KEY (`ProgrammeId`) REFERENCES `Programme` (`Id`),
    ADD CONSTRAINT `SchedulePlatform_Episode_FK` FOREIGN KEY (`EpisodeId`) REFERENCES `Episode` (`Id`);

DROP TABLE IF EXISTS `ScheduleTitle`;
DROP TABLE IF EXISTS `ScheduleEpisode`;
DROP TABLE IF EXISTS `SchedulePlatform_Temp`;
