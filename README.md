
# ServXFactory - KSP Machine 

This project is a **Flutter-based mobile application** designed to provide an innovative service platform for **industrial companies**. The application serves as a hub for managing various aspects of the business, including product information, service requests, and real-time communication between users and company personnel. It is currently **under development**.

---

## 📸 Screenshots

### Home Screen (Turkish)
[![Home Screen TR](./screenshots/home_tr.png)](https://files.oaiusercontent.com/file-M85Zsd6zj44c3GdMaYGA88?se=2024-11-25T13%3A13%3A38Z&sp=r&sv=2024-08-04&sr=b&rscc=max-age%3D299%2C%20immutable%2C%20private&rscd=attachment%3B%20filename%3Dimage.png&sig=RkvVYeJJuSf57GMaagqxmwMisr1/czoUqGUhVusnz%2BM%3D)

### Language Selector
![Language Selector](./screenshots/language_selector.png)

### Home Screen (English)
![Home Screen EN](./screenshots/home_en.png)

### Login Screen
![Login Screen](./screenshots/login.png)

### Personnel Dashboard
![Personnel Dashboard](./screenshots/personnel_dashboard.png)

### About Us Page
![About Us](./screenshots/about_us.png)

### Products Page
![Products Page](./screenshots/products_page.png)

---

## 🎯 Features

### Current Features:
- **Multilingual Support**:
  - Languages supported: Turkish (TR), English (EN), German (DE), Russian (RU), French (FR), Spanish (ES).
  - Easily switch languages from the dropdown in the header.
- **Role-Specific Dashboards**:
  - Separate interfaces for **users** and **personnel**.
  - Dedicated access to tasks, reports, machine data, and more.
- **Information Pages**:
  - About Us
  - Products
  - Latest Updates
  - Media Center
  - Error Support System
  - Blogs
  - References
  - Contact Information
- **Login and Registration**:
  - Users and personnel can log in to access personalized dashboards.
- **Responsive Design**:
  - Optimized for mobile devices.

### Features in Development:
- **Integration with Industrial Machines**:
  - Real-time data monitoring and management.
- **Task Assignment System**:
  - Role-based task delegation for personnel.
- **Push Notifications**:
  - Stay updated with alerts on tasks and updates.
- **Service Requests**:
  - Submit and manage service tickets for machine maintenance.
- **Data Analytics**:
  - Visualize performance metrics and reports.

---

## 🚀 Technologies Used

- **Framework**: [Flutter](https://flutter.dev/)
- **Programming Language**: Dart
- **UI Library**: Material Design
- **Icons**: FontAwesome Icons, Material Icons
- **State Management**: Provider
- **Localization**: `intl` package for multilingual support
- **Backend (planned)**: Firebase integration for authentication and data management

---

## 📂 Project Structure

```plaintext
lib/
├── main.dart         # Entry point of the application
├── pages/            # Application pages (Home, Login, About Us, etc.)
├── widgets/          # Reusable UI components
├── providers/        # State management providers
├── app/              # Theme, localization, and global configuration
└── generated/        # Auto-generated localization files
```

---

## 📖 How to Run

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/ServXFactory.git
   cd ServXFactory
   ```
2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the Application:**
   ```bash
   flutter run
   ```
4. **Build APK (Optional):**
   ```bash
   flutter build apk --split-per-abi
   ```

---

## 🌐 Localization
This app uses the `intl` package to support multiple languages. You can add new languages by updating the localization files in the `generated/` directory.

---

## 📌 To-Do List
- [ ] Integrate Firebase for user authentication and data.
- [ ] Implement service request management.
- [ ] Add real-time push notifications.
- [ ] Develop detailed analytics dashboards.
- [ ] Optimize UI for tablets.

---

## 🤝 Contributing
We welcome contributions! If you want to contribute:
1. Fork the repository.
2. Create a feature branch.
3. Commit your changes.
4. Submit a pull request.

---

## 📧 Contact
For any inquiries or issues, please contact:
- **Developer**: Mehmet Çobanoğlu
- **Email**: mehmett_ceng@hotmail.com
- **GitHub**: [MEHMETCOBANOGLU](https://github.com/MEHMETCOBANOGLU)

---

**Note:** This project is in the development phase. Features and designs are subject to change.

