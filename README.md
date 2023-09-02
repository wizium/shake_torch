**GitHub README for Flutter Shake to Torch and SOS App with Switches**

# Shake to Torch and SOS Flutter App

## Overview

Welcome to the Shake to Torch and SOS Flutter app! This feature-rich app allows users to control the device's torch (flashlight) by shaking the phone and includes an SOS functionality for emergencies. To enhance user control, we've added two switches: one to toggle shake detection and another to activate SOS mode. The app also follows an Android 12-like dynamic adaptive theme for a modern look and feel. We've used the following dependencies to build this versatile app:

1. **shake:** Version 1.0.1
   - Detects shake gestures to activate the torch by shaking the device.

2. **torch_controller:** Version 2.0.1
   - Manages the device's torch, enabling users to turn it on and off through shaking.

3. **flutter_background_service:** Version 5.0.1
   - Ensures the shake detection works even when the app is terminated, providing a seamless experience.

4. **dynamic_colors:** Version (Your preferred version)
   - Provides an Android 12-like dynamic adaptive theme for a visually appealing user interface.

## Getting Started

To get started with the Shake to Torch and SOS Flutter app featuring toggle switches, follow these steps:

1. Clone this repository to your local machine.

```bash
git clone <repository_url>
```

2. Navigate to the project directory.

```bash
cd shake_to_torch_sos_flutter_app
```

3. Install the dependencies using Flutter's package manager.

```bash
flutter pub get
```

4. Run the app on your desired device or emulator.

```bash
flutter run
```

## Usage

This app offers two essential functionalities and user-controlled switches:

### Shake to Torch

1. Launch the app on your device.

2. Toggle the "Shake Detection" switch to activate or deactivate the torch's shake-based control.

3. Shake your device gently to activate or deactivate the torch, depending on the switch's state.

### SOS Functionality

1. Toggle the "SOS Mode" switch to enable or disable the SOS functionality.

2. In case of an emergency, press the SOS switch to trigger the SOS functionality. The device's torch will start emitting SOS signals.

### Android 12-Like Dynamic Adaptive Theme

The app's theme adapts dynamically, providing a user interface experience similar to Android 12's theming. The theme changes based on system settings, creating a cohesive and modern look.

## Customization

You can customize this app to suit your preferences or extend its functionality:

- **Sensitivity:** Adjust the shake sensitivity within the 'shake' package settings to control how vigorously users need to shake the device to activate the torch.

- **SOS Configuration:** Customize the SOS functionality, such as the pattern and duration of SOS signals, to better suit your needs.

- **UI Enhancement:** Enhance the app's user interface by adding additional features or visual elements to make it more engaging.

## Feedback and Contributions

We value your feedback, bug reports, and contributions to improve this app. If you have any suggestions, ideas, or encounter issues, please don't hesitate to create issues or pull requests in this repository.

We're excited to see how you can expand and improve upon this Shake to Torch and SOS app!

**Enjoy Shaking, Staying Safe, and Lighting Up the Dark with Full Control!** 💡

If you have any questions or need further assistance with your Flutter app development, feel free to reach out. Happy coding!