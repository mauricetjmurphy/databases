package domain

import (
	"github.com/NBCUniversal/gvs-ms-common/db/entity"
	"github.com/NBCUniversal/gvs-ms-common/types/settings/objects"
)

const (
	GenreTable = "Genre"
)

type Genre struct {
	*entity.Base
	Name string `gorm:"column:Name;"`
	Code string `gorm:"column:Code;"`
}

func (Genre) TableName() string { return GenreTable }

func NewGenre(genre *objects.Genre) *Genre {
	if genre == nil {
		return nil
	}
	return &Genre{
		Base: entity.NewBaseInt64(genre.Id),
		Name: genre.Name,
		Code: genre.Code,
	}
}

func (g *Genre) Update(genre *Genre) {
	if g == nil || genre == nil {
		return
	}
	if entity.BaseNotNil(genre.Base) {
		g.Base = genre.Base
	}
	if genre.Name != "" {
		g.Name = genre.Name
	}
	if genre.Code != "" {
		g.Code = genre.Code
	}
}

func (g *Genre) GetGenre() *objects.Genre {
	if g == nil {
		return nil
	}
	return &objects.Genre{
		Id:   int64(g.ID),
		Name: g.Name,
		Code: g.Code,
	}
}
