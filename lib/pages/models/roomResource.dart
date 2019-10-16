import 'dart:convert';

class RoomResource {
  int id;
  int resourceAmmount;
  int roomId;
  int resourceId;
  
  RoomResource({this.id, this.resourceAmmount, this.roomId, this.resourceId});

  RoomResource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceAmmount = json['resource_amount'];
    roomId = json['room_id'];
    resourceId = json['resource_id'];
  }
  List<RoomResource> roomResourceList(String body) {
    final list = json.decode(body).cast<Map<String, dynamic>>();
    return list.map<RoomResource>((json) => RoomResource.fromJson(json)).toList();
  }
}