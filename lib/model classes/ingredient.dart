class Ingredient {
  int? quantity;
  String? name;
  String? image;
  int? price;
  String? unit;
  Ingredient({
    this.quantity,
     this.name,
     this.image,
    this.price,
    this.unit,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      quantity: json['quantity'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'name': name,
      'image': image,
      'price': price,
      'unit': price,
    };
  }
}
