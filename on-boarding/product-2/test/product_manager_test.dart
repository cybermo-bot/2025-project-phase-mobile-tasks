import 'package:test/test.dart';
import '../bin/product_2.dart';

void main() {
  group('ProductManager.addProduct', () {
    test('adds valid product', () {
      final manager = ProductManager();
      final p = Product('Phone', 'nice', 50.0);

      manager.addProduct(p);

      expect(manager.productCount, 1);
    });

    test('rejects product with empty name', () {
      final manager = ProductManager();
      final p = Product('', 'no name', 10.0);

      manager.addProduct(p);

      expect(manager.productCount, 0);
    });
  });
}
