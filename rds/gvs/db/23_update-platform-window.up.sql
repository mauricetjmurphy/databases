DROP TABLE IF EXISTS PlatformWindowSourceType;

CREATE TABLE PlatformWindowSourceType (
    Id bigint NOT NULL,
    Name varchar(255) NOT NULL,
    PRIMARY KEY (Id)
);

INSERT INTO PlatformWindowSourceType (Id, Name) VALUES (1, 'Schedule');
INSERT INTO PlatformWindowSourceType (Id, Name) VALUES (2, 'Bundle');

ALTER TABLE PlatformWindow
    ADD COLUMN PlatformWindowSourceTypeId bigint NOT NULL DEFAULT 1,
    ADD CONSTRAINT FK_PlatformWindow_PlatformWindowSourceType FOREIGN KEY (PlatformWindowSourceTypeId) REFERENCES PlatformWindowSourceType (Id);

ALTER TABLE Schedule
    ADD CONSTRAINT Schedule_Service_FK FOREIGN KEY (ServiceId) REFERENCES Service (Id),
    ADD CONSTRAINT Schedule_Programme_FK FOREIGN KEY (ProgrammeId) REFERENCES Programme (Id),
    ADD CONSTRAINT Schedule_RightsType_FK FOREIGN KEY (RightsTypeId) REFERENCES RightsType (Id);