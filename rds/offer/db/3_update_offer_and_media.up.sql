ALTER TABLE Media
    ADD `AffiliateId` bigint default NULL,
    ADD `ProductId` bigint default NULL;

ALTER TABLE Offer
    ADD `ChannelId` bigint default NULL,
    ADD `PlacingId` varchar(255) DEFAULT NULL;