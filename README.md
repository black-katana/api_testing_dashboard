# api_testing_dashboard

A new Flutter project for displaying api testing results.

## TODO

- [x] List view
- [ ] Fetch json data and display it.
- [ ] Polish each section
- [ ] [Separate biz logic from UI](https://github.com/felangel/bloc)

## Setting up flutter

- [For ios siumlator](https://flutter.dev/docs/get-started/install/macos)
- [web](https://flutter.dev/docs/get-started/web)
- [android](https://developer.android.com/studio/run/emulator-acceleration#vm-mac)
- [tutorial](https://flutter.dev/docs/get-started/codelab)

## local setup

```yaml
# To run the project
flutter channel beta
flutter upgrade
flutter config --enable-web
flutter run -d chrome

# To install dependencies
flutter pub get
# this will fetch extra libs
# https://pub.dev/packages/shared_preferences
# https://pub.dev/packages/http

# To build a release
# https://flutter.dev/docs/get-started/web
flutter build web
```

## Resources

A few resources to get you started with a flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Flutter layout](https://flutter.dev/docs/development/ui/layout)

API status examples

- [github](https://www.githubstatus.com/#past-incidents)
- [sendgrid](https://status.sendgrid.com/)