package domain

import (
	"fmt"
	"strconv"
	"strings"

	e "github.com/NBCUniversal/gvs-ms-common/db/entity"
	rpb "github.com/NBCUniversal/gvs-ms-common/types/settings/rights"
)

const (
	RightsTypeTable          = "RightsType"
	FromStartTimeLinearEvent = "From Start Time of Linear Event"
	FromEndTimeLinearEvent   = "From End Time of Linear Event"
	RightsTypeSVOD           = "SVOD"
	RightsTypeStacking       = "Stacking"
	RightsTypeCatchUp        = "Catch Up"
)

type OffsetDay struct {
	Hours   int64
	Minutes int64
}

type RightsType struct {
	*e.Base
	RightsID     uint    `gorm:"column:RightsId;"`
	Rights       *Rights `gorm:"foreignKey:RightsId;references:Id;"`
	Type         string  `gorm:"column:Type;"`
	OnDemandRule string  `gorm:"column:OnDemandRule;"`
	OffsetFrom   string  `gorm:"column:OffsetFrom;"`
	OffsetFor    string  `gorm:"column:OffsetFor;"`
	Availability string  `gorm:"column:Availability;"`
}

func (RightsType) TableName() string { return RightsTypeTable }

func NewRightsType(rights *rpb.Rights, programmeID uint) *RightsType {
	return &RightsType{
		RightsID:     uint(rights.GetId()),
		Rights:       NewRights(rights, programmeID),
		Type:         rights.GetType(),
		OnDemandRule: rights.GetOnDemandRule(),
		OffsetFrom:   rights.GetOffsetFrom(),
		OffsetFor:    rights.GetOffsetFor(),
		Availability: rights.GetAvailability(),
	}
}

func (rt *RightsType) GetRights() *rpb.Rights {
	if rt == nil {
		return nil
	}
	r := rt.Rights.GetRights()
	r.Type = rt.Type
	r.Availability = rt.Availability
	r.OffsetFrom = rt.OffsetFrom
	r.OffsetFor = rt.OffsetFor
	r.OnDemandRule = rt.OnDemandRule
	return r
}

func (rt *RightsType) Update(param *RightsType) {
	if param == nil {
		return
	}
	if param.Rights != nil {
		rt.Rights.Update(param.Rights)
	}
	if param.OffsetFrom != "" {
		rt.OffsetFrom = param.OffsetFrom
	}
	if param.OffsetFor != "" {
		rt.OffsetFor = param.OffsetFor
	}
	if param.Availability != "" {
		rt.Availability = param.Availability
	}
	if param.OnDemandRule != "" {
		rt.OnDemandRule = param.OnDemandRule
	}
}

func (rt *RightsType) SplitOffsetDays() (*OffsetDay, error) {
	if strings.EqualFold(rt.Availability, FromStartTimeLinearEvent) {
		return buildOffsetDays(rt.OffsetFrom)
	}
	if strings.EqualFold(rt.Availability, FromEndTimeLinearEvent) {
		return buildOffsetDays(rt.OffsetFor)
	}
	return nil, nil
}

func buildOffsetDays(offsetDate string) (*OffsetDay, error) {
	addrErr := func(err error) (*OffsetDay, error) {
		return &OffsetDay{0, 0}, err
	}

	if len(offsetDate) == 0 {
		return addrErr(nil)
	}

	offsetDaysTime := strings.Split(offsetDate, ",")
	if len(offsetDaysTime) != 2 {
		return addrErr(fmt.Errorf(fmt.Sprintf("domain : invalid offset value %v ", offsetDate)))
	}

	hourAndMins := strings.Split(strings.TrimSpace(offsetDaysTime[1]), ":")
	if len(hourAndMins) != 2 {
		return addrErr(fmt.Errorf(fmt.Sprintf("domain : invalid offset time value %v ", offsetDaysTime[1])))
	}

	daysInt, err := strconv.Atoi(strings.TrimSpace(offsetDaysTime[0]))
	if err != nil {
		return addrErr(err)
	}

	hoursInt, err := strconv.Atoi(strings.TrimSpace(hourAndMins[0]))
	if err != nil {
		return addrErr(err)
	}

	minInt, err := strconv.Atoi(strings.TrimSpace(hourAndMins[1]))
	if err != nil {
		return addrErr(err)
	}

	totalHours := daysInt * 24
	totalHours += hoursInt
	return &OffsetDay{Hours: int64(totalHours), Minutes: int64(minInt)}, nil
}
