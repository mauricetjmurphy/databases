CREATE TABLE IF NOT EXISTS `VFROrderStatus`
(
    `Id`   BIGINT      NOT NULL,
    `Name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

INSERT INTO `VFROrderStatus`
VALUES (1, 'Not Start'),
       (2, 'In Progress'),
       (3, 'Sent'),
       (4, 'Failed')
;

CREATE TABLE IF NOT EXISTS `VFROrder`
(
    `Id`                BIGINT       NOT NULL AUTO_INCREMENT,
    `OrderId`           BIGINT       NOT NULL,
    `VFROrderStatusId`  BIGINT       NOT NULL,
    `Format`            VARCHAR(25)  NOT NULL,
    `PlacingId`         VARCHAR(255) NOT NULL,
    `FileName`          VARCHAR(255) NOT NULL,
    `RetryAttemptCount` INT          NOT NULL DEFAULT 0,
    `SentAt`            DATETIME     NULL,
    `Error`             LONGTEXT     NULL,
    `CreatedDatim`      DATETIME     NOT NULL,
    `LastUpdatedDatim`  DATETIME     NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `VFROrder_Profile_FK` FOREIGN KEY (`OrderId`) REFERENCES `Profile` (`Id`),
    CONSTRAINT `VFROrder_VFROrderStatus_FK` FOREIGN KEY (`VFROrderStatusId`) REFERENCES `VFROrderStatus` (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;