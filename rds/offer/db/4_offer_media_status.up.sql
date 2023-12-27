ALTER TABLE Offer
    ADD COLUMN MediaStatusId BIGINT DEFAULT NULL AFTER `SeasonNumber`,
    ADD CONSTRAINT `Offer_MediaStatus_FK` FOREIGN KEY (`MediaStatusId`) REFERENCES MediaStatus (Id);

DROP PROCEDURE IF EXISTS migration_offer_media_status;
CREATE PROCEDURE migration_offer_media_status()
BEGIN
    DECLARE no_more_rows BOOLEAN DEFAULT FALSE;
    DECLARE media_pk BIGINT(20) DEFAULT 0;
    DECLARE status_pk BIGINT(20) DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT Id, MediaStatusId
        FROM `Media`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = true;

    SET no_more_rows = FALSE;

    OPEN cur;
    update_loop:
    WHILE(no_more_rows = FALSE)
        DO
            FETCH cur INTO media_pk, status_pk;
            IF no_more_rows = TRUE THEN
                LEAVE update_loop;
            END IF;

            UPDATE `Offer`
            SET `MediaStatusId` = status_pk
            WHERE `MediaId` = media_pk;

        END WHILE update_loop;
    CLOSE cur;
END;

CALL migration_offer_media_status();
DROP PROCEDURE IF EXISTS migration_offer_media_status;