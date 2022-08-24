# client-iOS  
Anonymity Client side


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
- `To be finished.`  


## Download  
- `git clone --recurse-submodules https://github.com/Steve-Xyh/client-iOS.git`  


## Installation  
- `To be finished.`  

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
**Developed by [Steve X](https://github.com/Steve-Xyh/client-iOS) © 2017 - 2022**  
