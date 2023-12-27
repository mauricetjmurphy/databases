package domain

import (
	"testing"

	"github.com/NBCUniversal/gvs-ms-common/db/entity"
)

func Test_UpdateRightsChannels_OK(t *testing.T) {
	//Given
	var (
		r = &Rights{
			RightsChannels: RightsChannels{
				{
					RightsID:  1,
					ChannelID: 1,
					Channel: &Channel{
						Base: entity.NewBase(1),
						Name: "Telemundo Mexico",
					},
				},
				{
					RightsID:  1,
					ChannelID: 3,
					Channel: &Channel{
						Base: entity.NewBase(3),
						Name: "Telemundo Venezuela",
					},
				},
			},
		}
		param = RightsChannels{
			{
				Channel: &Channel{
					Base: entity.NewBase(2),
					Name: "Telemundo LatAm",
				},
			},
			{
				Channel: &Channel{
					Base: entity.NewBase(3),
					Name: "Telemundo Venezuela",
				},
			},
			{
				Channel: &Channel{
					Base: entity.NewBase(4),
					Name: "Telemundo Central America",
				},
			},
		}
		expected = RightsChannels{
			{
				RightsID:  1,
				ChannelID: 2,
				Channel: &Channel{
					Base: entity.NewBase(2),
					Name: "Telemundo LatAm",
				},
			},
			{
				RightsID:  1,
				ChannelID: 3,
				Channel: &Channel{
					Base: entity.NewBase(3),
					Name: "Telemundo Venezuela",
				},
			},
			{
				RightsID:  1,
				ChannelID: 4,
				Channel: &Channel{
					Base: entity.NewBase(4),
					Name: "Telemundo Central America",
				},
			},
		}
	)

	//When
	r.UpdateRightsChannels(param)

	//Then
	if len(r.RightsChannels) != len(expected) {
		handleTestErr(t, len(r.RightsChannels))
	}
	if len(r.RightsChannelsDeletes) != 1 {
		handleTestErr(t, len(r.RightsChannelsDeletes))
	}

}

func Test_AddRightsChannels_OK(t *testing.T) {
	//Given
	var (
		r = &Rights{
			RightsChannels: RightsChannels{},
		}
		param = RightsChannels{
			{
				Channel: &Channel{
					Base: entity.NewBase(2),
					Name: "Telemundo LatAm",
				},
			},
		}
		expected = RightsChannels{
			{
				Channel: &Channel{
					Base: entity.NewBase(2),
					Name: "Telemundo LatAm",
				},
			},
		}
	)

	//When
	r.UpdateRightsChannels(param)

	//Then
	if len(r.RightsChannels) != len(expected) {
		handleTestErr(t, len(r.RightsChannels))
	}
}

func handleTestErr(t *testing.T, value interface{}) {
	t.Errorf("actual is different from expected with actual: %v", value)
}
