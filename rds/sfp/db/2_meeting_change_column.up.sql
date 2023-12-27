ALTER TABLE `Meeting` ADD `MeetingDate` DATETIME  NOT NULL AFTER `Title`;
ALTER TABLE `Meeting` 
    DROP  `Date`,
    DROP  `Time`;