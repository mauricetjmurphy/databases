package domain

import (
	"github.com/mauricetjmurphy/ms-common/types/settings/status"
)

const (
	ScheduleStatusTable = "ScheduleStatus"

	ProvisionalStatus     = "Provisional"
	PendingApprovalStatus = "Pending approval"
	UpdatedStatus         = "Updated"
	ApprovedStatus        = "Approved"
	DeletedStatus         = "Deleted"
)

type ScheduleStatus struct {
	ID   uint   `gorm:"column:Id;"`
	Name string `gorm:"column:Name;"`
}

func (ScheduleStatus) TableName() string { return ScheduleStatusTable }

// GetScheduleStatusID get the schedule status identifier from status value.
// If absents. Return Provisional status
func GetScheduleStatusID(scheduleStatus string) uint {
	if st, ok := scheduleStatusMapByStr[scheduleStatus]; ok {
		return st
	}
	return scheduleStatusMapByStr[ProvisionalStatus]
}

// GetScheduleStatusIDs get the schedule status identifier from status value.
// If absents. Return Provisional status
func GetScheduleStatusIDs(scheduleStatus ...string) []uint {
	scheduleStatusIds := make([]uint, len(scheduleStatus))
	for i, status := range scheduleStatus {
		if v, ok := scheduleStatusMapByStr[status]; ok {
			scheduleStatusIds[i] = v
		}
	}
	return scheduleStatusIds
}

func GetScheduleStatusName(id uint) string {
	if v, ok := scheduleStatusMapByID[id]; ok {
		return v
	}
	return ""
}

func IsScheduleDeletedStatus(scheduleStatusID uint) bool {
	if v, ok := scheduleStatusMapByID[scheduleStatusID]; ok {
		return ok && v == DeletedStatus
	}
	return false
}

var scheduleStatusMapByStr = map[string]uint{
	ProvisionalStatus:     1,
	PendingApprovalStatus: 2,
	UpdatedStatus:         3,
	ApprovedStatus:        4,
	DeletedStatus:         5,
}

var scheduleStatusMapByID = map[uint]string{
	1: ProvisionalStatus,
	2: PendingApprovalStatus,
	3: UpdatedStatus,
	4: ApprovedStatus,
	5: DeletedStatus,
}

func GetScheduleStatus(scheduleStatusID uint) *status.ScheduleStatus {
	return &status.ScheduleStatus{
		Id:   int64(scheduleStatusID),
		Name: GetScheduleStatusName(scheduleStatusID),
	}
}

func GetProvisionalStatusID() uint {
	return GetScheduleStatusID(ProvisionalStatus)
}

func GetPendingApprovalStatusID() uint {
	return GetScheduleStatusID(PendingApprovalStatus)
}

func GetUpdatedStatusID() uint {
	return GetScheduleStatusID(UpdatedStatus)
}

func GetApprovedStatusID() uint {
	return GetScheduleStatusID(ApprovedStatus)
}

func GetDeletedStatusID() uint {
	return GetScheduleStatusID(DeletedStatus)
}
