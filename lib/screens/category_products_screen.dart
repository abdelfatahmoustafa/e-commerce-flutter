import 'package:flutter/material.dart';
import 'package:Shoppy/models/cart_item.dart';
import 'package:Shoppy/utils/storage.dart';
import '../models/product.dart';

int quantity = 1;

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key});

  static const List<Product> products = [
    Product(
      id: '1',
      name: 'Laptop Pro 15"',
      category: 'electronics',
      image: 'assets/images/elc.png',
      description:
          'High-performance laptop with 15-inch Retina display, powerful processor, and long battery life for work and entertainment.',
      price: 1200,
    ),
    Product(
      id: '2',
      name: 'Digital Camera X200',
      category: 'electronics',
      image: 'assets/images/elc1.png',
      description:
          'Compact digital camera with 20MP sensor, 5x optical zoom, and built-in Wi-Fi for easy sharing.',
      price: 350,
    ),
    Product(
      id: '3',
      name: 'Smartphone Galaxy Z',
      category: 'electronics',
      image: 'assets/images/elc4.png',
      description:
          'Latest generation smartphone with 6.5-inch OLED display, advanced camera system, and 5G connectivity.',
      price: 999.99,
    ),
    Product(
      id: '4',
      name: 'Gaming Console PS5',
      category: 'electronics',
      image: 'assets/images/elc2.png',
      description:
          'Next-gen gaming console with ultra-fast SSD, ray tracing, and immersive 4K gaming experience.',
      price: 499.99,
    ),
    Product(
      id: '5',
      name: 'Wireless Headphones X500',
      category: 'electronics',
      image: 'assets/images/elc3.png',
      description:
          'Noise-cancelling wireless headphones with 30 hours battery life and crystal-clear sound quality.',
      price: 199.99,
    ),

    Product(
      id: '6',
      name: 'Solid Gold Petite Micropave',
      category: 'accessories',
      image: 'assets/images/accs5.jpg',
      description: 'Satisfaction Guaranteed',
      price: 299.99,
    ),

    Product(
      id: '6',
      name: 'Solid Gold Petite Micropave',
      category: 'accessories',
      image: 'assets/images/accs8.jpg',
      description: 'Satisfaction Guaranteed',
      price: 299.99,
    ),
    Product(
      id: '7',
      name: 'Pierced Owl Rose Gold Plated Stainless Steel Double',
      category: 'accessories',
      image: 'assets/images/accs3.jpg',
      description: 'Rose Gold Plated Double Flared Tunnel Plug Earrings',
      price: 429.99,
    ),
    Product(
      id: '8',
      name: 'White Gold Plated Princess',
      category: 'accessories',
      image: 'assets/images/accs7.jpg',
      description: 'Classic Created Wedding Engagement',
      price: 499.99,
    ),
    Product(
      id: '9',
      name: 'WD 2TB Elements Portable External Hard Drive - USB 3.0',
      category: 'electronics',
      image: 'assets/images/elc5.jpg',
      description: 'USB 3.0 and USB 2.0 Compatibility Fast data transfers',
      price: 499.99,
    ),
    Product(
      id: '10',
      name: 'WD 2TB Elements Portable External Hard Drive - USB 3.0',
      category: 'electronics',
      image: 'assets/images/elc6.jpg',
      description: 'Easy upgrade for faster boot up, shutdown',
      price: 419.99,
    ),
    Product(
      id: '11',
      name:
          'Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5',
      category: 'electronics',
      image: 'assets/images/elc10.jpg',
      description: '3D NAND flash are applied to deliver high transfer',
      price: 299.99,
    ),
    Product(
      id: '12',
      name: 'Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin',
      category: 'electronics',
      image: 'assets/images/elc8.jpg',
      description: '21. 5 inches Full HD (1920 x 1080) widescreen IPS display',
      price: 899.99,
    ),
    Product(
      id: '13',
      name:
          'Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) – Super Ultrawide Screen QLED',
      category: 'electronics',
      image: 'assets/images/elc9.jpg',
      description:
          '49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR with dual 27 inch',
      price: 999.99,
    ),
    Product(
      id: '14',
      name: 'BIYLACLESEN Womens 3-in-1 Snowboard Jacket Winter Coats',
      category: 'clothes',
      image: 'assets/images/woman1.jpg',
      description: 'Note:The Jackets is US standard size',
      price: 199.99,
    ),

    Product(
      id: '14',
      name: 'BIYLACLESEN Womens 3-in-1 Snowboard Jacket Winter Coats',
      category: 'clothes',
      image: 'assets/images/woman2.jpg',
      description: 'Note:The Jackets is US standard size',
      price: 199.99,
    ),
    Product(
      id: '15',
      name:
          'Lock and Love Womens Removable Hooded Faux Leather Moto Biker Jacket',
      category: 'clothes',
      image: 'assets/images/woman3.jpg',
      description:
          '100% POLYURETHANE(shell) 100% POLYESTER(lining) 75% POLYESTER 25% COTTON (SWEATER)',
      price: 99.99,
    ),
    Product(
      id: '17',
      name: 'Rain Jacket Women Windbreaker Striped Climbing Raincoats',
      category: 'clothes',
      image: 'assets/images/woman4.jpg',
      description:
          'Lightweight perfet for trip or casual wear---Long sleeve with hooded',
      price: 999.99,
    ),
    Product(
      id: '17',
      name: 'Rain Jacket Women Windbreaker Striped Climbing Raincoats',
      category: 'clothes',
      image: 'assets/images/woman5.jpg',
      description:
          'Lightweight perfet for trip or casual wear---Long sleeve with hooded',
      price: 999.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String;

    final filteredProducts = products
        .where((p) => p.category.toLowerCase() == category.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return Card(
            elevation: 2,
            child: InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, '/product', arguments: product),
              child: ProductCard(
                product: product,
                onAddToCart: () async {
                  final cart = await Storage.getCart();
                  final existingItem = cart.firstWhere(
                    (item) => item.product.id == product.id,
                    orElse: () => CartItem(product: product, quantity: 0),
                  );
                  if (existingItem.quantity > 0) {
                    existingItem.quantity += quantity;
                  } else {
                    cart.add(CartItem(product: product, quantity: quantity));
                  }
                  await Storage.saveCart(cart);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            product.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('\$${product.price.toStringAsFixed(2)}'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: onAddToCart,
            child: const Text('Add to Cart'),
          ),
        ),
      ],
    );
  }
}
