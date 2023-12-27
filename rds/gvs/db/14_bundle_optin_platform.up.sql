ALTER TABLE `BundleOptInPlatform`
    ADD `ScheduleTimezoneId` bigint DEFAULT NULL AFTER `TitleValidationStatusId`,
    ADD  CONSTRAINT `BundleOptInPlatform_Timezone_FK` FOREIGN KEY (`ScheduleTimezoneId`) REFERENCES `Timezone` (`Id`);
