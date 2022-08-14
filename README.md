# Temper

`Temper` is a demo project to show only the list of shifts.

## Requirements

- XCode: 13.1
- Swift tool version: 5
- Minimum iOS Version: 15.0
- Dependency: SnapshotTesting for screenshot testing different views.

## Tech-Stack

- Swift: 5
- Swift concurrency: asyn/await
- MVVM, Coordinator, Repository Pattern
- XCTest (unit tests, UI tests)

## Description

The application has a MainCoordinatorView to handle all navigation. This is the entry point. All views use MVVM pattern so every view is backed by ViewModel. 

There are some reusable components in Components folder. All the scenes (login, shifts, etc.) can be found in Scene folder. 

For networking Services package is used. It is based on Repository pattern. 

For getting users location LocationProvider class is used that confirms to LocationProviderProtocol. 

Most of the ViewModels only contain data right now but ShiftListViewViewModel contain logic to fetch and manipulate shifts data.
