package domain

import (
	"github.com/NBCUniversal/gvs-ms-common/db/entity"
	"github.com/NBCUniversal/gvs-ms-common/types/settings/programme"
)

const (
	ProgrammeTypeTable = "ProgrammeType"
)

type ProgrammeType struct {
	*entity.Base
	Name            string `gorm:"column:Name;"`
	Code            string `gorm:"column:Code;"`
	IsSingleProgram bool   `gorm:"column:IsSingleProgram;"`
}

func (ProgrammeType) TableName() string { return ProgrammeTypeTable }

func NewProgrammeType(programmeType *programme.ProgrammeType) *ProgrammeType {
	if programmeType == nil {
		return nil
	}
	return &ProgrammeType{
		Base:            entity.NewBaseInt64(programmeType.Id),
		Name:            programmeType.GetName(),
		Code:            programmeType.GetCode(),
		IsSingleProgram: programmeType.GetIsSingleProgram(),
	}
}

func (pt *ProgrammeType) Update(programmeType *ProgrammeType) {
	if pt == nil || programmeType == nil {
		return
	}
	if entity.BaseNotNil(programmeType.Base) {
		pt.Base = programmeType.Base
	}
	if programmeType.Name != "" {
		pt.Name = programmeType.Name
	}
	if programmeType.Code != "" {
		pt.Code = programmeType.Code
	}
}

func (pt *ProgrammeType) GetProgrammeType() *programme.ProgrammeType {
	if pt == nil {
		return nil
	}
	return &programme.ProgrammeType{
		Id:              int64(pt.ID),
		Name:            pt.Name,
		Code:            pt.Code,
		IsSingleProgram: pt.IsSingleProgram,
	}
}
