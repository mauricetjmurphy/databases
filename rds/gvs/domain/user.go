package domain

import (
	"github.com/mauricetjmurphy/ms-common/db/entity"
)

const (
	UserTable = "User"
)

type User struct {
	*entity.Base
	SsoID string `gorm:"column:SsoId;unique"`
}

func (User) TableName() string { return UserTable }

func NewUser(ID int64, SsoID string) *User {
	return &User{
		Base:  entity.NewBaseInt64(ID),
		SsoID: SsoID,
	}
}
