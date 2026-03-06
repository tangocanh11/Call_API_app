# Food Menu App 🍽️

**TH3 - Tạ Thị Ngọc Anh - 2351160503**

Ứng dụng quản lý và hiển thị thực đơn món ăn sử dụng Flutter kết nối với Firebase Firestore để lấy dữ liệu thời gian thực.

## 📋 Tổng quan

Food Menu App là ứng dụng di động đa nền tảng (Android, iOS, Web) được phát triển bằng Flutter, cho phép người dùng xem danh sách các món ăn với thông tin chi tiết như hình ảnh, mô tả, calories và nguyên liệu. Ứng dụng sử dụng Firebase Firestore làm nguồn dữ liệu backend.

## ✨ Chức năng chính

### 1. **Hiển thị danh sách món ăn**
   - Hiển thị tất cả món ăn dưới dạng danh sách cards
   - Mỗi card món ăn bao gồm:
     - Hình ảnh món ăn
     - Tên món ăn
     - Danh mục (category badge)
     - Mô tả ngắn gọn (rút gọn 2 dòng)
     - Thông tin calories
     - Danh sách nguyên liệu (hiển thị 3 nguyên liệu đầu tiên)

### 2. **Xem chi tiết món ăn**
   - Bấm vào bất kỳ card món ăn nào để xem chi tiết
   - Điều hướng đến màn hình FoodDetailScreen
   - Hiển thị đầy đủ thông tin:
     - Hình ảnh lớn hơn (220px height)
     - Tên món ăn và danh mục
     - **Mô tả đầy đủ** (không bị rút gọn)
     - Thông tin calories
     - Tất cả nguyên liệu dưới dạng Chips
   - Nút Back để quay lại danh sách

### 3. **Lọc món ăn theo danh mục**
   - Thanh lọc ngang ở đầu màn hình
   - Nút "All" để hiển thị tất cả món ăn
   - Các nút FilterChip động cho từng danh mục
   - Tự động tải danh mục từ Firestore
   - Cập nhật danh sách món ăn khi chọn danh mục

### 4. **Xử lý trạng thái**
   - **Loading state**: Hiển thị CircularProgressIndicator khi đang tải dữ liệu
   - **Error state**: Hiển thị thông báo lỗi với nút "Thử lại"
   - **Empty state**: Hiển thị thông báo "Không có dữ liệu"
   - **Success state**: Hiển thị danh sách món ăn

### 5. **Tương tác hình ảnh**
   - Lazy loading cho hình ảnh
   - Loading indicator khi tải hình ảnh
   - Fallback icon khi hình ảnh lỗi

## 🎨 Giao diện

### Màn hình chính (Home Screen)
```
┌─────────────────────────────────────┐
│  AppBar: Thông tin sinh viên       │
├─────────────────────────────────────┤
│  Filter Bar: [All] [Category1]...  │
├─────────────────────────────────────┤
│  ┌───────────────────────────────┐ │
│  │  Food Card 1 (Tappable)       │ │
│  │  ┌─────────────────────────┐  │ │
│  │  │  Image (200px height)   │  │ │
│  │  └─────────────────────────┘  │ │
│  │  Name              [Category]│ │
│  │  Description (2 lines max)... │ │
│  │  🔥 XXX calories              │ │
│  │  Ingredients: [A] [B] [C]    │ │
│  └───────────────────────────────┘ │
│  ┌───────────────────────────────┐ │
│  │  Food Card 2 (Tappable)       │ │
│  │  ...                          │ │
│  └───────────────────────────────┘ │
└─────────────────────────────────────┘
```

### Màn hình chi tiết món ăn (Food Detail Screen)
```
┌─────────────────────────────────────┐
│  ← [Tên món ăn]         AppBar     │
├─────────────────────────────────────┤
│  ┌─────────────────────────────┐   │
│  │  Large Image (220px height) │   │
│  └─────────────────────────────┘   │
│                                     │
│  Tên món ăn          [Category]    │
│  🔥 XXX calories                    │
│                                     │
│  Mô tả đầy đủ của món ăn...         │
│  (Không giới hạn số dòng)           │
│                                     │
│  Nguyên liệu:                       │
│  [Chip A] [Chip B] [Chip C]         │
│  [Chip D] [Chip E] ...              │
│                                     │
└─────────────────────────────────────┘
```

### Thiết kế UI
- **Màu sắc chủ đạo**: Deep Orange (#FF5722)
- **Elevation**: Cards có shadow để tạo độ sâu
- **Border Radius**: 12px cho cards, 4-12px cho chips
- **Typography**: Material Design 3
- **Responsive**: Adaptive layout cho các màn hình khác nhau

## 🔄 Luồng ứng dụng

### 1. **Khởi động ứng dụng**
```
main.dart
  ↓
WidgetsFlutterBinding.ensureInitialized()
  ↓
Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  ↓
runApp(MyApp)
  ↓
MaterialApp → HomeScreen
```

### 2. **Tải dữ liệu**
```
HomeScreen.initState()
  ↓
_categoriesFuture = FoodService.getCategories()
  ↓
_loadFoodData()
  ↓
_foodFuture = FoodService.fetchFoodList()
  ↓
FutureBuilder → build UI based on state
```

### 3. **Lọc theo danh mục**
```
User taps FilterChip
  ↓
_selectCategory(category)
  ↓
setState(() { _selectedCategory = category; _loadFoodData(); })
  ↓
_foodFuture = FoodService.fetchFoodByCategory(category)
  ↓
FutureBuilder rebuilds with new data
```

### 4. **Xem chi tiết món ăn**
```
User taps FoodCard
  ↓
FoodCard.onTap() callback
  ↓
Navigator.push()
  ↓
FoodDetailScreen(food: food)
  ↓
Hiển thị chi tiết món ăn với description đầy đủ
  ↓
User taps Back button
  ↓
Navigator.pop() → Quay lại HomeScreen
```

## 📊 Nguồn dữ liệu

### Firebase Firestore
- **Collection**: `foods`
- **Platform**: Android, iOS, Web
- **Cấu hình**: Sử dụng FlutterFire CLI với `firebase_options.dart`

### Cấu trúc dữ liệu Food Document
```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "category": "string",
  "calories": number,
  "imageUrl": "string",
  "ingredients": ["string"]
}
```

### FoodService API
- `fetchFoodList()`: Lấy tất cả món ăn
  - Timeout: 10 giây
  - Source: Server
  - Trả về: `Future<List<Food>>`

- `fetchFoodByCategory(category)`: Lấy món ăn theo danh mục
  - Query: `where('category', isEqualTo: category)`
  - Timeout: 10 giây
  - Trả về: `Future<List<Food>>`

- `getCategories()`: Lấy danh sách danh mục
  - Lấy tất cả documents và extract unique categories
  - Trả về: `Future<List<String>>`

## 📁 Cấu trúc mã nguồn

```
lib/
├── main.dart                     # Entry point, khởi tạo Firebase
├── firebase_options.dart         # Cấu hình Firebase (auto-generated)
│
├── models/
│   └── food_model.dart          # Data model cho món ăn
│       ├── Food class
│       ├── fromJson() factory
│       └── toJson() method
│
├── services/
│   └── food_service.dart        # Business logic, API calls
│       ├── fetchFoodList()
│       ├── fetchFoodByCategory()
│       └── getCategories()
│
└── screens/
    ├── home_screen.dart         # Màn hình chính
    │   ├── HomeScreen (StatefulWidget)
    │   │   ├── State management
    │   │   ├── FutureBuilder cho categories
    │   │   ├── FutureBuilder cho foods
    │   │   └── Navigation logic
    │   └── FoodCard (StatelessWidget)
    │       ├── UI component cho 1 món ăn
    │       ├── InkWell với onTap callback
    │       └── Description rút gọn (maxLines: 2)
    │
    └── food_detail_screen.dart  # Màn hình chi tiết món ăn
        └── FoodDetailScreen (StatelessWidget)
            ├── Nhận Food object từ constructor
            ├── Hiển thị hình ảnh lớn
            ├── Description đầy đủ (không rút gọn)
            └── Tất cả nguyên liệu dạng Chips

android/
├── app/
│   └── google-services.json     # Firebase config cho Android

web/
└── index.html                   # Entry point cho web

pubspec.yaml                     # Dependencies và assets
```

### Chi tiết các file chính

#### 1. **main.dart**
- Khởi tạo Flutter binding
- Khởi tạo Firebase với platform-specific options
- Định nghĩa MaterialApp với theme
- Route đến HomeScreen

#### 2. **models/food_model.dart**
- Class `Food` với các thuộc tính:
  - `id`, `name`, `description`, `category`
  - `calories`, `imageUrl`, `ingredients`
- Factory constructor `fromJson()` để parse JSON từ Firestore
- Method `toJson()` để convert sang JSON

#### 3. **services/food_service.dart**
- Static methods để gọi Firestore API
- Error handling với timeout 10 giây
- GetOptions với `Source.server` để đảm bảo dữ liệu mới nhất

#### 4. **screens/home_screen.dart**
- **HomeScreen (StatefulWidget)**:
  - Quản lý state: `_foodFuture`, `_categoriesFuture`, `_selectedCategory`
  - Methods: `_loadFoodData()`, `_retryLoadData()`, `_selectCategory()`
  - Build UI với Column chứa filter bar và food list
  - Navigation logic: Điều hướng đến FoodDetailScreen khi tap card
  
- **FoodCard (StatelessWidget)**:
  - Nhận `Food` object và `onTap` callback qua constructor
  - Hiển thị thông tin món ăn trong Material Card
  - Wrapped trong InkWell để bắt sự kiện tap
  - Description bị rút gọn với `maxLines: 2` và `overflow: TextOverflow.ellipsis`
  - Image loading với error và loading builders

#### 5. **screens/food_detail_screen.dart**
- **FoodDetailScreen (StatelessWidget)**:
  - Đơn giản, stateless widget để hiển thị chi tiết
  - Nhận `Food` object qua constructor từ route
  - AppBar với tên món ăn và nút Back tự động
  - SingleChildScrollView để scroll nội dung dài
  - Hiển thị:
    - Hình ảnh lớn (220px height) với ClipRRect
    - Tên món ăn và category badge
    - Calories với icon
    - **Description đầy đủ** (không giới hạn maxLines)
    - Tất cả nguyên liệu dưới dạng Chip trong Wrap widget

## 🛠️ Công nghệ sử dụng

### Framework & Language
- **Flutter** 3.10.7+
- **Dart** 3.10.7+

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  
  # Firebase
  firebase_core: ^3.15.2           # Core Firebase functionality
  cloud_firestore: ^5.0.0          # Firestore database
  firebase_database: ^11.3.10      # Realtime Database (optional)

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

### Firebase Services
- **Firebase Core**: Khởi tạo và quản lý Firebase
- **Cloud Firestore**: NoSQL database lưu trữ dữ liệu món ăn

## 🚀 Hướng dẫn cài đặt và chạy

### Yêu cầu hệ thống
- Flutter SDK 3.10.7 trở lên
- Dart SDK 3.10.7 trở lên
- Android Studio / VS Code
- Firebase account

### Cài đặt

1. **Clone repository**
   ```bash
   git clone <repository-url>
   cd call_api_app
   ```

2. **Cài đặt dependencies**
   ```bash
   flutter pub get
   ```

3. **Cấu hình Firebase**
   ```bash
   # Cài đặt FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Cấu hình Firebase cho các platforms
   flutterfire configure --platforms=android,web
   ```
   - Chọn Firebase project của bạn
   - File `firebase_options.dart` sẽ được tạo tự động

4. **Đảm bảo `google-services.json` có trong `android/app/`**

### Chạy ứng dụng

**Trên Android:**
```bash
flutter run -d <device-id>
```

**Trên Web (Chrome):**
```bash
flutter run -d chrome
```

**Trên iOS:**
```bash
flutter run -d <ios-device-id>
```

**Xem danh sách devices:**
```bash
flutter devices
```

### Build Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**Web:**
```bash
flutter build web --release
```

## 🔧 Troubleshooting

### Lỗi Firebase không khởi tạo trên Web
**Giải pháp**: Đảm bảo đã cấu hình Firebase cho web
```bash
flutterfire configure --platforms=web
```

### Lỗi Firebase không khởi tạo trên Android
**Giải pháp**: Đảm bảo đã cấu hình Firebase cho android
```bash
flutterfire configure --platforms=android
```

### App bị đứng khi tải dữ liệu
**Nguyên nhân**: 
- Firebase chưa cấu hình đúng platform
- Network timeout
- Firestore rules chặn truy cập

**Giải pháp**:
1. Kiểm tra Firebase configuration
2. Kiểm tra Firestore rules:
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /foods/{document=**} {
         allow read: if true;
       }
     }
   }
   ```
3. Kiểm tra kết nối mạng

### Clean build nếu gặp lỗi
```bash
flutter clean
flutter pub get
```

## 📱 Platforms hỗ trợ

- ✅ Android
- ✅ Web (Chrome, Edge)
- ⚠️ iOS (cần cấu hình thêm)
- ❌ Windows, macOS, Linux (chưa cấu hình Firebase)

## 📝 Notes

- Ứng dụng yêu cầu kết nối Internet để lấy dữ liệu từ Firestore
- Timeout cho mỗi request là 10 giây
- Hình ảnh được load từ URL, cần đảm bảo imageUrl hợp lệ trong Firestore
- Material Design 3 với UseMaterial3: true

## 👨‍💻 Tác giả

**Tạ Thị Ngọc Anh**  
MSSV: 2351160503  
Lớp: 65HTTT

---

## 📚 Tài liệu tham khảo

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase for Flutter](https://firebase.google.com/docs/flutter/setup)
- [Cloud Firestore](https://firebase.google.com/docs/firestore)
- [Material Design 3](https://m3.material.io/)
