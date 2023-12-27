package domain

import (
	"time"

	"github.com/NBCUniversal/gvs-ms-common/db/entity"
	"github.com/NBCUniversal/gvs-ms-common/libs/datetime"
	"github.com/NBCUniversal/gvs-ms-common/types/settings/objects"
	"github.com/NBCUniversal/gvs-ms-common/types/settings/platform"
)

const (
	PlatformTable = "Platform"
)

type Platform struct {
	*entity.Base
	Name           string        `gorm:"column:Name;"`
	Code           string        `gorm:"column:Code;"`
	DisplayName    string        `gorm:"column:DisplayName;"`
	PlatformTypeID *uint         `gorm:"column:PlatformTypeId;"`
	PlatformType   *PlatformType `gorm:"foreignKey:PlatformTypeId;references:Id;"`
	StartDate      *time.Time    `gorm:"column:StartDate"`
	EndDate        *time.Time    `gorm:"column:EndDate"`
}

func (Platform) TableName() string { return PlatformTable }

func NewPlatform(platform *platform.Platform) *Platform {
	if platform == nil {
		return nil
	}
	start, end := GetPlatformActiveDates(platform)
	return &Platform{
		Base:         entity.NewBaseInt64(platform.GetId()),
		Name:         platform.GetName(),
		Code:         platform.GetCode(),
		DisplayName:  platform.GetDisplayName(),
		PlatformType: NewPlatformType(platform.GetPlatformType()),
		StartDate:    start,
		EndDate:      end,
	}
}

func GetPlatformActiveDates(platform *platform.Platform) (*time.Time, *time.Time) {
	for _, p := range platform.PlatformDates {
		if p.IsActive {
			start, _ := time.Parse(datetime.DateUTC, p.StartDate)
			end, _ := time.Parse(datetime.DateUTC, p.EndDate)
			return &start, &end
		}
	}
	return nil, nil
}

func (p *Platform) Update(platform *Platform) {
	if p == nil || platform == nil {
		return
	}
	if platform.Name != "" {
		p.Name = platform.Name
	}
	if platform.Code != "" {
		p.Code = platform.Code
	}
	if platform.DisplayName != "" {
		p.DisplayName = platform.DisplayName
	}
	if platform.PlatformTypeID != nil {
		p.PlatformTypeID = platform.PlatformTypeID
	}
	if platform.PlatformType != nil {
		p.PlatformType.Update(platform.PlatformType)
	}
	if platform.StartDate != nil {
		p.StartDate = platform.StartDate
	}
	if platform.EndDate != nil {
		p.EndDate = platform.EndDate
	}
}

func (p *Platform) GetPlatform() *platform.Platform {
	if p == nil {
		return nil
	}
	var platformDates []*platform.PlatformDate
	if p.StartDate != nil && p.EndDate != nil {
		platformDates = []*platform.PlatformDate{
			{
				StartDate: p.StartDate.Format(datetime.DateUTC),
				EndDate:   p.EndDate.Format(datetime.DateUTC),
				IsActive:  true,
			},
		}
	}

	return &platform.Platform{
		Id:            int64(p.ID),
		Name:          p.Name,
		Code:          p.Code,
		DisplayName:   p.DisplayName,
		PlatformType:  p.PlatformType.GetPlatformType(),
		PlatformDates: platformDates,
	}
}

func NewPlatformFromObject(platform *objects.Platform) *Platform {
	if platform == nil {
		return nil
	}
	return &Platform{
		Base:        entity.NewBaseInt64(platform.GetId()),
		Name:        platform.GetName(),
		DisplayName: platform.GetDisplayName(),
		Code:        platform.GetCode(),
	}
}

func (p *Platform) GetObjectPlatform() *objects.Platform {
	if p == nil {
		return nil
	}
	pl := p.GetPlatform()
	return &objects.Platform{
		Id:          pl.GetId(),
		Name:        pl.GetName(),
		Code:        pl.GetCode(),
		DisplayName: pl.GetDisplayName(),
	}
}
