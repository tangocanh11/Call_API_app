import 'package:call_api_app/models/food_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodService {

  // Fetch food data from Firebase Firestore
  static Future<List<Food>> fetchFoodList() async {
    try {
      // Thử lấy từ server trước (timeout 10 giây)
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('foods')
              .get(const GetOptions(source: Source.server))
              .timeout(
                const Duration(seconds: 10),
                onTimeout: () => throw Exception('Kết nối quá chậm'),
              );

      if (snapshot.docs.isEmpty) {
        throw Exception('Không có dữ liệu trong Firestore');
      }

      List<Food> foods = snapshot.docs
          .map((doc) => Food.fromJson({...doc.data(), 'id': doc.id}))
          .toList();

      return foods;
    } catch (e) {
      throw Exception(
        'Không thể kết nối đến máy chủ. Vui lòng kiểm tra mạng và thử lại.',
      );
    }
  }

  // Fetch food by category from Firestore
  static Future<List<Food>> fetchFoodByCategory(String category) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('foods')
              .where('category', isEqualTo: category)
              .get(const GetOptions(source: Source.server))
              .timeout(
                const Duration(seconds: 10),
                onTimeout: () => throw Exception('Kết nối quá chậm'),
              );

      if (snapshot.docs.isEmpty) {
        throw Exception('Không có món ăn trong danh mục "$category"');
      }

      List<Food> foods = snapshot.docs
          .map((doc) => Food.fromJson({...doc.data(), 'id': doc.id}))
          .toList();

      return foods;
    } catch (e) {
      throw Exception(
        'Không thể kết nối đến máy chủ. Vui lòng kiểm tra mạng và thử lại.',
      );
    }
  }

  // Get all categories from Firestore
  static Future<List<String>> getCategories() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('foods')
              .get(const GetOptions(source: Source.server))
              .timeout(
                const Duration(seconds: 10),
                onTimeout: () => throw Exception('Kết nối quá chậm'),
              );

      Set<String> categories = {};
      for (var doc in snapshot.docs) {
        String category = doc.data()['category'] ?? 'Other';
        categories.add(category);
      }

      if (categories.isEmpty) {
        throw Exception('Không có danh mục nào');
      }

      return categories.toList();
    } catch (e) {
      throw Exception('Lỗi tải danh mục');
    }
  }
}
