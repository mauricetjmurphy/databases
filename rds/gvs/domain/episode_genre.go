package domain

import (
	"github.com/NBCUniversal/gvs-ms-common/types/settings/objects"
)

const (
	EpisodeGenreTable = "EpisodeGenre"
)

type EpisodeGenre struct {
	EpisodeID uint     `gorm:"column:EpisodeId;primaryKey;"`
	Episode   *Episode `gorm:"foreignKey:EpisodeId;references:Id"`
	GenreID   uint     `gorm:"column:GenreId;primaryKey;"`
	Genre     *Genre   `gorm:"foreignKey:GenreId;references:Id"`
}

func NewEpisodeGenre(genres []*objects.Genre) (eg []*EpisodeGenre) {
	for _, c := range genres {
		eg = append(eg, &EpisodeGenre{
			Genre: NewGenre(c),
		})
	}
	return
}

func (eg *EpisodeGenre) Update(episodeGenre *EpisodeGenre) {
	if eg == nil || episodeGenre == nil {
		return
	}
	if episodeGenre.Genre != nil {
		eg.Genre.Update(episodeGenre.Genre)
	}
}

func (EpisodeGenre) TableName() string { return EpisodeGenreTable }
