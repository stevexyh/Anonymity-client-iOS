# Anonymity client-iOS
Anonymity iOS client side. This is an end-to-end encryption chat app for partial fulfillment of Steve's MSc Project and the degree of MSc Cyber Security.


## Files  
```  
.
├── README.md
├── imgs
│   ├── ver0.1-sketch/...
│   ├── ver0.2-sketch/...
│   └── ver0.3-sketch/...
├── screenshots-ver0.2.md
└── src
    └── Anonymity
        ├── Anonymity.xcodeproj/...
        ├── Playgrounds
        │   └── Cryptography.playground/...
        ├── Shared
        │   ├── Anonymity.xcdatamodeld/...
        │   ├── AnonymityApp.swift
        │   ├── Assets.xcassets/...
        │   ├── DataServices
        │   │   ├── ChatDataService.swift
        │   │   ├── ContactDataService.swift
        │   │   ├── FileDataService.swift
        │   │   ├── MessageDataService.swift
        │   │   ├── PublicKeyDataService.swift
        │   │   └── UserDataService.swift
        │   ├── Extensions
        │   │   ├── Dictionary.swift
        │   │   └── UIApplication.swift
        │   ├── GoogleService-Info.plist
        │   ├── Managers
        │   │   ├── CryptoManager.swift
        │   │   ├── DicKeyManager.swift
        │   │   ├── FirebaseManager.swift
        │   │   └── UserAuthManager.swift
        │   ├── Models
        │   │   ├── Chat.swift
        │   │   ├── Contact.swift
        │   │   ├── File.swift
        │   │   ├── Message.swift
        │   │   └── User.swift
        │   ├── Persistence.swift
        │   ├── ViewModels
        │   │   ├── ChatViewModel.swift
        │   │   ├── ContactsViewModel.swift
        │   │   └── MessageListViewModel.swift
        │   └── Views
        │       ├── Chat
        │       │   ├── ChatView.swift
        │       │   ├── DownloadProgressView.swift
        │       │   └── MessageBubbleSubView.swift
        │       ├── Components
        │       │   ├── AvatarView.swift
        │       │   ├── ClipboardSubView.swift
        │       │   ├── ContactsAddSheetView.swift
        │       │   └── OnlineStatusView.swift
        │       ├── ContactsView.swift
        │       ├── ContentView.swift
        │       ├── HomePageView.swift
        │       ├── LoginView.swift
        │       ├── MessageListView.swift
        │       ├── SettingsView.swift
        │       └── UserProfileView.swift
        ├── Tests iOS
        │   ├── Tests_iOS.swift
        │   └── Tests_iOSLaunchTests.swift
        ├── Tests macOS
        │   ├── Tests_macOS.swift
        │   └── Tests_macOSLaunchTests.swift
        ├── UnitTests iOS
        │   ├── DataServices_Tests
        │   │   ├── ChatDataService_Tests.swift
        │   │   └── PublicKeyDataService_Tests.swift
        │   ├── Managers_Tests
        │   │   └── CryotoManager_Tests.swift
        │   └── UnitTests_iOS.swift
        └── macOS
            └── macOS.entitlements

45 directories, 84 files
```  

## Environment
- `Swift 5.0`
- `macOS 12.4`
- `iOS 15.5`

## Usage  
- Register app on Google Firebase
- Download `GoogleService-Info.plist`
- Add file `GoogleService-Info.plist` in project
- Build project using Xcode
- Run app on a simulator


## Download  
- `git clone --recurse-submodules https://github.com/Steve-Xyh/Anonymity-client-iOS.git`  


## Installation  
- Build & run using Xcode

---

## TODO List
### UI
- [x] main page
- [x] chat page
- [x] user profile page
- [x] settings page
- [x] contacts page
- [x] sign in page

### Logic
- [x] sign in
- [x] add contacts
- [x] tmp VM Database
- [x] firebase
- [x] auth
- [x] communication
- [x] encryption
    - [x] ECC key gen & publish
    - [x] AES key distribution
    - [x] AES symmetric encryption & decryption
- [x] file transfer
    - [x] file encryption & decryption

### Learn Next If Possible
- [x] Unit Test
- [ ] Dependency Injection

### Dissertation
- [x] Abstract
- [x] Statement of Originality
- [x] Acknowledgements
- [x] TOC
- [x] 1. Introduction
- [x] 2. Literature Review & Techniques
    - [x] 2.1 MVVM Architecture
    - [x] 2.2 Swift
    - [x] 2.3 Cryptography Algorithms
    - [x] 2.4 Google Firebase
- [x] 3. Project Plan
- [x] 4. Sofeware Design
    - [x] 4.1 Module Layers
    - [x] 4.2 Data Models
    - [x] 4.3 Views
    <!-- - [ ] 4.4 Use Case Diagram -->
    <!-- - [ ] 4.5 Data Flow Diagram -->
- [x] 5. Implementation
    - [x] 5.1 Project Structure
    - [x] 5.2 Database Fields
    - [x] 5.3 User Services
    - [x] 5.4 Contacts Services
    - [x] 5.5 Communications
    - [x] 5.6 Encryption
- [x] 6. Unit Tests
    - [x] 6.1 Data Services Tests
    - [x] 6.2 Managers Tests
- [x] 7. Experiments & Stress Tests
    - [x] 7.1	Stress Tests of Key Generation
    - [x] 7.2	Stress Tests of Encryption & Decryption
- [x] 8. Conclusion
    - [x] 8.1 Functions implemented
    - [x] 8.2 Project Deficiencies & Future Improvements
- [x] I. References
- [x] II. Appendix

---
## Screenshots
### Version 0.2-Sketch
#### 1. Home Page
![](./imgs/ver0.2-sketch/img_ver0.2_1.png)

#### 2. Chat Page
![](./imgs/ver0.2-sketch/img_ver0.2_2.png)

#### 3. User Profile Page
![](./imgs/ver0.2-sketch/img_ver0.2_3.png)

#### 4. Contacts Page
![](./imgs/ver0.2-sketch/img_ver0.2_4.png)

#### 5. Settings Page
![](./imgs/ver0.2-sketch/img_ver0.2_5.png)

---  
**Developed by [Steve X](https://github.com/Steve-Xyh/Anonymity-client-iOS.git) © 2017 - 2022**  
