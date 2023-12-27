package domain

import (
	"github.com/mauricetjmurphy/ms-common/types/settings/objects"
)

const (
	ProgrammeGenreTable = "ProgrammeGenre"
)

type ProgrammeGenre struct {
	ProgrammeID uint       `gorm:"column:ProgrammeId;primaryKey;"`
	Programme   *Programme `gorm:"foreignKey:ProgrammeId;references:Id"`
	GenreID     uint       `gorm:"column:GenreId;primaryKey;"`
	Genre       *Genre     `gorm:"foreignKey:GenreId;references:Id"`
}

func NewProgrammeGenre(genres []*objects.Genre) (pg []*ProgrammeGenre) {
	for _, c := range genres {
		pg = append(pg, &ProgrammeGenre{
			Genre: NewGenre(c),
		})
	}
	return
}

func (pg *ProgrammeGenre) Update(programmeGenre *ProgrammeGenre) {
	if pg == nil || programmeGenre == nil {
		return
	}
	if programmeGenre.Genre != nil {
		pg.Genre.Update(programmeGenre.Genre)
	}
}

func (ProgrammeGenre) TableName() string { return ProgrammeGenreTable }
