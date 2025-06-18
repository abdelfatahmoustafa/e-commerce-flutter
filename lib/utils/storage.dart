import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/cart_item.dart';
import '../models/order.dart';

class Storage {
  static Future<SharedPreferences> _getPrefs() async =>
      await SharedPreferences.getInstance();

  static Future<void> saveUser(User user) async {
    final prefs = await _getPrefs();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  static Future<User?> getUser() async {
    final prefs = await _getPrefs();
    final userJson = prefs.getString('user');
    return userJson != null ? User.fromJson(jsonDecode(userJson)) : null;
  }

  static Future<void> clearUser() async {
    final prefs = await _getPrefs();
    await prefs.remove('user');
  }

  static Future<void> saveCart(List<CartItem> cart) async {
    final prefs = await _getPrefs();
    await prefs.setString(
      'cart',
      jsonEncode(cart.map((item) => item.toJson()).toList()),
    );
  }

  static Future<List<CartItem>> getCart() async {
    final prefs = await _getPrefs();
    final cartJson = prefs.getString('cart');
    return cartJson != null
        ? (jsonDecode(cartJson) as List)
              .map((i) => CartItem.fromJson(i))
              .toList()
        : [];
  }

  static Future<void> saveOrders(List<Order> orders) async {
    final prefs = await _getPrefs();
    await prefs.setString(
      'orders',
      jsonEncode(orders.map((order) => order.toJson()).toList()),
    );
  }

  static Future<List<Order>> getOrders() async {
    final prefs = await _getPrefs();
    final ordersJson = prefs.getString('orders');
    return ordersJson != null
        ? (jsonDecode(ordersJson) as List)
              .map((i) => Order.fromJson(i))
              .toList()
        : [];
  }
}
