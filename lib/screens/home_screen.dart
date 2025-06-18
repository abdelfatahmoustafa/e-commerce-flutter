import 'package:flutter/material.dart';
import 'package:Shoppy/models/cart_item.dart';
import 'package:Shoppy/widget/slider.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../utils/storage.dart';
import 'search_delegate.dart';

int quantity = 1;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Product> products = [
    Product(
      id: '3',
      name: 'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
      category: 'accessories',
      image: 'assets/images/accs10.jpg',
      description:
          "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
      price: 100.25,
    ),
    Product(
      id: '5',
      name: 'John Hardy ',
      category: 'accessories',
      image: 'assets/images/accs8.jpg',
      description: 'From our Legends Collection',
      price: 59.99,
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
      id: '15',
      name:
          'Lock and Love Womens Removable Hooded Faux Leather Moto Biker Jacket',
      category: 'clothes',
      image: 'assets/images/woman2.jpg',
      description:
          '100% POLYURETHANE(shell) 100% POLYESTER(lining) 75% POLYESTER 25% COTTON (SWEATER)',
      price: 99.99,
    ),
    Product(
      id: '17',
      name: 'Rain Jacket Women Windbreaker Striped Climbing Raincoats',
      category: 'clothes',
      image: 'assets/images/woman3.jpg',
      description:
          'Lightweight perfet for trip or casual wear---Long sleeve with hooded',
      price: 999.99,
    ),
  ];

  static const List<String> categories = [
    'Accessories',
    'Clothes',
    'Electronics',
  ];

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'accessories':
        return Icons.watch_outlined;
      case 'clothes':
        return Icons.checkroom_outlined;
      case 'electronics':
        return Icons.electrical_services_outlined;
      default:
        return Icons.category_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<User?>(
          future: Storage.getUser(),
          builder: (context, snapshot) {
            return Text('Welcome, ${snapshot.data?.firstName ?? 'User'}');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(products),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/cart'),
        child: const Icon(Icons.shopping_cart),
      ),
      body: ListView(
        children: [
          AutoSlider(
            imagePaths: [
              'assets/images/man1.jpg',
              'assets/images/man2.jpg',
              'assets/images/man3.jpg',
            ],
          ),
          _SectionHeader(title: 'Categories'),
          _CategoryList(
            categories: categories,
            getCategoryIcon: _getCategoryIcon,
          ),
          _SectionHeader(title: 'Featured Products'),
          _ProductGrid(products: products, onAddToCart: _handleAddToCart),
          _SectionHeader(title: 'New Products'),
          _ProductGrid(
            products: products.reversed.toList(),
            onAddToCart: _handleAddToCart,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          FutureBuilder<User?>(
            future: Storage.getUser(),
            builder: (context, snapshot) {
              final user = snapshot.data;
              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                accountName: Text(user?.firstName ?? 'User'),
                accountEmail: Text(user?.email ?? ''),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
              );
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Profile'),
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart_outlined),
                  title: const Text('Cart'),
                  onTap: () => Navigator.pushNamed(context, '/cart'),
                ),
                ListTile(
                  leading: const Icon(Icons.receipt_long_outlined),
                  title: const Text('Orders'),
                  onTap: () => Navigator.pushNamed(context, '/orders'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('Logout'),
                  onTap: () async {
                    await Storage.clearUser();
                    if (!context.mounted) return;
                    await Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAddToCart(Product product) async {
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
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Added to cart')));
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final List<String> categories;
  final IconData Function(String) getCategoryIcon;
  const _CategoryList({
    required this.categories,
    required this.getCategoryIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            '/category',
            arguments: categories[index],
          ),
          child: Container(
            width: 120,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  getCategoryIcon(categories[index]),
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  categories[index],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Future<void> Function(Product) onAddToCart;
  const _ProductGrid({required this.products, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () =>
                Navigator.pushNamed(context, '/product', arguments: product),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(product.image, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_shopping_cart, size: 18),
                    label: const Text('Add'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => onAddToCart(product),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
