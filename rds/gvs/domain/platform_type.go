package domain

import (
	"github.com/mauricetjmurphy/ms-common/db/entity"
	"github.com/mauricetjmurphy/ms-common/types/settings/platform"
)

const (
	PlatformTypeTable = "PlatformType"

	NBCUType       = "NBCU"
	ThirdPartyType = "3rd party"
)

type PlatformType struct {
	*entity.Base
	Name string `gorm:"column:Name;"`
}

func (PlatformType) TableName() string { return PlatformTypeTable }

func NewPlatformType(platformType *platform.PlatformType) *PlatformType {
	if platformType == nil {
		return nil
	}
	return &PlatformType{
		Base: entity.NewBaseInt64(platformType.GetId()),
		Name: platformType.GetName(),
	}
}

func (p *PlatformType) Update(platformType *PlatformType) {
	if p == nil || platformType == nil {
		return
	}
	if platformType.Name != "" {
		p.Name = platformType.Name
	}
}

func (p *PlatformType) GetPlatformType() *platform.PlatformType {
	if p == nil {
		return nil
	}
	return &platform.PlatformType{
		Id:   int64(p.ID),
		Name: p.Name,
	}
}

func (p *PlatformType) IsNBCUType() bool {
	return p != nil && p.Name == NBCUType
}

func (p *PlatformType) IsType(platformType string) bool {
	return p != nil && p.Name == platformType
}

func (p *PlatformType) IsThirdPartyType() bool {
	return p.Name == ThirdPartyType
}
