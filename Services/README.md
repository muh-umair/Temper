# Services

`Services` is a simple library for all the network related operations. It contains required repositories for the main Temper app to access data from different sources e.g. network.

## Requirements

- XCode: 13.1
- Swift tool version: 5.5
- Minimum iOS Version: 15.0
- Minimum MacOS Version: 12.0
- Dependency: No 3rd party dependencies

## Tech-Stack

- Swift: 5
- Swift concurrency: asyn/await
- Repository pattern
- XCTest

## Usage

Package contain `ShiftRepository` to perform different actions on `Shift` data. 

### ShiftRepository

Create new instance and perform the required operation. For example to fetch shifts for a date following code can be used
```swift
let request = FetchShiftsRequest(date: Date())
let repository = ShiftRepository(networking: Networking.shared)
let response: FetchShiftsResponse? = try? await repository.fetchShifts(request)
```
