package domain

import (
	"github.com/mauricetjmurphy/ms-common/db/entity"
	"github.com/mauricetjmurphy/ms-common/types/settings/objects"
)

const (
	OfferTypeTable = "OfferType"
)

type OfferType struct {
	*entity.Base
	Name string `gorm:"column:Name;"`
}

func (OfferType) TableName() string { return OfferTypeTable }

// NewOfferType makes the OfferType entity from given offer type proto.
func NewOfferType(offerType *objects.OfferType) *OfferType {
	if offerType == nil {
		return nil
	}
	return &OfferType{
		Base: entity.NewBaseInt64(offerType.GetId()),
		Name: offerType.GetName(),
	}
}

func (ot *OfferType) Update(offerType *OfferType) {
	if ot == nil || offerType == nil {
		return
	}
	if offerType.Name != "" {
		ot.Name = offerType.Name
	}
}

func (ot *OfferType) GetOfferType() *objects.OfferType {
	if ot == nil {
		return nil
	}
	return &objects.OfferType{
		Id:   int64(ot.ID),
		Name: ot.Name,
	}
}
