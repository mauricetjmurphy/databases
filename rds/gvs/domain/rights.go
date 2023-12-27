package domain

import (
	"time"

	"github.com/NBCUniversal/gvs-ms-common/db/entity"
	"github.com/NBCUniversal/gvs-ms-common/libs/datetime"
	"github.com/NBCUniversal/gvs-ms-common/types/settings/channel"
	"github.com/NBCUniversal/gvs-ms-common/types/settings/rights"
	"github.com/NBCUniversal/gvs-ms-common/types/settings/territory"
)

const (
	RightsTable = "Rights"
)

type Rights struct {
	*entity.Base
	LandmarkRightsID  string             `gorm:"column:LandmarkRightsId;"`
	StartDate         time.Time          `gorm:"column:StartDate;"`
	EndDate           time.Time          `gorm:"column:EndDate;"`
	LicensedEpisodes  int64              `gorm:"column:LicensedEpisodes;"`
	NumberOfEpisodes  int64              `gorm:"column:NumberOfEpisodes;"`
	ProgrammeID       uint               `gorm:"column:ProgrammeId;"`
	ContractID        uint               `gorm:"column:ContractId;"`
	Contract          *Contract          `gorm:"foreignKey:ContractId;references:Id;"`
	RightsTerritories []*RightsTerritory `gorm:"foreignKey:RightsId;"`
	RightsChannels    RightsChannels     `gorm:"foreignKey:RightsId;"`

	RightsChannelsDeletes RightsChannels `gorm:"-"`
}

func (Rights) TableName() string { return RightsTable }

func NewRights(rights *rights.Rights, programmeID uint) *Rights {
	if rights == nil {
		return nil
	}
	start, _ := time.Parse(datetime.DateUTC, rights.GetStartDate())
	end, _ := time.Parse(datetime.DateUTC, rights.GetEndDate())
	return &Rights{
		Base:              entity.NewBaseInt64(rights.GetId()),
		StartDate:         start,
		EndDate:           end,
		LicensedEpisodes:  rights.GetLicensedEpisodes(),
		NumberOfEpisodes:  rights.GetNumberOfEpisodes(),
		Contract:          NewContract(rights.GetContract(), rights.GetTerritories()),
		LandmarkRightsID:  rights.GetContract().GetRightsId(),
		ProgrammeID:       programmeID,
		RightsTerritories: NewRightsTerritory(rights.GetTerritories()),
		RightsChannels:    NewRightsChannel(rights.GetChannels()),
	}
}

func (r *Rights) GetRights() *rights.Rights {
	if r == nil {
		return nil
	}

	var channels []*channel.Channel
	for _, rc := range r.RightsChannels {
		channels = append(channels, rc.Channel.GetChannel())
	}

	var contract *rights.Contract
	var territories []*territory.Territory

	if r.Contract != nil {
		contract = r.Contract.GetContract()
		contract.RightsId = r.GetLandmarkRightsID()
		territories = r.Contract.GetContractTerritoryCountry()
		if len(territories) == 0 {
			for _, tc := range r.RightsTerritories {
				territories = append(territories, tc.Territory.GetTerritory())
			}
		}
	}

	return &rights.Rights{
		Id:               int64(r.ID),
		StartDate:        r.StartDate.Format(datetime.DateUTC),
		EndDate:          r.EndDate.Format(datetime.DateUTC),
		LicensedEpisodes: r.LicensedEpisodes,
		NumberOfEpisodes: r.NumberOfEpisodes,
		Contract:         contract,
		ProgrammeId:      int64(r.ProgrammeID),
		Channels:         channels,
		Territories:      territories,
		LandmarkRightsID: r.LandmarkRightsID,
	}
}

func (r *Rights) Update(param *Rights) {
	if param == nil {
		return
	}
	r.UpdateRightsChannels(param.RightsChannels)
	r.RightsTerritories = param.RightsTerritories
	r.Contract.Update(param.Contract)
}

func (r *Rights) UpdateRightsChannels(param RightsChannels) {
	// Get all rights channels not exited in param
	for _, rc := range r.RightsChannels {
		if param.Match(rc) == nil {
			r.RightsChannelsDeletes = append(r.RightsChannelsDeletes, rc)
		}
	}

	// Repopulate actual rights channels
	if len(r.RightsChannelsDeletes) > 0 {
		for i := len(r.RightsChannels) - 1; i >= 0; i-- {
			if r.RightsChannelsDeletes.Match(r.RightsChannels[i]) != nil {
				r.RightsChannels = append(r.RightsChannels[:i], r.RightsChannels[i+1:]...)
			}
		}
	}

	// Add new or update rights channels
	for _, rcParam := range param {
		if rightsChannel := r.RightsChannels.Match(rcParam); rightsChannel == nil {
			r.RightsChannels = append(r.RightsChannels, rcParam)
		} else {
			rightsChannel.Update(rcParam)
		}
	}
}

func (r *Rights) GetLandmarkRightsID() string {
	return r.LandmarkRightsID
}
