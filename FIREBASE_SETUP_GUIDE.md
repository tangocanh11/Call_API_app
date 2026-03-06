# Firebase Setup Guide - Call API App

## 📋 Yêu cầu
- Tài khoản Google
- Firebase Project
- FlutterFire CLI (tùy chọn nhưng được khuyến nghị)

---

## ✅ Bước 1: Tạo Firebase Project

1. Truy cập [Firebase Console](https://console.firebase.google.com/)
2. Click "Create Project"
3. Nhập tên project: `call_api_app`
4. Click "Continue"
5. Tiếp tục theo hướng dẫn để tạo project

---

## ✅ Bước 2: Cấu hình Firebase cho Android

### 2.1 Tải Google Services JSON
1. Vào Firebase Console → Project → Settings ⚙️
2. Tab "Service Accounts"
3. Chọn ngôn ngữ "Firebase Admin SDK"
4. Click "Generate new private key"
5. Lưu file nó sẽ download

### 2.2 Thêm Google Services JSON
1. Copy file `google-services.json` vừa download
2. Dán vào: `android/app/` folder
   ```
   call_api_app/
   └── android/
       └── app/
           └── google-services.json  ← dán vào đây
   ```

### 2.3 Cấu hình Android Build Files
Đảm bảo `android/build.gradle.kts` hoặc `android/build.gradle` có:
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

Đảm bảo `android/app/build.gradle.kts` hoặc `android/app/build.gradle` có:
```gradle
plugins {
    id 'com.android.application'
    id 'com.google.gms.google-services'
}
```

---

## ✅ Bước 3: Cấu hình Firebase cho iOS

1. Vào Firebase Console → Your App → iOS
2. Tải file `GoogleService-Info.plist`
3. Mở Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```
4. Right-click "Runner" → "Add Files to Runner"
5. Chọn `GoogleService-Info.plist` vừa download
6. Đảm bảo nó được add vào "Runner" target
7. Close Xcode

---

## ✅ Bước 4: Cập nhật Firebase Options

Nếu bạn có FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Hoặc cập nhật `lib/firebase_options.dart` thủ công bằng thông tin từ Firebase Console:
- Lấy API Keys từ: Firebase Console → Project Settings → API Keys
- Lấy Project ID từ: Firebase Console → Project Settings

---

## ✅ Bước 5: Tạo Firestore Database

1. Vào Firebase Console → Your Project → Firestore Database
2. Click "Create Database"
3. Chọn vị trí gần nhất
4. Chọn "Start in test mode" (cho phát triển)
   - ⚠️ **Note**: Test mode cho phép ai cũng có thể đọc/ghi. Đổi thành "Production mode" trước khi deploy!
5. Click "Create"

---

## ✅ Bước 6: Tạo Collection "foods" (Tùy chọn)

Nếu bạn muốn thêm dữ liệu thủ công:

1. Click "Create collection"
2. Đặt tên: `foods`
3. Click "Create"
4. Click "Add document"
5. Thêm documents với các fields:
   - `id`: string
   - `name`: string
   - `description`: string
   - `category`: string
   - `calories`: number
   - `imageUrl`: string
   - `ingredients`: array of strings

**Hoặc** ứng dụng sẽ tự động thêm mock data lần đầu chạy!

---

## 🔧 Cài đặt Dependencies

```bash
cd call_api_app
flutter pub get
```

---

## ▶️ Chạy Ứng dụng

```bash
flutter run
```

---

## 🐛 Troubleshooting

### "NoSuchMethodError: The getter 'currentPlatform' was called on null"
- Đảm bảo Firebase đã được khởi tạo trong `main()`
- Kiểm tra `firebase_options.dart` không có lỗi

### "PlatformException: Cloud Firestore failed"
- Kiểm tra Rule Firestore (Firebase Console)
- Đảm bảo database đang dùng "test mode"
- Kiểm tra mạng internet

### "google-services.json not found"
- Đảm bảo file lưu đúng vị trí: `android/app/google-services.json`
- Rebuild Android: `flutter clean && flutter run`

### iOS không kết nối Firebase
- Kiểm tra `GoogleService-Info.plist` được add vào Xcode đúng cách
- Run: `flutter clean && flutter run -v`

---

## 📚 Tài liệu Tham Khảo
- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Cloud Firestore Documentation](https://firebase.google.com/docs/firestore)

---

## ✨ Hoàn tất!

Ứng dụng của bạn hiện đang:
✅ Lấy dữ liệu từ Firebase Firestore  
✅ Xử lý Loading, Error, Retry states  
✅ Hiển thị menu món ăn  
✅ Filter theo category  

Chúc bạn thành công! 🎉
