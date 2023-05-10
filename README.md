# Progress Bar

A Simple Custom Progress Bar.

## Installation 💻

Clone the package repository:

```
git clone https://github.com/jeconiel12/progress_bar.git
```
   
Add `progress_bar` to your `pubspec.yaml`:

```yaml
dependencies:
  progress_bar: // Fill with package local path
```

Install it:

```sh
flutter packages get
```

---

## Usage

Initialize the ProgressBar with required values, it will create a default progress step with default value.

```dart
ProgressBar(
   totalSteps: 4,
   currentStep: 2,
)
```

The above code will create a Progress Bar as shown below:

![image](https://github.com/jeconiel12/progress_bar/assets/106535032/67b3cdb4-c615-4db7-ad28-1fe098e7bc54)

## Parameters

| Parameter | Required | Description |
| --- | --- | --- |
| `totalSteps` | Yes | The total number of steps in the progress bar. |
| `currentStep` | No | The index of current step in the progress bar. Default is 0. |
| `indicatorColor` | No | The color of the progress bar indicator. Default is `Colors.orange`. |
| `backgroundColor` | No | The background color of the progress bar. Default is `Colors.grey`. |
| `barSpacerColor` | No | The color of space between bars. To get the intended purpose, fill it with the color that matches the parent of `ProgressBar` background. If the value is `null`, it will use the `Theme` scaffold background color. |
| `duration` | No | The duration of the animation that updates the progress bar. Default is `Duration(milliseconds: 500)`. |
| `curve` | No | The curve used for the animation that updates the progress bar. Default is `Curves.linear`. |
| `height` | No | The height of the progress bar. Default is `20`. |

## Running Demo

![image](https://github.com/jeconiel12/progress_bar/assets/106535032/cb045f29-b21e-46e7-8840-526824f4c132)


Navigate to the example folder:

 ```
 cd progress_bar/example
 ```

Install the package dependencies:

 ```
 flutter pub get
 ```

Run the example app:

 ```
 flutter run
 ```
   
## Running Tests 🧪

To run all widget tests:

```sh
flutter test
```
