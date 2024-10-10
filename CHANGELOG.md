
## [1.1.0] - Feat Download

- add function to download file
- update version dio + http_mock_adapter

## [1.0.2] - Improved Data Serialization with Error Handling

- Updated logging behavior to attempt serialization of request data using `JsonEncoder`. If serialization fails (e.g., when handling `FormData`), an error message is logged instead of causing a crash. This ensures more robust logging for different types of request data.


## [1.0.1] - Fix mock load

- Change logic to await the load mock asset in mock requests

## [1.0.0] - Stable version

- Refactor to contain only the essentials;
- Make ApiManager injectable into datasources;
- Eliminate any business logic from the library;
- Extend Dio to provide base functions and parameters;
- Allow mocking Response instead of just the data attribute;
- Works with mocks in dynamic directories;
- Adds logic for caching request data.

## [0.0.20] - Add mockDelayInSeconds

- Add a parameter mockDelayInSeconds to Mock Requests;

## [0.0.19] - Update lib

- DIO dependency updated to 5.0.3;

## [0.0.18] - Fix Dio update

- Fix: remove update dio;

## [0.0.17] - Fix http export

- Fix: remove http config export;

## [0.0.16] - Update lib

- DIO dependency update;

## [0.0.15] - Add cacheExpiresIn field

- Added adding field cacheExpiresIn

## [0.0.14] - Update Lib

- DIO dependency update;
- Adding personality error return in mock.
- Fix: Now when a request is made a notify is send to all listeners

## [0.0.13] - Fix response notify

- Fix: Now when a request is made a notification is sent to all listeners.

## [0.0.12] - Refactor randomError

- BREAKING CHANGE: randomError is now part of Endpoint class.

## [0.0.11] - Update package

- Fix default error message not sent to InternalError

## [0.0.10] - Update package

- Added randomError parameter on requestApi for mock environment;
- Fix typos

## [0.0.9] - Update package

- Update Random Mock Error;

## [0.0.8] - Update package

- Delete CheckConnectionInterceptor;

## [0.0.7] - Update ConnectionChecker

- Update ConnectionChecker;

## [0.0.6] - Update packege

- Addition export SSL Pinning;
- Addition of parameters received by the error;

## [0.0.5] - Update mock

- Addition dynamic mock mapping;
- Addition the optional random MOCK;

## [0.0.4] - Update package

- Apply flutter format;
- Add documentation to package;
- Leaving the public repository for contributions;
- Update links to documentation;
- Removing unnecessary imports;
- Rename init Config;
- Addition searches for files in the `packages` folder;
- Bug fix in mock strategy;

## [0.0.3] - Update documentation

- Update links to documentation;

## [0.0.2] - Add retry policy

- Create in Retry policy;
- Adjustment in Retry policy;

## [0.0.1] - Creating packages

- Componentization of the network layer;
- Configuration of the base url;
- Creation of interceptors;
- Adjustments for urlBase binding;
- Package creation;
- Creation of functions for configurations;
- Addition of interface for SSLPinning injection;
- Addition mock calls;
- Simplify call with DIO;
