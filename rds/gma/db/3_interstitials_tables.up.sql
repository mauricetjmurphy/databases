CREATE TABLE IF NOT EXISTS `Interstitials`
(
    `Id`               BIGINT       NOT NULL AUTO_INCREMENT,
    `ProfileId`        BIGINT       NOT NULL,
    `VersionCert`      VARCHAR(255) NULL,
    `CertBoard`        VARCHAR(255) NULL,
    `CertMatId`        VARCHAR(255) NULL,
    `WarningBoard`     VARCHAR(255) NULL,
    `WarningMatId`     VARCHAR(255) NULL,
    `CreatedBy`        BIGINT       NOT NULL,
    `CreatedDatim`     DATETIME     NOT NULL,
    `LastUpdatedBy`    BIGINT       NOT NULL,
    `LastUpdatedDatim` DATETIME     NOT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `ProfileId_Uni` (`ProfileId`),
    CONSTRAINT `Interstitials_Profile_FK` FOREIGN KEY (`ProfileId`) REFERENCES `Profile` (`Id`),
    CONSTRAINT `Interstitials_UserCreatedBy_FK` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`),
    CONSTRAINT `Interstitials_UserLastUpdatedBy_FK` FOREIGN KEY (`LastUpdatedBy`) REFERENCES `User` (`Id`)
) ENGINE = InnoDB
  CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;