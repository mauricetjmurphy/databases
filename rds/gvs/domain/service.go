package domain

import (
	e "github.com/NBCUniversal/gvs-ms-common/db/entity"
	"github.com/NBCUniversal/gvs-ms-common/types/settings/objects"
)

const (
	ServiceTable = "Service"
)

type Service struct {
	*e.Base
	Name string `gorm:"column:Name;"`
}

func (Service) TableName() string { return ServiceTable }

// NewService makes the Service entity from given service proto.
func NewService(service *objects.Service) *Service {
	if service == nil {
		return nil
	}
	return &Service{
		Base: e.NewBaseInt64(service.GetId()),
		Name: service.GetName(),
	}
}

func (s *Service) GetID() uint {
	return s.ID
}

func (s *Service) GetService() *objects.Service {
	if s == nil {
		return nil
	}
	return &objects.Service{
		Id:   int64(s.ID),
		Name: s.Name,
	}
}

func (s *Service) Update(param *Service) {
	if s == nil || param == nil {
		return
	}
	if len(param.Name) > 0 {
		s.Name = param.Name
	}
}
