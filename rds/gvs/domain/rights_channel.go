package domain

import (
	"github.com/mauricetjmurphy/ms-common/types/settings/channel"
)

const (
	RightsChannelTable = "RightsChannel"
)

type RightsChannels []*RightsChannel

type RightsChannel struct {
	RightsID  uint     `gorm:"column:RightsId;primaryKey"`
	Rights    *Rights  `gorm:"foreignKey:RightsId;references:Id"`
	ChannelID uint     `gorm:"column:ChannelId;primaryKey"`
	Channel   *Channel `gorm:"foreignKey:ChannelId;references:Id"`
}

func (RightsChannel) TableName() string { return RightsChannelTable }

func NewRightsChannel(channels []*channel.Channel) (rc []*RightsChannel) {
	for _, c := range channels {
		rc = append(rc, &RightsChannel{
			Channel: NewChannel(c),
		})
	}
	return
}

func (rc *RightsChannel) Update(rightsChannel *RightsChannel) {
	if rc == nil || rightsChannel == nil {
		return
	}
	if rightsChannel.Channel != nil {
		rc.Channel.Update(rightsChannel.Channel)
	}
}

func (slice RightsChannels) Match(rightsChannel *RightsChannel) *RightsChannel {
	for _, rc := range slice {
		if rc.Channel.ID == rightsChannel.Channel.ID {
			return rc
		}
	}
	return nil
}
