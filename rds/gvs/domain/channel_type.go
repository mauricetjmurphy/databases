package domain

import (
	e "github.com/NBCUniversal/gvs-ms-common/db/entity"
	"github.com/NBCUniversal/gvs-ms-common/types/settings/channel"
)

const (
	ChannelTypeTable = "ChannelType"
)

type ChannelType struct {
	*e.Base
	Name     string `gorm:"column:Name;"`
	IsLinear bool   `gorm:"column:IsLinear;"`
}

func (ChannelType) TableName() string { return ChannelTypeTable }

func NewChannelType(channelType *channel.ChannelType) *ChannelType {
	if channelType == nil {
		return nil
	}
	return &ChannelType{
		Base:     e.NewBaseInt64(channelType.GetId()),
		Name:     channelType.GetName(),
		IsLinear: channelType.GetIsLinear(),
	}
}

func (ct *ChannelType) Update(channelType *ChannelType) {
	if ct == nil || channelType == nil {
		return
	}
	if channelType.Name != "" {
		ct.Name = channelType.Name
	}
	ct.IsLinear = channelType.IsLinear
}

func (ct *ChannelType) GetChannelType() *channel.ChannelType {
	if ct == nil {
		return nil
	}
	return &channel.ChannelType{
		Id:       int64(ct.ID),
		Name:     ct.Name,
		IsLinear: ct.IsLinear,
	}
}
