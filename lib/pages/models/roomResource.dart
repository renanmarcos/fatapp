class RoomResource {
  int id;
  int resourceAmmount;
  int roomId;
  int resourceId;
  
  RoomResource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceAmmount = json['resource_amount'];
    roomId = json['room_id'];
    resourceId = json['resource_id'];
  }
}