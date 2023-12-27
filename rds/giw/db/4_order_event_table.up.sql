CREATE TABLE IF NOT EXISTS `OrderStatus`
(
    `Id`   BIGINT      NOT NULL,
    `Name` VARCHAR(45) NULL,
    PRIMARY KEY (`Id`)
) ENGINE = InnoDB CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO `OrderStatus` VALUES (1, 'Ready'), (2, 'Not Ready');

CREATE TABLE `OrderEvent`
(
    `Id`                    bigint       NOT NULL AUTO_INCREMENT,
    `OrderId`               varchar(255) NOT NULL,
    `FulfilmentProfileCode` VARCHAR(45)  NOT NULL,
    `PlatformCode`          VARCHAR(45)  NOT NULL,
    `EditId`                VARCHAR(255) NOT NULL,
    `PlacingId`             varchar(255) NOT NULL,
    `OrderStatusId`         BIGINT       NOT NULL,
    `CreatedDatim`          datetime     NOT NULL,
    `LastUpdatedDatim`      datetime     NOT NULL,
    PRIMARY KEY (`Id`),
    CONSTRAINT `OrderEvent_OrderStatus_FK` FOREIGN KEY (`OrderStatusId`) REFERENCES `OrderStatus` (`Id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

ALTER TABLE `PlatformImage` DROP COLUMN OrderId;
ALTER TABLE `PlatformImage` CHANGE `PlatformImageTemplateId` `TemplateId` bigint NULL;

