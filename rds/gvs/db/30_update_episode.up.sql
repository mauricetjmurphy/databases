ALTER TABLE Episode
    ADD COLUMN `SlotDuration` bigint;

ALTER TABLE Programme
    CHANGE COLUMN `SeriesId` `SeriesId` bigint AFTER `Year`,
    CHANGE COLUMN `SeriesTitle` `SeriesTitle` varchar(255) AFTER `SeriesId`;
