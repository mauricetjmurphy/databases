package domain

import (
	"github.com/NBCUniversal/gvs-ms-common/logx"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

func (c *Contract) BeforeCreate(tx *gorm.DB) error {
	if len(c.ContractTerritoryCountryDeletes) > 0 {
		if err := tx.Unscoped().Select(clause.Associations).Delete(c.ContractTerritoryCountryDeletes).Error; err != nil {
			logx.Errorf("hook BeforeCreate : failed to delete contract territory countries on contract id %v on err %v", c.ID, err)
			return err
		}
	}
	return nil
}
