ALTER TABLE `BundleContentPlatform`
    DROP  FOREIGN KEY `BundlePlatform_OptInStatus_FK`,
    DROP `OptInStatusId` ,
    DROP `StatusReason` ;

DELETE FROM ScheduleStatus WHERE Id = 5;