package domain

const (
	EventTypeTable = "EventType"

	PlatformActiveDatesEvent = "PlatformActiveEvent"
	TitleRightsUpdateEvent   = "TitleRightsUpdateEvent"
	LinearUpdateEvent        = "LinearEventUpdate"
)

type EventType struct {
	ID   uint   `gorm:"column:Id;"`
	Name string `gorm:"column:Name;"`
}

func (EventType) TableName() string { return EventTypeTable }

// GetEventTypeID get the event type identifier.
// If absents. Return PlatformActiveEvent
func GetEventTypeID(eventType string) uint {
	if st, ok := eventTypeMapByStr[eventType]; ok {
		return st
	}
	return eventTypeMapByStr[PlatformActiveDatesEvent]
}

var eventTypeMapByStr = map[string]uint{
	PlatformActiveDatesEvent: 1,
	TitleRightsUpdateEvent:   2,
	LinearUpdateEvent:        3,
}

var eventTypeMapByID = map[uint]string{
	1: PlatformActiveDatesEvent,
	2: TitleRightsUpdateEvent,
	3: LinearUpdateEvent,
}

func GetEventTypeName(id uint) string {
	if v, ok := eventTypeMapByID[id]; ok {
		return v
	}
	return ""
}

func GetPlatformActiveEventID() uint {
	return GetEventTypeID(PlatformActiveDatesEvent)
}

func GetTitleRightsUpdateEventID() uint {
	return GetEventTypeID(TitleRightsUpdateEvent)
}

func GetLinearUpdateEventID() uint {
	return GetEventTypeID(LinearUpdateEvent)
}
