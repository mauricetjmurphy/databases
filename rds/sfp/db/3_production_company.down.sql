ALTER TABLE `Document` MODIFY `Path` VARCHAR(25);

ALTER TABLE `Meeting` DROP COLUMN `Attendee`;
ALTER TABLE `Meeting` CHANGE `Duration` `MeetingDate` DATETIME;

ALTER TABLE `Show`
   DROP  FOREIGN KEY `Schedule_ProductionCompany_FK`;

DROP TABLE IF EXISTS `ProductionCompany`;

ALTER TABLE `Contact` DROP COLUMN `ContactPosition`;