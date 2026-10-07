import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:caixa_rapido/models/saved_app_data.dart';

void main() {
  test('saved cash, products and photos survive serialization', () {
    final cashImage = Uint8List.fromList([1, 2, 3]);
    final productImage = Uint8List.fromList([4, 5, 6]);
    final data = SavedAppData(
      cashName: 'Caixa Central',
      cashImageBytes: cashImage,
      products: [
        SavedProduct(
          name: 'Café',
          price: 12.5,
          quantity: 4,
          imageBytes: productImage,
        ),
      ],
    );

    final restoredData = SavedAppData.decode(data.encode());
    final restoredProduct = restoredData.products.single;

    expect(restoredData.cashName, 'Caixa Central');
    expect(restoredData.cashImageBytes!.toList(), cashImage);
    expect(restoredProduct.name, 'Café');
    expect(restoredProduct.price, 12.5);
    expect(restoredProduct.quantity, 4);
    expect(restoredProduct.imageBytes!.toList(), productImage);
  });
}
