package domain

import (
	"github.com/mauricetjmurphy/ms-common/db/entity"
	"github.com/mauricetjmurphy/ms-common/types/settings/objects"
	"github.com/mauricetjmurphy/ms-common/types/settings/territory"
)

const (
	TerritoryTable = "Territory"
)

type Territory struct {
	*entity.Base
	Name               string              `gorm:"column:Name;"`
	TerritoryCountries []*TerritoryCountry `gorm:"foreignKey:TerritoryId;<-:false"`
}

func (Territory) TableName() string { return TerritoryTable }

// NewTerritory makes the Territory entity from given territory proto.
func NewTerritory(territory *territory.Territory) *Territory {
	if territory == nil {
		return nil
	}
	return &Territory{
		Base:               entity.NewBaseInt64(territory.GetId()),
		Name:               territory.GetName(),
		TerritoryCountries: NewTerritoryCountry(territory.GetCountries()),
	}
}

func NewTerritoryFromObject(territory *objects.Territory) *Territory {
	if territory == nil {
		return nil
	}
	return &Territory{
		Base: entity.NewBaseInt64(territory.GetId()),
		Name: territory.GetName(),
	}
}

func (t *Territory) Update(territory *Territory) {
	if t == nil || territory == nil {
		return
	}
	if territory.Name != "" {
		t.Name = territory.Name
	}
	t.TerritoryCountries = territory.TerritoryCountries
}

func (t *Territory) GetTerritory() *territory.Territory {
	if t == nil {
		return nil
	}
	var countries []*objects.Country
	for _, c := range t.TerritoryCountries {
		countries = append(countries, c.Country.GetCountry())
	}
	return &territory.Territory{
		Id:        int64(t.ID),
		Name:      t.Name,
		Countries: countries,
	}
}

func (t *Territory) GetObjectTerritory() *objects.Territory {
	if t == nil {
		return nil
	}
	return &objects.Territory{
		Id:   int64(t.ID),
		Name: t.Name,
	}
}
