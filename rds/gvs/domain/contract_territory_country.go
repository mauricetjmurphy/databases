package domain

import (
	"fmt"

	"github.com/mauricetjmurphy/ms-common/types/settings/territory"
)

const (
	ContractTerritoryCountryTable = "ContractTerritoryCountry"
)

type ContractTerritoryCountries []*ContractTerritoryCountry

type ContractTerritoryCountry struct {
	ContractID  uint       `gorm:"column:ContractId;primaryKey;"`
	Contract    *Contract  `gorm:"foreignKey:ContractId;references:Id"`
	TerritoryID uint       `gorm:"column:TerritoryId;primaryKey;"`
	Territory   *Territory `gorm:"foreignKey:TerritoryId;references:Id"`
	CountryID   uint       `gorm:"column:CountryId;primaryKey;"`
	Country     *Country   `gorm:"foreignKey:CountryId;references:Id"`
}

func (ContractTerritoryCountry) TableName() string { return ContractTerritoryCountryTable }

func NewContractTerritoryCountry(contractID int64, territories []*territory.Territory) (ct []*ContractTerritoryCountry) {
	for _, t := range territories {
		for _, c := range t.GetCountries() {
			ct = append(ct, &ContractTerritoryCountry{
				ContractID:  uint(contractID),
				TerritoryID: uint(t.Id),
				Territory:   NewTerritory(t),
				CountryID:   uint(c.Id),
				Country:     NewCountry(c),
			})
		}
	}
	return
}

func (slices ContractTerritoryCountries) Match(param *ContractTerritoryCountry) *ContractTerritoryCountry {
	for _, ctc := range slices {
		if ctc.ContractID == param.ContractID && ctc.TerritoryID == param.TerritoryID && ctc.CountryID == param.CountryID {
			return ctc
		}
	}
	return nil
}

func (ctc *ContractTerritoryCountry) Key() string {
	if ctc.Territory != nil {
		return fmt.Sprintf("%v-%v", ctc.Territory.ID, ctc.Territory.Name)
	}
	return ""
}
