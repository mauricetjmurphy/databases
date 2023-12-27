CREATE TABLE IF NOT EXISTS `Contact` 
(
   `Id`        bigint NOT NULL AUTO_INCREMENT,
   `Name`      VARCHAR(25) NOT NULL,
   `Email`     VARCHAR(255) NOT NULL,
   `Phone`     VARCHAR(20) NOT NULL,
   `OtherInfo` VARCHAR(255) NULL,
   PRIMARY KEY (`Id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Region` 
(
  `Id`   bigint NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `DocumentCategory` 
(
  `Id`   bigint NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Show` 
(
  `Id`        bigint NOT NULL AUTO_INCREMENT,
  `Name`      VARCHAR(25) NOT NULL,
  `OtherInfo` VARCHAR(225) NULL,
  `ContactId` BIGINT NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `Show_Contact_FK` FOREIGN KEY (`ContactId`) REFERENCES `Contact` (`Id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `Document` 
(
  `Id`            bigint NOT NULL AUTO_INCREMENT,
  `RegionId`      BIGINT NOT NULL,
  `CategoryId`    BIGINT NOT NULL,
  `SubcategoryId` BIGINT NULL,
  `Name`          VARCHAR(25) NOT NULL,
  `Path`          VARCHAR(25) NOT NULL,
  `OtherInfo`     VARCHAR(255) NULL,
  PRIMARY KEY (`Id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `FormSubcategory` 
(
  `Id`   bigint NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `ShowDocument` 
(
  `Id`         bigint NOT NULL AUTO_INCREMENT,
  `ShowId`     BIGINT NOT NULL,
  `DocumentId` BIGINT NOT NULL,
  PRIMARY KEY (`Id`), 
  CONSTRAINT `ShowDocument_Show_FK` FOREIGN KEY (`ShowId`) REFERENCES `Show` (`Id`), 
  CONSTRAINT `ShowDocument_Document_FK` FOREIGN KEY (`DocumentId`) REFERENCES `Document` (`Id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `Meeting`
(
   `Id`        bigint NOT NULL AUTO_INCREMENT,
   `ShowId`    BIGINT NOT NULL,
   `Title`     VARCHAR(25) NOT NULL,
   `Date`      DATE NOT NULL,
   `Time`      TIME NOT NULL,
   `Location`  VARCHAR(25) NOT NULL,
   `Agenda`    VARCHAR(255) NULL,
   `OtherInfo` VARCHAR(255) NULL,
   PRIMARY KEY (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `RecentlyUpdatedDocument`
(
   `Id`             bigint NOT NULL AUTO_INCREMENT,
   `DocumentId`     BIGINT NOT NULL,
   `ShowId`         BIGINT NOT NULL,
   `LastUpdateDate` DATETIME NOT NULL,
   `UpdateNote`     VARCHAR(255) NULL,
   PRIMARY KEY (`Id`),
  CONSTRAINT `RecentlyUpdatedDocument_Document_FK` FOREIGN KEY (`DocumentId`) REFERENCES `Document` (`Id`), 
  CONSTRAINT `RecentlyUpdatedDocument_Show_FK` FOREIGN KEY (`ShowId`) REFERENCES `Show` (`Id`)
) ENGINE = InnoDB  DEFAULT CHARSET = utf8mb4  COLLATE = utf8mb4_unicode_ci;