package domain

import (
	e "github.com/mauricetjmurphy/ms-common/db/entity"
	"github.com/mauricetjmurphy/ms-common/types/settings/timezone"
)

const (
	TimezoneTable = "Timezone"
)

type Timezone struct {
	*e.Base
	Name         string `gorm:"column:Name;"`
	Time         string `gorm:"column:Time;"`
	IanaTimezone string `gorm:"column:IanaTimezone;"`
}

func (Timezone) TableName() string { return TimezoneTable }

// NewTimezone makes the Timezone entity from given timezone proto.
func NewTimezone(timezone *timezone.Timezone) *Timezone {
	if timezone == nil {
		return nil
	}
	return &Timezone{
		Base:         e.NewBaseInt64(timezone.GetId()),
		Name:         timezone.GetName(),
		Time:         timezone.GetTime(),
		IanaTimezone: timezone.GetIanaTimezone(),
	}
}

func (t *Timezone) Update(timezone *Timezone) {
	if t == nil || timezone == nil {
		return
	}
	if timezone.Name != "" {
		t.Name = timezone.Name
	}
	if timezone.Time != "" {
		t.Time = timezone.Time
	}
	if timezone.IanaTimezone != "" {
		t.IanaTimezone = timezone.IanaTimezone
	}
}

func (t *Timezone) GetTimezone() *timezone.Timezone {
	if t == nil {
		return nil
	}
	return &timezone.Timezone{
		Id:           int64(t.ID),
		Name:         t.Name,
		Time:         t.Time,
		IanaTimezone: t.IanaTimezone,
	}
}
