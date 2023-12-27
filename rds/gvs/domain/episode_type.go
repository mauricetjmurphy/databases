package domain

const (
    EpisodeTypeTable = "EpisodeType"

    LicensedType   = "Licensed"
    UnlicensedType = "Unlicensed"
)

type EpisodeType struct {
    ID   uint   `gorm:"column:Id;"`
    Name string `gorm:"column:Name;"`
}

func (EpisodeType) TableName() string { return EpisodeTypeTable }

// GetEpisodeTypeID get the episode type identifier from type in episode value.
// If absents. Return Unlicensed episode type
func GetEpisodeTypeID(episodeType string) uint {
    if st, ok := episodeTypeMapByStr[episodeType]; ok {
        return st
    }
    return episodeTypeMapByStr[UnlicensedType]
}

func GetEpisodeTypeName(id uint) string {
    if v, ok := episodeTypeMapByID[id]; ok {
        return v
    }
    return ""
}

func (et *EpisodeType) Update(episodeType *EpisodeType) {
    if et == nil || episodeType == nil {
        return
    }
    if episodeType.Name != "" {
        et.Name = episodeType.Name
    }
}

var episodeTypeMapByStr = map[string]uint{
    LicensedType:     1,
    UnlicensedType: 2,
}

var episodeTypeMapByID = map[uint]string{
    1: LicensedType,
    2: UnlicensedType,
}

func GetLicensedTypeID() uint {
    return GetEpisodeTypeID(LicensedType)
}

func GetUnlicensedTypeID() uint {
    return GetEpisodeTypeID(UnlicensedType)
}
