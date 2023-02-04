# WeBuy Food - Flutter Mobile Application

WeBuy Food is a flutter mobile application that helps to purchase food items online. This app has been built using the flutter/dart framework and implements the stripe payment gateway for secure online transactions. The app utilizes riverpod for efficient state management. 
## Features
- Create user with name, email and password
- Login with Email and Password
- Reset password
- Sign in with Google
- Listing Food items
- Viewing profile info
- Switching theme (system, dark or light).
- Sign out
- Add to cart by drag and drop
- Remove from cart
- Increase/decrease quantity item
- Payment with Credit Card
- App icon
- Splash screen in dark/light theme
## Running locally
- To run this app locally on your machine, you firstly need to clone this repo by running this command in your terminal:
```bash
git clone https://github.com/aimelive/webuy_app
```
- Navigate to `webuy_app`directory and open it in your favorite code editor like vs code or android studio
```bash
cd webuy_app
```
To open in VS code run `code .`
- In the `assets/dotenv` folder, create `.env` file and fill out all variables as mentioned in `assets/dotenv/.env.example`
- Next, Get all project dependencies by running this command
```bash
flutter pub get
```
- Finally, run below command in your terminal to launch the project in your emulator, simulator or physical device.
```bash
flutter run --release
```
- N.B: You can also run in debug mode by running `flutter run` but you may not able be able to sign in with google

### Pre-requisites
Running this project locally requires the following pre-requisites
- Flutter SDK
- Stripe Account with access to publishable key and secret key
- Android Studio for Windows/Linux users
- XCode for Mac users
## Demoing
### Simulator Screenshots
- [Dark Theme](https://photos.app.goo.gl/8mWnPcKgAMQCcVBJ8)
- [Light Theme](https://photos.app.goo.gl/xtef6LHBbvzWsm3e9)

### Watch demo video here
- Watch it on [YouTube](https://www.youtube.com/watch?v=3UCcQSjcPMM) via here
### Download APK 
- Get APK file from this zip folder on [Google Drive](https://drive.google.com/file/d/1xC2J9yA0lGIhmDVPaIX22CgSxoAi9f3w/view) together with screenshots and demo video files
### Technologies
- Flutter/dart
- Firebase for user authentication services
- Google Sign In
- Riverpod for state management
- Stripe for payments
### Platform
- Android
- iOS
### UI References

- Authentication Page UI from this [Figma file](https://www.patreon.com/posts/figma-design-ui-68844937) by [Watery Desert](https://github.com/watery-desert/)
- Home Page UI from this [Figma file](https://www.figma.com/file/lIEZJxjpcT8hi9Kkn0MjmA/Food-Yum-Mobile-App-(Community)?node-id=0%3A1) by [Angga Risky](https://www.youtube.com/anggarisky)

### Author
- [Aime Ndayambaje](https://github.com/aimelive)
