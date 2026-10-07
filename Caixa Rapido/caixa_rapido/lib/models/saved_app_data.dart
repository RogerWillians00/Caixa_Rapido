import 'dart:convert';
import 'dart:typed_data';

class SavedProduct {
  const SavedProduct({
    required this.name,
    required this.price,
    required this.quantity,
    this.imageBytes,
  });

  final String name;
  final double price;
  final int quantity;
  final Uint8List? imageBytes;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': imageBytes == null ? null : base64Encode(imageBytes!),
    };
  }

  factory SavedProduct.fromJson(Map<String, dynamic> json) {
    if (json['name'] is! String ||
        json['price'] is! num ||
        json['quantity'] is! num) {
      throw const FormatException(
          'Os dados de um produto salvo são inválidos.');
    }

    final image = json['image'];
    if (image != null && image is! String) {
      throw const FormatException('A foto de um produto salvo é inválida.');
    }

    return SavedProduct(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      imageBytes: image == null ? null : base64Decode(image as String),
    );
  }
}

class SavedAppData {
  const SavedAppData({
    required this.cashName,
    required this.products,
    this.cashImageBytes,
  });

  final String cashName;
  final Uint8List? cashImageBytes;
  final List<SavedProduct> products;

  Map<String, dynamic> toJson() {
    return {
      'cashName': cashName,
      'cashImage':
          cashImageBytes == null ? null : base64Encode(cashImageBytes!),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  factory SavedAppData.fromJson(Map<String, dynamic> json) {
    if (json['cashName'] is! String || json['products'] is! List) {
      throw const FormatException('Os dados salvos do caixa são inválidos.');
    }

    final image = json['cashImage'];
    if (image != null && image is! String) {
      throw const FormatException('A foto salva do caixa é inválida.');
    }

    return SavedAppData(
      cashName: json['cashName'] as String,
      cashImageBytes: image == null ? null : base64Decode(image as String),
      products: (json['products'] as List).map((product) {
        if (product is! Map) {
          throw const FormatException(
              'Os dados de um produto salvo são inválidos.');
        }
        return SavedProduct.fromJson(Map<String, dynamic>.from(product));
      }).toList(),
    );
  }

  String encode() => jsonEncode(toJson());

  static SavedAppData decode(String value) {
    final decoded = jsonDecode(value);
    if (decoded is! Map) {
      throw const FormatException('Os dados salvos do caixa são inválidos.');
    }
    return SavedAppData.fromJson(Map<String, dynamic>.from(decoded));
  }
}
