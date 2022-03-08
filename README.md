<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

<p align="center">
   <img src="https://user-images.githubusercontent.com/66264766/157141908-c8a760f7-6e13-4046-90f6-9243f698062b.png" alt="adaptable" width="500"/>
</p>



<p align="center">
  <img alt="Languages" src="https://img.shields.io/github/languages/count/Sthaynny/adaptable_screen?color=%235963C5" />
  <img alt="lastcommit" src="https://img.shields.io/github/last-commit/Sthaynny/adaptable_screen?color=%235761C3" />
  <img alt="Issues" src="https://img.shields.io/github/issues/Sthaynny/adaptable_screen?color=%235965E0">

  </a>
</p>

<p>
  
The plug-in built to simplify internet requests.
  
</p>

## Getting started

Depend on it

Add this to your package's pubspec.yaml file:


```
  dependencies:
       popwork: ^0.0.1
```


Install it
You can install packages from the command line:

with Flutter:

```
  $ flutter pub get
```

## Usage

It is possible to perform an initial configuration using the `Popwork.config` function. This function should be used when starting to build your application with some custom settings.

```dart
void main() {
  await Popwork.config(baseUrl: "https:www.example.com");
  runApp(const MyApp());
}
```

Where you can add a base url or just not configure and pass the url in `Enpoint`. For more information visit the [Contribution Guide](https://github.com/isthaynny/popwork/blob/main/docs//endpoint.md)

```dart
final endpoint = Endpoint(
  suffixPath: 'https:www.example.com'
);
```

The `suffixPath` can be used this way or being concatenated with a base url that is configured in the execution of the application, it doesn't have to be at the beginning but it is good to avoid errors.

```dart
void main() {
  await Popwork.config(baseUrl: "https:www.example.com");
  runApp(const MyApp());
}
```

---

```dart
final endpoint = Endpoint(
  suffixPath: 'suffix/path'
);
```

`result path: https:www.example.com/suffix/path`

Some other base settings can be done like setting intectors, setting default header, etc. More details in [Popwork config Guide](https://github.com/isthaynny/popwork/blob/main/docs/popwork_config.md)

---

When the split settings are completed, just call the api:

```dart
final result = await ApiManager.request();

```

or

```dart

final endpoint = Endpoint(
  suffixPath: 'suffix/path'
);

final result = await ApiManager.request(
  endpoint: endpoint,
);

```

If you want to see a usage in a simple way, go to `/example` folder.

## Documentation

- [PopWork Config](https://github.com/isthaynny/popwork/blob/main/docs/popwork_config.md)
- [Enpoint](https://github.com/isthaynny/popwork/blob/main/docs/endpoint.md);
- [Working with Mocked Requests](https://github.com/isthaynny/popwork/blob/main/docs/mock.md)
- [Custom error mapping](https://github.com/isthaynny/popwork/blob/main/docs/mapped_api_error.md)
- [Raw response notifier](https://github.com/isthaynny/popwork/blob/main/docs/raw_response_notifier.md)


## Additional information

For contributes:

- Fork this repository;
- Create a new branch to develop your feature: `git checkout -b my-feature`;
- Commit your changes: `git commit -m 'feat: my new feature'`;
- Push to your branch: `git push origin my-feature`.
- Open a pull request for your code to be evaluated.
- For more information visit the [Contribution Guide](https://github.com/isthaynny/popwork/tree/main/.github/contributing.md)

To help maintain the chosen pattern we also create a file which is called before every commit. This file will format and pinpoint (if present) errors in the codestyle of your code. To enable this you must first copy it to git's hooks folder. If you are developing on macOS, go to the root of the project and run the command below:

```
cp pre-commit .git/hooks/pre-commit
```

After this step, it is necessary to give permission for the file to be executed. Just follow the following command:

```
chmod +x .git/hooks/pre-commit
```
