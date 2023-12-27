package domain

import (
	"github.com/mauricetjmurphy/ms-common/logx"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

func (r *Rights) BeforeCreate(tx *gorm.DB) error {
	if len(r.RightsChannelsDeletes) > 0 {
		if err := tx.Unscoped().Select(clause.Associations).Delete(r.RightsChannelsDeletes).Error; err != nil {
			logx.Errorf("hook beforeCreate : failed to delete rights channels on rights id %v on err %v", r.ID, err)
			return err
		}
	}
	return nil
}
