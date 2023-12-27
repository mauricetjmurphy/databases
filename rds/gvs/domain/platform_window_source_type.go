package domain

const (
	PlatformWindowSourceTypeTable = "PlatformWindowSourceType"
	ScheduleType                  = "Schedule"
	BundleType                    = "Bundle"
)

type PlatformWindowSourceType struct {
	ID   int64  `gorm:"column:Id"`
	Name string `gorm:"column:Name"`
}

func (PlatformWindowSourceType) TableName() string { return PlatformWindowSourceTypeTable }

//GetPlatformWindowSourceTypeID returns the platform window type id
func GetPlatformWindowSourceTypeID(name string) int64 {
	if pwt, ok := platformWindowSourceTypeMapByStr[name]; ok {
		return pwt
	}
	return platformWindowSourceTypeMapByStr[ScheduleType]
}

//GetPlatformWindowSourceTypeName returns the platform window type name
func GetPlatformWindowSourceTypeName(id int64) string {
	if v, ok := platformWindowSourceTypeByID[id]; ok {
		return v
	}
	return ""
}

var platformWindowSourceTypeMapByStr = map[string]int64{
	ScheduleType: 1,
	BundleType:   2,
}

var platformWindowSourceTypeByID = map[int64]string{
	1: ScheduleType,
	2: BundleType,
}
