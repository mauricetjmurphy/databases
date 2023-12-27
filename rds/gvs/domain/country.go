package domain

import (
	"github.com/mauricetjmurphy/ms-common/db/entity"
	"github.com/mauricetjmurphy/ms-common/types/settings/objects"
)

const (
	CountryTable = "Country"
)

type Country struct {
	*entity.Base
	Name string `gorm:"column:Name;"`
	Code string `gorm:"column:Code;"`
}

func (Country) TableName() string { return CountryTable }

// NewCountry makes the Country entity from given country proto.
func NewCountry(country *objects.Country) *Country {
	if country == nil {
		return nil
	}
	return &Country{
		Base: entity.NewBaseInt64(country.GetId()),
		Name: country.GetName(),
		Code: country.GetCode(),
	}
}

func (c *Country) Update(country *Country) {
	if c == nil || country == nil {
		return
	}
	if country.Name != "" {
		c.Name = country.Name
	}
	if country.Code != "" {
		c.Code = country.Code
	}
}

func (c *Country) GetCountry() *objects.Country {
	if c == nil {
		return nil
	}
	return &objects.Country{
		Id:   int64(c.ID),
		Name: c.Name,
		Code: c.Code,
	}
}
