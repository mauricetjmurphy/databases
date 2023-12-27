package domain

import (
	"github.com/NBCUniversal/gvs-ms-common/types/settings/territory"
)

const (
	RightsTerritoryTable = "RightsTerritory"
)

type RightsTerritory struct {
	RightsID    uint       `gorm:"column:RightsId;primaryKey;"`
	Rights      *Rights    `gorm:"foreignKey:RightsId;references:Id"`
	TerritoryID uint       `gorm:"column:TerritoryId;primaryKey;"`
	Territory   *Territory `gorm:"foreignKey:TerritoryId;references:Id"`
}

func (RightsTerritory) TableName() string { return RightsTerritoryTable }

func NewRightsTerritory(territories []*territory.Territory) (rt []*RightsTerritory) {
	for _, t := range territories {
		rt = append(rt, &RightsTerritory{
			Territory: NewTerritory(t),
		})
	}
	return
}

func (rt *RightsTerritory) Update(rightsTerritory *RightsTerritory) {
	if rt == nil || rightsTerritory == nil {
		return
	}
	if rightsTerritory.Territory != nil {
		rt.Territory.Update(rightsTerritory.Territory)
	}
}
