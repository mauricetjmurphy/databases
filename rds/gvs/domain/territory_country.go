package domain

import (
	"github.com/NBCUniversal/gvs-ms-common/types/settings/objects"
)

const (
	TerritoryCountryTable = "TerritoryCountry"
)

type TerritoryCountry struct {
	TerritoryID uint       `gorm:"column:TerritoryId;primaryKey;"`
	Territory   *Territory `gorm:"foreignKey:TerritoryId;references:Id"`
	CountryID   uint       `gorm:"column:CountryId;primaryKey;"`
	Country     *Country   `gorm:"foreignKey:CountryId;references:Id"`
}

func NewTerritoryCountry(countries []*objects.Country) (rc []*TerritoryCountry) {
	for _, c := range countries {
		rc = append(rc, &TerritoryCountry{
			Country: NewCountry(c),
		})
	}
	return
}

func (tc *TerritoryCountry) Update(territoryCountry *TerritoryCountry) {
	if tc == nil || territoryCountry == nil {
		return
	}
	if territoryCountry.Territory != nil {
		tc.Territory.Update(territoryCountry.Territory)
	}
	if territoryCountry.Country != nil {
		tc.Country.Update(territoryCountry.Country)
	}
}

func (TerritoryCountry) TableName() string { return TerritoryCountryTable }
