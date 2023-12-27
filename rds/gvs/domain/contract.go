package domain

import (
	"strconv"
	"strings"

	"github.com/mauricetjmurphy/ms-common/db/entity"
	"github.com/mauricetjmurphy/ms-common/types/settings/objects"
	"github.com/mauricetjmurphy/ms-common/types/settings/rights"
	"github.com/mauricetjmurphy/ms-common/types/settings/territory"
)

const (
	ContactTable = "Contract"
)

type Contract struct {
	*entity.Base
	Title                    string                     `gorm:"column:Title;"`
	Reference                string                     `gorm:"column:Reference;"`
	ContractStatusID         uint                       `gorm:"column:ContractStatusId;"`
	Status                   *ContractStatus            `gorm:"foreignKey:ContractStatusId;references:Id;"`
	ContractTerritoryCountry ContractTerritoryCountries `gorm:"foreignKey:ContractId;"`

	ContractTerritoryCountryDeletes ContractTerritoryCountries `gorm:"-"`
}

func (Contract) TableName() string { return ContactTable }

func NewContract(contract *rights.Contract, territories []*territory.Territory) *Contract {
	if contract == nil {
		return nil
	}
	return &Contract{
		Base:                     entity.NewBaseInt64(contract.GetId()),
		Title:                    contract.GetTitle(),
		Reference:                contract.GetReference(),
		Status:                   NewContractStatus(contract.Status),
		ContractTerritoryCountry: NewContractTerritoryCountry(contract.GetId(), territories),
	}
}

func (c *Contract) Update(contract *Contract) {
	if c == nil || contract == nil {
		return
	}
	if contract.Title != "" {
		c.Title = contract.Title
	}
	if contract.Reference != "" {
		c.Reference = contract.Reference
	}
	if contract.ContractStatusID > 0 {
		c.ContractStatusID = contract.ContractStatusID
	}
	if contract.Status != nil {
		c.Status = contract.Status
	}
	if len(contract.ContractTerritoryCountry) > 0 {
		c.UpdateContractTerritoryCountry(contract.ContractTerritoryCountry)
	}
}

func (c *Contract) GetContract() *rights.Contract {
	if c == nil {
		return nil
	}
	return &rights.Contract{
		Id:        int64(c.ID),
		Title:     c.Title,
		Reference: c.Reference,
		Status:    c.Status.GetContractStatus(),
	}
}

func (c *Contract) GetContractTerritoryCountry() []*territory.Territory {
	var (
		territoryCountries = make(map[string][]*objects.Country)
		territories        []*territory.Territory
	)

	for _, ctc := range c.ContractTerritoryCountry {
		territoryCountries[ctc.Key()] = append(territoryCountries[ctc.Key()], ctc.Country.GetCountry())
	}

	for t, countries := range territoryCountries {
		key := strings.Split(t, "-")
		id, _ := strconv.Atoi(key[0])
		territories = append(territories, &territory.Territory{
			Id:        int64(id),
			Name:      key[1],
			Countries: countries,
		})
	}

	return territories
}

func (c *Contract) UpdateContractTerritoryCountry(params ContractTerritoryCountries) {
	// Get all contract territory countries not exited in param
	for _, ctc := range c.ContractTerritoryCountry {
		if params.Match(ctc) == nil {
			c.ContractTerritoryCountryDeletes = append(c.ContractTerritoryCountryDeletes, ctc)
		}
	}

	// Repopulate actual contract territory countries
	if len(c.ContractTerritoryCountryDeletes) > 0 {
		for i := len(c.ContractTerritoryCountry) - 1; i >= 0; i-- {
			if c.ContractTerritoryCountryDeletes.Match(c.ContractTerritoryCountry[i]) != nil {
				c.ContractTerritoryCountry = append(c.ContractTerritoryCountry[:i], c.ContractTerritoryCountry[i+1:]...)
			}
		}
	}

	// Add new contract territory countries
	for _, param := range params {
		if c.ContractTerritoryCountry.Match(param) == nil {
			c.ContractTerritoryCountry = append(c.ContractTerritoryCountry, param)
		}
	}
}
