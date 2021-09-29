class Project {
  final String? id;
  final String? name;
  final String? description;
  final String? dateCreation;
  final String? debutPrevu;
  final String? finPrevu;
  final String? budgetAttendu;
  final String? status;
  final String? associationId;
  final String? createdAt;
  final String? association;

  Project({
    this.id,
    this.name,
    this.description,
    this.dateCreation,
    this.debutPrevu,
    this.finPrevu,
    this.budgetAttendu,
    this.status,
    this.associationId,
    this.createdAt,
    this.association,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      dateCreation: json['dateCreation'].toString(),
      debutPrevu: json['debutPrevu'].toString(),
      finPrevu: json['finPrevu'].toString(),
      budgetAttendu: json['budgetAttendu'].toString(),
      status: json['status'].toString(),
      associationId: json['associationId'].toString(),
      createdAt: json['createdAt'].toString(),
      association: json['association']["name"].toString(),
    );
  }

  @override
  String toString() {
    return '{ ${this.id},${this.name},${this.associationId}, ${this.status}}';
  }
}


// "id": 1,
//                 "name": "asso",
//                 "description": "Description",
//                 "dateCreation": "2020-02-01",
//                 "debutPrevu": "2021-02-02",
//                 "finPrevu": "2020-02-02",
//                 "budgetAttendu": 54548,
//                 "status": "En Attendant",
//                 "associationId": 1,
//                 "createdAt": "2021-09-23T14:43:36.000Z",
//                 "updatedAt": "2021-09-23T14:43:36.000Z",
//                 "association": {
//                     "name": "asso"
//                 }