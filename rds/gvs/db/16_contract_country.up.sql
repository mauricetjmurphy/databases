ALTER TABLE `ProgrammeType` ADD `IsSingleProgram` boolean DEFAULT 0;

CREATE TABLE `ContractTerritoryCountry`
(
    `ContractId` bigint NOT NULL,
    `TerritoryId` bigint NOT NULL,
    `CountryId` bigint NOT NULL,
    PRIMARY KEY (`ContractId`, `TerritoryId`, `CountryId`),
    CONSTRAINT `ContractTerritoryCountry_Contract_FK` FOREIGN KEY (`ContractId`) REFERENCES `Contract` (`Id`),
    CONSTRAINT `ContractTerritoryCountry_Territory_FK` FOREIGN KEY (`TerritoryId`) REFERENCES `Territory` (`Id`),
    CONSTRAINT `ContractTerritoryCountry_Country_FK` FOREIGN KEY (`CountryId`) REFERENCES `Country` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
