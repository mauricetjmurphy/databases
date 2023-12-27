ALTER TABLE `Document` MODIFY `Path` VARCHAR(255);
ALTER TABLE `Document` MODIFY `Name` VARCHAR(255);

ALTER TABLE `Meeting` ADD `Attendee` VARCHAR(255) AFTER `MeetingDate`;
ALTER TABLE `Meeting` CHANGE `MeetingDate` `Duration` BIGINT;
ALTER TABLE `Meeting` MODIFY `Title` VARCHAR(255);

ALTER TABLE `Region` MODIFY `Name` VARCHAR(255);

ALTER TABLE `DocumentCategory` MODIFY `Name` VARCHAR(255);

ALTER TABLE `FormSubcategory` MODIFY `Name` VARCHAR(255);

CREATE TABLE IF NOT EXISTS `ProductionCompany`
(
  `Id`   bigint NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

ALTER TABLE `Show`
    MODIFY `Name` VARCHAR(255),
    ADD COLUMN `ProductionCompanyId` bigint AFTER `ContactId`,
    ADD CONSTRAINT Schedule_ProductionCompany_FK FOREIGN KEY (ProductionCompanyId) REFERENCES ProductionCompany (Id);

ALTER TABLE `Contact` ADD `ContactPosition` VARCHAR(255) AFTER `Phone`;

