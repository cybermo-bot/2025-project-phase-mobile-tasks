import 'dart:io';

class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  String get name => _name;
  String get description => _description;
  double get price => _price;

  set name(String value) {
    _name = value.trim();
  }

  set description(String value) {
    _description = value.trim();
  }

  set price(double value) {
    _price = value;
  }
}

class ProductManager {
  final List<Product> _products = [];
  int get productCount => _products.length;


  void addProduct(Product product) {
    if (product.name.trim().isEmpty) {
      print('\nProduct name cannot be empty.');
      return;
    }

    _products.add(product);
    print('\nProduct added.');
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print('\nNo products yet.');
      return;
    }

    print('\nProducts:');
    for (int i = 0; i < _products.length; i++) {
      final p = _products[i];
      print('\n${i + 1}. ${p.name}');
      print('Description: ${p.description}');
      print('Price: ${p.price.toStringAsFixed(2)}');
    }
  }

  void viewSingleProduct(int index) {
    if (index < 0 || index >= _products.length) {
      print('\nInvalid product number.');
      return;
    }

    final p = _products[index];
    print('\nProduct info:');
    print('Name: ${p.name}');
    print('Description: ${p.description}');
    print('Price: ${p.price.toStringAsFixed(2)}');
  }

  void editProduct(int index, String name, String description, double price) {
    if (index < 0 || index >= _products.length) {
      print('\nInvalid product number.');
      return;
    }

    final p = _products[index];
    p.name = name;
    p.description = description;
    p.price = price;

    print('\nProduct updated.');
  }

  void deleteProduct(int index) {
    if (index < 0 || index >= _products.length) {
      print('\nInvalid product number.');
      return;
    }

    _products.removeAt(index);
    print('\nProduct deleted.');
  }
}

void main() {
  final manager = ProductManager();

  while (true) {
    print('''
========================
  Simple eCommerce App
========================
1. Add Product
2. View All Products
3. View Single Product
4. Edit Product
5. Delete Product
6. Exit
''');

    stdout.write('Enter your choice: ');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter product name: ');
        final name = stdin.readLineSync() ?? '';

        stdout.write('Enter description: ');
        final description = stdin.readLineSync() ?? '';

        stdout.write('Enter price: ');
        final priceInput = stdin.readLineSync() ?? '0';
        final price = double.tryParse(priceInput.replaceAll(',', '.')) ?? 0;

        manager.addProduct(Product(name, description, price));
        break;

      case '2':
        manager.viewAllProducts();
        break;

      case '3':
        stdout.write('Enter product number: ');
        final idxStr = stdin.readLineSync() ?? '';
        final idx = int.tryParse(idxStr) ?? -1;
        manager.viewSingleProduct(idx - 1);
        break;

      case '4':
        stdout.write('Enter product number to edit: ');
        final eStr = stdin.readLineSync() ?? '';
        final eIdx = int.tryParse(eStr) ?? -1;

        stdout.write('Enter new name: ');
        final newName = stdin.readLineSync() ?? '';

        stdout.write('Enter new description: ');
        final newDesc = stdin.readLineSync() ?? '';

        stdout.write('Enter new price: ');
        final newPriceStr = stdin.readLineSync() ?? '0';
        final newPrice =
            double.tryParse(newPriceStr.replaceAll(',', '.')) ?? 0;

        manager.editProduct(eIdx - 1, newName, newDesc, newPrice);
        break;

      case '5':
        stdout.write('Enter product number to delete: ');
        final dStr = stdin.readLineSync() ?? '';
        final dIdx = int.tryParse(dStr) ?? -1;
        manager.deleteProduct(dIdx - 1);
        break;

      case '6':
        print('\nExiting...');
        return;

      default:
        print('\nInvalid choice.');
    }
  }
}
