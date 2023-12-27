package domain

import (
	"github.com/mauricetjmurphy/ms-common/db/entity"
	"github.com/mauricetjmurphy/ms-common/types/settings/objects"
	"github.com/mauricetjmurphy/ms-common/types/settings/programme"
)

const (
	EpisodeTable = "Episode"
)

type Episode struct {
	*entity.Base
	Title            string          `gorm:"column:Title;"`
	Number           int64           `gorm:"column:Number;"`
	YearOfProduction int64           `gorm:"column:YearOfProduction;"`
	ProgrammeID      uint            `gorm:"column:ProgrammeId;"`
	Genres           []*EpisodeGenre `gorm:"foreignKey:EpisodeId;references:Id;<-:create"`
	EpisodeTypeID    uint            `gorm:"column:EpisodeTypeId;"`
	EpisodeType      *EpisodeType    `gorm:"foreignKey:EpisodeTypeId;references:Id;"`
	SlotDuration     int64           `gorm:"column:SlotDuration;"`
}

func (Episode) TableName() string { return EpisodeTable }

func NewEpisode(episode *programme.Episode, programmeID int64) *Episode {
	if episode == nil {
		return nil
	}
	return &Episode{
		Base:             entity.NewBaseInt64(episode.GetId()),
		Title:            episode.GetTitle(),
		Number:           episode.GetNumber(),
		YearOfProduction: episode.GetYearOfProduction(),
		ProgrammeID:      uint(programmeID),
		Genres:           NewEpisodeGenre(episode.GetGenres()),
		EpisodeTypeID:    GetEpisodeTypeID(episode.GetType()),
		SlotDuration:     episode.GetSlotDuration(),
	}
}

func (e *Episode) Update(episode *Episode) {
	if e == nil || episode == nil {
		return
	}
	if episode.Title != "" {
		e.Title = episode.Title
	}
	if episode.Number > 0 {
		e.Number = episode.Number
	}
	if episode.YearOfProduction > 0 {
		e.YearOfProduction = episode.YearOfProduction
	}
	if episode.ProgrammeID > 0 {
		e.ProgrammeID = episode.ProgrammeID
	}
	if episode.EpisodeType != nil {
		e.EpisodeType.Update(episode.EpisodeType)
	}
	if episode.SlotDuration > 0 {
		e.SlotDuration = episode.SlotDuration
	}
}

func (e *Episode) GetEpisode() *programme.Episode {
	if e == nil {
		return nil
	}
	var genres []*objects.Genre
	for _, g := range e.Genres {
		genres = append(genres, g.Genre.GetGenre())
	}
	return &programme.Episode{
		Id:               int64(e.ID),
		Title:            e.Title,
		Number:           e.Number,
		YearOfProduction: e.YearOfProduction,
		Genres:           genres,
		Type:             GetEpisodeTypeName(e.EpisodeTypeID),
		SlotDuration:     e.SlotDuration,
	}
}
