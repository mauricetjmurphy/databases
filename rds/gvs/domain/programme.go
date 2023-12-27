package domain

import (
	"github.com/mauricetjmurphy/ms-common/db/entity"
	"github.com/mauricetjmurphy/ms-common/libs/ptr"
	"github.com/mauricetjmurphy/ms-common/types/settings/objects"
	"github.com/mauricetjmurphy/ms-common/types/settings/programme"
	"github.com/mauricetjmurphy/ms-common/types/utils"
)

const (
	ProgrammeTable = "Programme"
)

type Programme struct {
	*entity.Base
	Title            string            `gorm:"column:Title;"`
	NumberOfEpisodes int64             `gorm:"column:NumberOfEpisodes;"`
	SlotDuration     int64             `gorm:"column:SlotDuration;"`
	SeasonNumber     int64             `gorm:"column:SeasonNumber;"`
	NumberOfSeasons  int64             `gorm:"column:NumberOfSeasons;"`
	Year             int64             `gorm:"column:Year;"`
	ProgrammeTypeID  uint              `gorm:"column:ProgrammeTypeId;"`
	ProgrammeType    *ProgrammeType    `gorm:"foreignKey:ProgrammeTypeId;references:Id;"`
	Genres           []*ProgrammeGenre `gorm:"foreignKey:ProgrammeId;references:Id;<-:create"`
	Episodes         []*Episode        `gorm:"foreignKey:ProgrammeId;references:Id;<-:create"`
	SeriesID         *int64            `gorm:"column:SeriesId;"`
	SeriesTitle      string            `gorm:"column:SeriesTitle;"`
}

func (Programme) TableName() string { return ProgrammeTable }

func NewProgramme(programme *programme.Programme) *Programme {
	if programme == nil {
		return nil
	}
	var (
		episodes    []*Episode
		seriesID    *int64
		seriesTitle string
	)
	for _, v := range programme.Episodes {
		episodes = append(episodes, NewEpisode(v, programme.Id))
	}
	if programme.GetSeries() != nil {
		seriesID = ptr.Int64(programme.GetSeries().GetId())
		seriesTitle = programme.GetSeries().GetTitle()
	}
	return &Programme{
		Base:             entity.NewBaseInt64(programme.GetId()),
		Title:            programme.GetTitle(),
		NumberOfEpisodes: programme.GetNumberOfEpisodes(),
		SlotDuration:     programme.GetSlotDuration(),
		SeasonNumber:     programme.GetSeasonNumber(),
		NumberOfSeasons:  programme.GetNumberOfSeasons(),
		Year:             programme.GetYear(),
		ProgrammeType:    NewProgrammeType(programme.GetProgrammeType()),
		Genres:           NewProgrammeGenre(programme.GetGenres()),
		Episodes:         episodes,
		SeriesID:         seriesID,
		SeriesTitle:      seriesTitle,
	}
}

func (p *Programme) Update(param *Programme) {
	if p == nil || param == nil {
		return
	}
	if param.ProgrammeType != nil {
		p.ProgrammeType.Update(param.ProgrammeType)
	}
	if param.Title != "" {
		p.Title = param.Title
	}
	if len(param.Episodes) > 0 {
		for _, ep := range p.Episodes {
			for _, epParam := range param.Episodes {
				if ep.ID == epParam.ID {
					ep.Update(epParam)
					break
				}
			}
		}
	}
	if param.NumberOfSeasons > 0 {
		p.NumberOfSeasons = param.NumberOfSeasons
	}
	if param.SlotDuration > 0 {
		p.SlotDuration = param.SlotDuration
	}
	if param.SeasonNumber > 0 {
		p.SeasonNumber = param.SeasonNumber
	}
	if param.Year > 0 {
		p.Year = param.Year
	}
	if param.SeriesID != nil && *param.SeriesID > 0 {
		p.SeriesID = param.SeriesID
		p.SeriesTitle = param.SeriesTitle
	}
}

func (p *Programme) Same(that *Programme) bool {
	return p != nil && that != nil && p.ID == that.ID
}

func (p *Programme) GetMovieEpisode() *Episode {
	if p.IsMovieType() && len(p.Episodes) > 0 {
		return p.Episodes[0]
	}
	return nil
}

func (p *Programme) IsMovieType() bool {
	return p != nil && p.ProgrammeType != nil && utils.IsMovieType(p.ProgrammeType.Name)
}

func (p *Programme) GetProgramme() *programme.Programme {
	if p == nil {
		return nil
	}
	var (
		episodes []*programme.Episode
		genres   []*objects.Genre
		series   *programme.Series
	)

	for _, v := range p.Episodes {
		episodes = append(episodes, v.GetEpisode())
	}

	for _, g := range p.Genres {
		genres = append(genres, g.Genre.GetGenre())
	}

	if p.SeriesID != nil {
		series = &programme.Series{
			Id:    *p.SeriesID,
			Title: p.SeriesTitle,
		}
	}

	return &programme.Programme{
		Id:               int64(p.ID),
		Title:            p.Title,
		SlotDuration:     p.SlotDuration,
		Year:             p.Year,
		NumberOfEpisodes: p.NumberOfEpisodes,
		SeasonNumber:     p.SeasonNumber,
		NumberOfSeasons:  p.NumberOfSeasons,
		ProgrammeType:    p.ProgrammeType.GetProgrammeType(),
		Genres:           genres,
		Episodes:         episodes,
		Series:           series,
	}
}
