ALTER TABLE Allocation DROP FOREIGN KEY `Allocation_Programme_FK`, DROP FOREIGN KEY `Allocation_AllocationService_FK`;
ALTER TABLE Profile DROP FOREIGN KEY `Profile_Programme_FK`, DROP FOREIGN KEY `Profile_Episode_FK`;
DROP TABLE IF EXISTS `Service`;
DROP TABLE IF EXISTS `Episode`;
DROP TABLE IF EXISTS `Programme`;
DROP TABLE IF EXISTS `ProgrammeType`;