UPDATE `LinearScheduleStatus` SET `Name` = 'Auto Updated' WHERE `Id` = 1;
ALTER TABLE `SchedulePlatform` ADD `TXDetails` varchar(255) DEFAULT NULL;