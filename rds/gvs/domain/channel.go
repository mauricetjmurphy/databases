package domain

import (
	"github.com/NBCUniversal/gvs-ms-common/db/entity"
	"github.com/NBCUniversal/gvs-ms-common/types/settings/channel"
)

const (
	ChannelTable = "Channel"
)

type Channel struct {
	*entity.Base
	Name          string       `gorm:"column:Name;"`
	Code          string       `gorm:"column:Code;"`
	DisplayName   string       `gorm:"column:DisplayName;"`
	ChannelTypeID *uint        `gorm:"column:ChannelTypeId;"`
	ChannelType   *ChannelType `gorm:"foreignKey:ChannelTypeId;references:Id;"`
}

func (Channel) TableName() string { return ChannelTable }

// NewChannel makes the Channel entity from given channel proto.
func NewChannel(channel *channel.Channel) *Channel {
	if channel == nil {
		return nil
	}
	return &Channel{
		Base:        entity.NewBaseInt64(channel.GetId()),
		Name:        channel.GetName(),
		Code:        channel.GetCode(),
		DisplayName: channel.GetDisplayName(),
		ChannelType: NewChannelType(channel.GetType()),
	}
}

func (c *Channel) Update(channel *Channel) {
	if c == nil || channel == nil {
		return
	}
	if channel.Name != "" {
		c.Name = channel.Name
	}
	if channel.Code != "" {
		c.Code = channel.Code
	}
	if channel.DisplayName != "" {
		c.DisplayName = channel.DisplayName
	}
	if channel.ChannelTypeID != nil {
		c.ChannelTypeID = channel.ChannelTypeID
	}
	if channel.ChannelType != nil {
		c.ChannelType.Update(channel.ChannelType)
	}
}

func (c *Channel) GetChannel() *channel.Channel {
	if c == nil {
		return nil
	}
	return &channel.Channel{
		Id:          int64(c.ID),
		Name:        c.Name,
		Code:        c.Code,
		DisplayName: c.DisplayName,
		Type:        c.ChannelType.GetChannelType(),
	}
}
