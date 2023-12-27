ALTER TABLE `MasterImage`
DROP FOREIGN KEY `MasterImage_FileNameTemplate_FK`,
DROP COLUMN `FileNameTemplateId`;
DROP TABLE IF EXISTS `FileNameTemplate`;
DROP TABLE IF EXISTS `OrderType`;
