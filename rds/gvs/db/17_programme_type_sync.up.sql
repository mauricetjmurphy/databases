CREATE PROCEDURE adjust_programme_type(optinPlatformId INT, programmeTypeId INT, newProgrammeTypeId INT)
BEGIN
    DELETE FROM `BundleOptInPlatformProgrammeType` WHERE BundleOptInPlatformId = optinPlatformId AND ProgrammeTypeId = programmeTypeId;
    INSERT INTO `BundleOptInPlatformProgrammeType` VALUES (optinPlatformId, newProgrammeTypeId);
END;

CREATE PROCEDURE migration_opt_in_platform_programme_type()
BEGIN
    DECLARE no_more_rows BOOLEAN DEFAULT FALSE;
    DECLARE optin_platform_pk BIGINT(20) DEFAULT 0;
    DECLARE programme_type_pk BIGINT(20) DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT BundleOptInPlatformId, ProgrammeTypeId
        FROM `BundleOptInPlatformProgrammeType`
        WHERE `ProgrammeTypeId` IN (11, 12, 13, 15, 16, 17, 21 ,22);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = true;

    SET no_more_rows = FALSE;

    OPEN cur;
    update_loop:
            WHILE(no_more_rows = FALSE)
                DO
                    FETCH cur INTO optin_platform_pk, programme_type_pk;
                    IF no_more_rows = TRUE THEN
                        LEAVE update_loop;
                    END IF;

                    IF programme_type_pk = 11 THEN
                        CALL adjust_programme_type(optin_platform_pk, programme_type_pk, 3);
                    ELSEIF programme_type_pk = 12 THEN
                        CALL adjust_programme_type(optin_platform_pk, programme_type_pk, 4);
                    ELSEIF programme_type_pk = 13 THEN
                        CALL adjust_programme_type(optin_platform_pk, programme_type_pk, 5);
                    ELSEIF programme_type_pk = 15 THEN
                        CALL adjust_programme_type(optin_platform_pk, programme_type_pk, 6);
                    ELSEIF programme_type_pk = 16 THEN
                        CALL adjust_programme_type(optin_platform_pk, programme_type_pk, 7);
                    ELSEIF programme_type_pk = 17 THEN
                        CALL adjust_programme_type(optin_platform_pk, programme_type_pk, 9);
                    ELSEIF programme_type_pk = 21 THEN
                        CALL adjust_programme_type(optin_platform_pk, programme_type_pk, 19);
                    ELSEIF programme_type_pk = 22 THEN
                        CALL adjust_programme_type(optin_platform_pk, programme_type_pk, 20);
                    END IF;

            END WHILE update_loop;
    CLOSE cur;
END;

CALL migration_opt_in_platform_programme_type();
DROP PROCEDURE IF EXISTS adjust_programme_type;
DROP PROCEDURE IF EXISTS migration_opt_in_platform_programme_type;

UPDATE `Programme`
SET `ProgrammeTypeId` =
        CASE
            WHEN `ProgrammeTypeId` = 11 THEN 3
            WHEN `ProgrammeTypeId` = 12 THEN 4
            WHEN `ProgrammeTypeId` = 13 THEN 5
            WHEN `ProgrammeTypeId` = 15 THEN 6
            WHEN `ProgrammeTypeId` = 16 THEN 7
            WHEN `ProgrammeTypeId` = 17 THEN 9
            WHEN `ProgrammeTypeId` = 21 THEN 19
            WHEN `ProgrammeTypeId` = 22 THEN 20
            ELSE `ProgrammeTypeId`
END;

DELETE FROM `ProgrammeType` WHERE `Id` IN (11, 12, 13, 15, 16, 17, 21, 22);
