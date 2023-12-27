ALTER TABLE PlatformWindow
    DROP INDEX `PlatformWindow_TxEventId_Idx`,
    DROP COLUMN `TxEventId`,
    DROP COLUMN `TxPlayNo`,
    DROP COLUMN `TxNo`;
