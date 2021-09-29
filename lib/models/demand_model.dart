class Demand {
  final String? id;
  final String? name;
  final String? description;
  final String? adresse;
  final String? mail;
  final String? rNA;
  final String? status;
  final String? createdAt;

  Demand({
    this.id,
    this.name,
    this.description,
    this.adresse,
    this.mail,
    this.status,
    this.rNA,
    this.createdAt,
  });

  factory Demand.fromJson(Map<String, dynamic> json) {
    return Demand(
      id: json['id'].toString(),
      mail: json['mail'].toString(),
      status: json['status'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      adresse: json['adresse'].toString(),
      rNA: json['RNA'].toString(),
      createdAt: json['createdAt'].toString(),
    );
  }

  @override
  String toString() {
    return '{ ${this.id},${this.name},${this.mail}, ${this.status}}';
  }
}
