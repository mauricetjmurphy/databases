package domain

import (
	"github.com/mauricetjmurphy/ms-common/libs/ptr"
	"github.com/mauricetjmurphy/ms-common/types/settings/objects"
)

const (
	TXTypeTable = "TransmissionType"

	LinearTX    = "Linear TX"
	NonLinearTX = "Non-Linear TX"
)

var txTypeMapByStr = map[string]uint{
	LinearTX:    1,
	NonLinearTX: 2,
}

var txTypeMapByID = map[uint]string{
	1: LinearTX,
	2: NonLinearTX,
}

type TXType struct {
	ID   uint   `gorm:"column:Id;"`
	Name string `gorm:"column:Name;primaryKey;"`
}

func (TXType) TableName() string { return TXTypeTable }

func GetTXTypeID(txType string) *uint {
	if tt, ok := txTypeMapByStr[txType]; ok {
		return ptr.Uint(tt)
	}
	return nil
}

func IsLinearTx(id *uint) bool {
	return id != nil && GetTXTypeName(id) == LinearTX
}

func GetLinerTXTypeID() uint {
	return txTypeMapByStr[LinearTX]
}

func GetTXTypeName(id *uint) string {
	if id == nil {
		return ""
	}
	if v, ok := txTypeMapByID[*id]; ok {
		return v
	}
	return ""
}

func GetTransmissionType(transmissionTypeID uint) *objects.TransmissionType {
	return &objects.TransmissionType{
		Id:   int64(transmissionTypeID),
		Name: GetTXTypeName(ptr.Uint(transmissionTypeID)),
	}
}
