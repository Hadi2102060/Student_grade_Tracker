
# 📚 Student Grade Tracker

A modern, feature-rich Flutter application for tracking and managing student grades with cloud-based storage using Firebase Firestore.

![Flutter](https://img.shields.io/badge/Flutter-3.11+-blue)
![Dart](https://img.shields.io/badge/Dart-3.11+-blue)
![Firebase](https://img.shields.io/badge/Firebase-Latest-orange)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 🎯 Features

✅ **Add Subjects** - Easily add new subjects with marks (0-100)  
✅ **Grade Calculation** - Automatic grade assignment based on marks
- A: 80-100
- B: 65-79
- C: 50-64
- F: 0-49

✅ **Cloud Storage** - All data synced with Firebase Firestore  
✅ **Subject Management** - View and delete subjects from your list  
✅ **Summary Analytics** - Track overall performance and statistics  
✅ **Dark Mode** - Toggle between light and dark themes  
✅ **Real-time Sync** - Automatic data synchronization across devices  
✅ **Responsive UI** - Works seamlessly on all screen sizes  

---

## 📦 Prerequisites

Before you start, ensure you have:

- **Flutter SDK** (3.11.0 or higher)
- **Dart SDK** (3.11.0 or higher)
- **Firebase Account** with a Firestore database
- **Git** for version control
- **Android Studio/Xcode** for platform-specific setup

---

## 🚀 Installation & Setup

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd Student_grade_Tracker
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

#### For Android:
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project or use an existing one
3. Add Android app to your project
4. Download `google-services.json`
5. Place it in `android/app/` directory

#### For iOS:
1. In Firebase Console, add iOS app
2. Download `GoogleService-Info.plist`
3. Open `ios/Runner.xcworkspace` in Xcode
4. Add the plist file to the Runner project

#### For Web:
1. Update `firebase_options.dart` with your web config
2. Run `firebase login` and `flutterfire configure`

### 4. Run the Application

**For Development:**
```bash
flutter run
```

**For Release:**
```bash
flutter run --release
```

---

## 📂 Project Structure

```
lib/
├── main.dart                 # App entry point & Firebase initialization
├── firebase_options.dart     # Firebase configuration
├── models/
│   └── subject.dart         # Subject data model
├── providers/
│   ├── subject_provider.dart # Firestore integration logic
│   └── app_state_provider.dart # App state management
├── screens/
│   ├── add_subject_screen.dart    # Add new subject form
│   ├── subject_list_screen.dart   # Display all subjects
│   └── summary_screen.dart        # Analytics & summary
└── theme/
    └── app_theme.dart       # Light/Dark theme definitions
```

---

## 🔑 Key Components

### Subject Model
```dart
class Subject {
  final String name;
  final double _mark;  // Private field

  String get grade {
    if (_mark >= 80) return 'A';
    if (_mark >= 65) return 'B';
    if (_mark >= 50) return 'C';
    return 'F';
  }

  double get mark => _mark;
}
```

### SubjectProvider (State Management)
- **addSubject()** - Saves subject to Firestore
- **loadSubjects()** - Loads subjects from Firestore
- **deleteSubject()** - Removes subject from Firestore
- **passingSubjects** - Filters subjects with grade ≠ 'F'
- **failingSubjects** - Filters subjects with grade 'F'
- **averageMark** - Calculates average of all marks
- **overallGrade** - Calculates overall grade

---

## 🏗️ Firestore Database Schema

### Collection: `subjects`

```json
{
  "name": "Mathematics",
  "mark": 85.5,
  "grade": "A",
  "createdAt": "2024-06-27T10:30:00Z"
}
```

---

## 💻 Usage Guide

### Adding a Subject
1. Click the **"Add Subject"** tab in the bottom navigation
2. Enter the subject name (e.g., Mathematics)
3. Enter marks between 0-100
4. Click **"ADD SUBJECT"** button
5. Success message appears and data syncs to Firestore

### Viewing Subjects
1. Go to **"Subject List"** tab
2. See all your subjects with marks and grades
3. Swipe left to delete any subject

### View Summary
1. Navigate to **"Summary"** tab
2. See overall statistics including:
   - Average mark
   - Overall grade
   - Total subjects
   - Passing/Failing count

### Theme Toggle
- Click the theme icon in the top-right corner to switch between light and dark modes

---

## 📚 Dependencies

```yaml
flutter: SDK
provider: ^6.1.5+1           # State management
firebase_core: ^4.11.0       # Firebase initialization
firebase_firestore: ^5.0.0   # Cloud database
cupertino_icons: ^1.0.8      # iOS-style icons
flutter_lints: ^6.0.0        # Code linting
```

---

## 🔐 Firebase Setup Steps

### Step 1: Create Firestore Database
```
Firebase Console → Create Database → Start in Test Mode
```

### Step 2: Create Collection
```
Collection Name: subjects
```

### Step 3: Add Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /subjects/{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### Step 4: Enable Authentication (Optional)
```
Firebase Console → Authentication → Enable Email/Password Sign-in
```

---

## 🎨 Theming

The app includes pre-configured light and dark themes:

**Light Theme:**
- Primary Color: Blue
- Background: White
- Text: Dark Gray

**Dark Theme:**
- Primary Color: Light Blue
- Background: Dark Gray
- Text: White

Customize themes in `theme/app_theme.dart`

---

## 🐛 Troubleshooting

### Firebase Connection Issues
```bash
# Ensure Firebase is initialized
flutter clean
flutter pub get
flutter run
```

### Firestore Data Not Syncing
- Check Firebase credentials in `firebase_options.dart`
- Verify Firestore rules allow read/write
- Check internet connection

### Build Errors
```bash
# Clear build artifacts
flutter clean
flutter pub get
flutter pub upgrade
```

---

## 🚀 Performance Optimization

- **Lazy Loading** - Subjects loaded on app start
- **Efficient State Management** - Provider pattern reduces rebuilds
- **Cloud Caching** - Firestore handles data caching
- **Optimized Queries** - Only required fields fetched

---

## 📝 Code Conventions

- **Naming** - Dart style guide followed
- **Comments** - Clear documentation for complex logic
- **Error Handling** - Try-catch blocks for all async operations
- **Validation** - Form validation before submission

---

## 🤝 Contributing

We welcome contributions! Here's how to contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/YourFeature`)
3. Commit changes (`git commit -m 'Add YourFeature'`)
4. Push to branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

### Coding Standards
- Follow Dart style guide
- Write meaningful commit messages
- Add comments for complex logic
- Test thoroughly before submitting

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Student Grade Tracker**  
A Flutter learning project showcasing Firebase integration and state management.

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for reliable cloud services
- Provider package for state management
- Open-source community for inspiration

---

## 📞 Support

For issues, questions, or suggestions:
- Open an [Issue](../../issues) on GitHub
- Check existing [Discussions](../../discussions)
- Email: support@studentgradetracker.com

---

## 📈 Roadmap

- [ ] User authentication with Firebase Auth
- [ ] Multi-user support
- [ ] Export grades as PDF
- [ ] Grade prediction based on history
- [ ] GPA calculator
- [ ] Push notifications for updates
- [ ] Offline functionality
- [ ] Cloud backup & restore

---

**Made with ❤️ using Flutter**

Last Updated: June 27, 2024  
Version: 1.0.0
