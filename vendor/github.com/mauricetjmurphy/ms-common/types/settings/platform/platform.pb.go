// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.31.0
// 	protoc        (unknown)
// source: settings/platform/platform.proto

package platform

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type Platform struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Id            int64           `protobuf:"varint,1,opt,name=id,proto3" json:"id,omitempty"`
	Name          string          `protobuf:"bytes,2,opt,name=name,proto3" json:"name,omitempty"`
	Code          string          `protobuf:"bytes,3,opt,name=code,proto3" json:"code,omitempty"`
	DisplayName   string          `protobuf:"bytes,4,opt,name=displayName,proto3" json:"displayName,omitempty"`
	PlatformType  *PlatformType   `protobuf:"bytes,5,opt,name=platformType,proto3" json:"platformType,omitempty"`
	PlatformDates []*PlatformDate `protobuf:"bytes,6,rep,name=platformDates,proto3" json:"platformDates,omitempty"`
	Aggregator    *Platform       `protobuf:"bytes,7,opt,name=aggregator,proto3" json:"aggregator,omitempty"`
	ServiceTypes  []*ServiceType  `protobuf:"bytes,8,rep,name=serviceTypes,proto3" json:"serviceTypes,omitempty"`
}

func (x *Platform) Reset() {
	*x = Platform{}
	if protoimpl.UnsafeEnabled {
		mi := &file_settings_platform_platform_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Platform) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Platform) ProtoMessage() {}

func (x *Platform) ProtoReflect() protoreflect.Message {
	mi := &file_settings_platform_platform_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Platform.ProtoReflect.Descriptor instead.
func (*Platform) Descriptor() ([]byte, []int) {
	return file_settings_platform_platform_proto_rawDescGZIP(), []int{0}
}

func (x *Platform) GetId() int64 {
	if x != nil {
		return x.Id
	}
	return 0
}

func (x *Platform) GetName() string {
	if x != nil {
		return x.Name
	}
	return ""
}

func (x *Platform) GetCode() string {
	if x != nil {
		return x.Code
	}
	return ""
}

func (x *Platform) GetDisplayName() string {
	if x != nil {
		return x.DisplayName
	}
	return ""
}

func (x *Platform) GetPlatformType() *PlatformType {
	if x != nil {
		return x.PlatformType
	}
	return nil
}

func (x *Platform) GetPlatformDates() []*PlatformDate {
	if x != nil {
		return x.PlatformDates
	}
	return nil
}

func (x *Platform) GetAggregator() *Platform {
	if x != nil {
		return x.Aggregator
	}
	return nil
}

func (x *Platform) GetServiceTypes() []*ServiceType {
	if x != nil {
		return x.ServiceTypes
	}
	return nil
}

type ServiceType struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Id                     int64  `protobuf:"varint,1,opt,name=id,proto3" json:"id,omitempty"`
	Name                   string `protobuf:"bytes,2,opt,name=name,proto3" json:"name,omitempty"`
	DeliveryDueDateOffsets int64  `protobuf:"varint,3,opt,name=deliveryDueDateOffsets,proto3" json:"deliveryDueDateOffsets,omitempty"`
}

func (x *ServiceType) Reset() {
	*x = ServiceType{}
	if protoimpl.UnsafeEnabled {
		mi := &file_settings_platform_platform_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ServiceType) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ServiceType) ProtoMessage() {}

func (x *ServiceType) ProtoReflect() protoreflect.Message {
	mi := &file_settings_platform_platform_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ServiceType.ProtoReflect.Descriptor instead.
func (*ServiceType) Descriptor() ([]byte, []int) {
	return file_settings_platform_platform_proto_rawDescGZIP(), []int{1}
}

func (x *ServiceType) GetId() int64 {
	if x != nil {
		return x.Id
	}
	return 0
}

func (x *ServiceType) GetName() string {
	if x != nil {
		return x.Name
	}
	return ""
}

func (x *ServiceType) GetDeliveryDueDateOffsets() int64 {
	if x != nil {
		return x.DeliveryDueDateOffsets
	}
	return 0
}

type PlatformType struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Id   int64  `protobuf:"varint,1,opt,name=id,proto3" json:"id,omitempty"`
	Name string `protobuf:"bytes,2,opt,name=name,proto3" json:"name,omitempty"`
}

func (x *PlatformType) Reset() {
	*x = PlatformType{}
	if protoimpl.UnsafeEnabled {
		mi := &file_settings_platform_platform_proto_msgTypes[2]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *PlatformType) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*PlatformType) ProtoMessage() {}

func (x *PlatformType) ProtoReflect() protoreflect.Message {
	mi := &file_settings_platform_platform_proto_msgTypes[2]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use PlatformType.ProtoReflect.Descriptor instead.
func (*PlatformType) Descriptor() ([]byte, []int) {
	return file_settings_platform_platform_proto_rawDescGZIP(), []int{2}
}

func (x *PlatformType) GetId() int64 {
	if x != nil {
		return x.Id
	}
	return 0
}

func (x *PlatformType) GetName() string {
	if x != nil {
		return x.Name
	}
	return ""
}

type PlatformDate struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Id        int64  `protobuf:"varint,1,opt,name=id,proto3" json:"id,omitempty"`
	StartDate string `protobuf:"bytes,2,opt,name=startDate,proto3" json:"startDate,omitempty"`
	EndDate   string `protobuf:"bytes,3,opt,name=endDate,proto3" json:"endDate,omitempty"`
	IsActive  bool   `protobuf:"varint,4,opt,name=isActive,proto3" json:"isActive,omitempty"`
}

func (x *PlatformDate) Reset() {
	*x = PlatformDate{}
	if protoimpl.UnsafeEnabled {
		mi := &file_settings_platform_platform_proto_msgTypes[3]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *PlatformDate) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*PlatformDate) ProtoMessage() {}

func (x *PlatformDate) ProtoReflect() protoreflect.Message {
	mi := &file_settings_platform_platform_proto_msgTypes[3]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use PlatformDate.ProtoReflect.Descriptor instead.
func (*PlatformDate) Descriptor() ([]byte, []int) {
	return file_settings_platform_platform_proto_rawDescGZIP(), []int{3}
}

func (x *PlatformDate) GetId() int64 {
	if x != nil {
		return x.Id
	}
	return 0
}

func (x *PlatformDate) GetStartDate() string {
	if x != nil {
		return x.StartDate
	}
	return ""
}

func (x *PlatformDate) GetEndDate() string {
	if x != nil {
		return x.EndDate
	}
	return ""
}

func (x *PlatformDate) GetIsActive() bool {
	if x != nil {
		return x.IsActive
	}
	return false
}

var File_settings_platform_platform_proto protoreflect.FileDescriptor

var file_settings_platform_platform_proto_rawDesc = []byte{
	0x0a, 0x20, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2f, 0x70, 0x6c, 0x61, 0x74, 0x66,
	0x6f, 0x72, 0x6d, 0x2f, 0x70, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x2e, 0x70, 0x72, 0x6f,
	0x74, 0x6f, 0x12, 0x25, 0x63, 0x6f, 0x6d, 0x2e, 0x69, 0x6e, 0x62, 0x63, 0x75, 0x2e, 0x72, 0x70,
	0x63, 0x2e, 0x74, 0x79, 0x70, 0x65, 0x73, 0x2e, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73,
	0x2e, 0x70, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x22, 0xc1, 0x03, 0x0a, 0x08, 0x50, 0x6c,
	0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x12, 0x0e, 0x0a, 0x02, 0x69, 0x64, 0x18, 0x01, 0x20, 0x01,
	0x28, 0x03, 0x52, 0x02, 0x69, 0x64, 0x12, 0x12, 0x0a, 0x04, 0x6e, 0x61, 0x6d, 0x65, 0x18, 0x02,
	0x20, 0x01, 0x28, 0x09, 0x52, 0x04, 0x6e, 0x61, 0x6d, 0x65, 0x12, 0x12, 0x0a, 0x04, 0x63, 0x6f,
	0x64, 0x65, 0x18, 0x03, 0x20, 0x01, 0x28, 0x09, 0x52, 0x04, 0x63, 0x6f, 0x64, 0x65, 0x12, 0x20,
	0x0a, 0x0b, 0x64, 0x69, 0x73, 0x70, 0x6c, 0x61, 0x79, 0x4e, 0x61, 0x6d, 0x65, 0x18, 0x04, 0x20,
	0x01, 0x28, 0x09, 0x52, 0x0b, 0x64, 0x69, 0x73, 0x70, 0x6c, 0x61, 0x79, 0x4e, 0x61, 0x6d, 0x65,
	0x12, 0x57, 0x0a, 0x0c, 0x70, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x54, 0x79, 0x70, 0x65,
	0x18, 0x05, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x33, 0x2e, 0x63, 0x6f, 0x6d, 0x2e, 0x69, 0x6e, 0x62,
	0x63, 0x75, 0x2e, 0x72, 0x70, 0x63, 0x2e, 0x74, 0x79, 0x70, 0x65, 0x73, 0x2e, 0x73, 0x65, 0x74,
	0x74, 0x69, 0x6e, 0x67, 0x73, 0x2e, 0x70, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x2e, 0x50,
	0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x54, 0x79, 0x70, 0x65, 0x52, 0x0c, 0x70, 0x6c, 0x61,
	0x74, 0x66, 0x6f, 0x72, 0x6d, 0x54, 0x79, 0x70, 0x65, 0x12, 0x59, 0x0a, 0x0d, 0x70, 0x6c, 0x61,
	0x74, 0x66, 0x6f, 0x72, 0x6d, 0x44, 0x61, 0x74, 0x65, 0x73, 0x18, 0x06, 0x20, 0x03, 0x28, 0x0b,
	0x32, 0x33, 0x2e, 0x63, 0x6f, 0x6d, 0x2e, 0x69, 0x6e, 0x62, 0x63, 0x75, 0x2e, 0x72, 0x70, 0x63,
	0x2e, 0x74, 0x79, 0x70, 0x65, 0x73, 0x2e, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2e,
	0x70, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x2e, 0x50, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72,
	0x6d, 0x44, 0x61, 0x74, 0x65, 0x52, 0x0d, 0x70, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x44,
	0x61, 0x74, 0x65, 0x73, 0x12, 0x4f, 0x0a, 0x0a, 0x61, 0x67, 0x67, 0x72, 0x65, 0x67, 0x61, 0x74,
	0x6f, 0x72, 0x18, 0x07, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x2f, 0x2e, 0x63, 0x6f, 0x6d, 0x2e, 0x69,
	0x6e, 0x62, 0x63, 0x75, 0x2e, 0x72, 0x70, 0x63, 0x2e, 0x74, 0x79, 0x70, 0x65, 0x73, 0x2e, 0x73,
	0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2e, 0x70, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d,
	0x2e, 0x50, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x52, 0x0a, 0x61, 0x67, 0x67, 0x72, 0x65,
	0x67, 0x61, 0x74, 0x6f, 0x72, 0x12, 0x56, 0x0a, 0x0c, 0x73, 0x65, 0x72, 0x76, 0x69, 0x63, 0x65,
	0x54, 0x79, 0x70, 0x65, 0x73, 0x18, 0x08, 0x20, 0x03, 0x28, 0x0b, 0x32, 0x32, 0x2e, 0x63, 0x6f,
	0x6d, 0x2e, 0x69, 0x6e, 0x62, 0x63, 0x75, 0x2e, 0x72, 0x70, 0x63, 0x2e, 0x74, 0x79, 0x70, 0x65,
	0x73, 0x2e, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2e, 0x70, 0x6c, 0x61, 0x74, 0x66,
	0x6f, 0x72, 0x6d, 0x2e, 0x53, 0x65, 0x72, 0x76, 0x69, 0x63, 0x65, 0x54, 0x79, 0x70, 0x65, 0x52,
	0x0c, 0x73, 0x65, 0x72, 0x76, 0x69, 0x63, 0x65, 0x54, 0x79, 0x70, 0x65, 0x73, 0x22, 0x69, 0x0a,
	0x0b, 0x53, 0x65, 0x72, 0x76, 0x69, 0x63, 0x65, 0x54, 0x79, 0x70, 0x65, 0x12, 0x0e, 0x0a, 0x02,
	0x69, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x03, 0x52, 0x02, 0x69, 0x64, 0x12, 0x12, 0x0a, 0x04,
	0x6e, 0x61, 0x6d, 0x65, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x04, 0x6e, 0x61, 0x6d, 0x65,
	0x12, 0x36, 0x0a, 0x16, 0x64, 0x65, 0x6c, 0x69, 0x76, 0x65, 0x72, 0x79, 0x44, 0x75, 0x65, 0x44,
	0x61, 0x74, 0x65, 0x4f, 0x66, 0x66, 0x73, 0x65, 0x74, 0x73, 0x18, 0x03, 0x20, 0x01, 0x28, 0x03,
	0x52, 0x16, 0x64, 0x65, 0x6c, 0x69, 0x76, 0x65, 0x72, 0x79, 0x44, 0x75, 0x65, 0x44, 0x61, 0x74,
	0x65, 0x4f, 0x66, 0x66, 0x73, 0x65, 0x74, 0x73, 0x22, 0x32, 0x0a, 0x0c, 0x50, 0x6c, 0x61, 0x74,
	0x66, 0x6f, 0x72, 0x6d, 0x54, 0x79, 0x70, 0x65, 0x12, 0x0e, 0x0a, 0x02, 0x69, 0x64, 0x18, 0x01,
	0x20, 0x01, 0x28, 0x03, 0x52, 0x02, 0x69, 0x64, 0x12, 0x12, 0x0a, 0x04, 0x6e, 0x61, 0x6d, 0x65,
	0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x04, 0x6e, 0x61, 0x6d, 0x65, 0x22, 0x72, 0x0a, 0x0c,
	0x50, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x44, 0x61, 0x74, 0x65, 0x12, 0x0e, 0x0a, 0x02,
	0x69, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x03, 0x52, 0x02, 0x69, 0x64, 0x12, 0x1c, 0x0a, 0x09,
	0x73, 0x74, 0x61, 0x72, 0x74, 0x44, 0x61, 0x74, 0x65, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52,
	0x09, 0x73, 0x74, 0x61, 0x72, 0x74, 0x44, 0x61, 0x74, 0x65, 0x12, 0x18, 0x0a, 0x07, 0x65, 0x6e,
	0x64, 0x44, 0x61, 0x74, 0x65, 0x18, 0x03, 0x20, 0x01, 0x28, 0x09, 0x52, 0x07, 0x65, 0x6e, 0x64,
	0x44, 0x61, 0x74, 0x65, 0x12, 0x1a, 0x0a, 0x08, 0x69, 0x73, 0x41, 0x63, 0x74, 0x69, 0x76, 0x65,
	0x18, 0x04, 0x20, 0x01, 0x28, 0x08, 0x52, 0x08, 0x69, 0x73, 0x41, 0x63, 0x74, 0x69, 0x76, 0x65,
	0x42, 0x48, 0x5a, 0x46, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x4e,
	0x42, 0x43, 0x55, 0x6e, 0x69, 0x76, 0x65, 0x72, 0x73, 0x61, 0x6c, 0x2f, 0x67, 0x76, 0x73, 0x2d,
	0x6d, 0x73, 0x2d, 0x63, 0x6f, 0x6d, 0x6d, 0x6f, 0x6e, 0x2f, 0x74, 0x79, 0x70, 0x65, 0x73, 0x2f,
	0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2f, 0x70, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72,
	0x6d, 0x3b, 0x70, 0x6c, 0x61, 0x74, 0x66, 0x6f, 0x72, 0x6d, 0x62, 0x06, 0x70, 0x72, 0x6f, 0x74,
	0x6f, 0x33,
}

var (
	file_settings_platform_platform_proto_rawDescOnce sync.Once
	file_settings_platform_platform_proto_rawDescData = file_settings_platform_platform_proto_rawDesc
)

func file_settings_platform_platform_proto_rawDescGZIP() []byte {
	file_settings_platform_platform_proto_rawDescOnce.Do(func() {
		file_settings_platform_platform_proto_rawDescData = protoimpl.X.CompressGZIP(file_settings_platform_platform_proto_rawDescData)
	})
	return file_settings_platform_platform_proto_rawDescData
}

var file_settings_platform_platform_proto_msgTypes = make([]protoimpl.MessageInfo, 4)
var file_settings_platform_platform_proto_goTypes = []interface{}{
	(*Platform)(nil),     // 0: com.inbcu.rpc.types.settings.platform.Platform
	(*ServiceType)(nil),  // 1: com.inbcu.rpc.types.settings.platform.ServiceType
	(*PlatformType)(nil), // 2: com.inbcu.rpc.types.settings.platform.PlatformType
	(*PlatformDate)(nil), // 3: com.inbcu.rpc.types.settings.platform.PlatformDate
}
var file_settings_platform_platform_proto_depIdxs = []int32{
	2, // 0: com.inbcu.rpc.types.settings.platform.Platform.platformType:type_name -> com.inbcu.rpc.types.settings.platform.PlatformType
	3, // 1: com.inbcu.rpc.types.settings.platform.Platform.platformDates:type_name -> com.inbcu.rpc.types.settings.platform.PlatformDate
	0, // 2: com.inbcu.rpc.types.settings.platform.Platform.aggregator:type_name -> com.inbcu.rpc.types.settings.platform.Platform
	1, // 3: com.inbcu.rpc.types.settings.platform.Platform.serviceTypes:type_name -> com.inbcu.rpc.types.settings.platform.ServiceType
	4, // [4:4] is the sub-list for method output_type
	4, // [4:4] is the sub-list for method input_type
	4, // [4:4] is the sub-list for extension type_name
	4, // [4:4] is the sub-list for extension extendee
	0, // [0:4] is the sub-list for field type_name
}

func init() { file_settings_platform_platform_proto_init() }
func file_settings_platform_platform_proto_init() {
	if File_settings_platform_platform_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_settings_platform_platform_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Platform); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_settings_platform_platform_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ServiceType); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_settings_platform_platform_proto_msgTypes[2].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*PlatformType); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_settings_platform_platform_proto_msgTypes[3].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*PlatformDate); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_settings_platform_platform_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   4,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_settings_platform_platform_proto_goTypes,
		DependencyIndexes: file_settings_platform_platform_proto_depIdxs,
		MessageInfos:      file_settings_platform_platform_proto_msgTypes,
	}.Build()
	File_settings_platform_platform_proto = out.File
	file_settings_platform_platform_proto_rawDesc = nil
	file_settings_platform_platform_proto_goTypes = nil
	file_settings_platform_platform_proto_depIdxs = nil
}