CREATE TABLE IF NOT EXISTS `BundlePlatformProgrammeType`
(
    `BundlePlatformId` bigint NOT NULL,
    `ProgrammeTypeId` bigint NOT NULL,
    PRIMARY KEY (`BundlePlatformId`, `ProgrammeTypeId`),
    CONSTRAINT `BundlePlatformProgrammeType_BundlePlatform_FK` FOREIGN KEY (`BundlePlatformId`) REFERENCES `BundlePlatform` (`Id`),
    CONSTRAINT `BundlePlatformProgrammeType_ProgrammeType_FK` FOREIGN KEY (`ProgrammeTypeId`) REFERENCES `ProgrammeType` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;