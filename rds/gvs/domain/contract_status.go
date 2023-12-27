package domain

import (
	"github.com/mauricetjmurphy/ms-common/db/entity"
	"github.com/mauricetjmurphy/ms-common/types/settings/rights"
)

const (
	ContactStatusTable = "ContractStatus"
)

type ContractStatus struct {
	*entity.Base
	Name string
}

func (ContractStatus) TableName() string { return ContactStatusTable }

func NewContractStatus(status *rights.ContractStatus) *ContractStatus {
	if status == nil {
		return nil
	}
	return &ContractStatus{
		Base: entity.NewBaseInt64(status.GetId()),
		Name: status.GetName(),
	}
}

func (ct *ContractStatus) Update(contractStatus *ContractStatus) {
	if ct == nil || contractStatus == nil {
		return
	}
	if contractStatus.Name != "" {
		ct.Name = contractStatus.Name
	}
}

func (ct *ContractStatus) GetContractStatus() *rights.ContractStatus {
	if ct == nil {
		return nil
	}
	return &rights.ContractStatus{
		Id:   int64(ct.ID),
		Name: ct.Name,
	}
}
