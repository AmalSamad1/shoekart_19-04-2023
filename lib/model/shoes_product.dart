class Products {
  final String? name;

  final String? image;
  final String? description;


  Products({
    this.name,

    this.image,
    this.description,
  });


  factory Products.fromMap(Map<dynamic, dynamic> map) {
    return Products(
      name: map['name'] ,
      image: map['image'] ,
      description: map['description'],
    );

  }

}