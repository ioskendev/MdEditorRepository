# MdEditorRepository
This is the central repository for the MdEditor, a simple yet powerful Markdown editor designed for writing and previewing markdown documents. It's hosts the source code for MdEditor and its SPM, an intuitive Markdown editor for iOS that lets users create and manage Markdown documents with ease on their iPhone and iPad.

## Overview

MdEditor for iOS is a versatile and user-friendly app designed to offer a delightful experience for writing Markdown. It integrates a variety of features that cater to both novice and experienced Markdown users, enabling them to craft, preview, and export their Markdown documents directly from their iOS devices.


## Architecture
MdEditor is built on CleanSwift architecture pattern. 

Clean Swift (also known as the VIP architecture) is an architecture pattern for iOS apps that organizes code into distinct layers with well-defined responsibilities, which helps in making the code more testable, maintainable, and scalable. The three key components of Clean Swift are:

- View Controller (V): Handles the display of the user interface and user interactions. It sends user events to the Interactor and receives ViewModel from the Presenter to update the UI.
- Interactor (I): Contains the business logic of the application. It receives requests from the View Controller, processes them (including communicating with models or workers), and sends the results to the Presenter.
- Presenter (P): Transforms raw data received from the Interactor into displayable ViewModel and passes it back to the View Controller for presentation.

The data flow in Clean Swift is unidirectional, making it easier to trace and debug. The separation of concerns facilitated by this architecture allows for more modular code and supports the Single Responsibility Principle, leading to cleaner and more organized codebases for iOS applications.

## Features
MdEditor comes with a range of handy features that streamline the markdown writing process:

- Live preview of Markdown content
- Syntax highlighting for code blocks
- Support for standard Markdown as well as extended syntax elements
- Keyboard shortcuts for common formatting actions
- Exporting Markdown to other formats such as HTML or PDF
- Dark and light themes for comfortable writing

## Getting Started
To start using MdEditor, follow the simple steps below to get it up and running on your machine.

### Requirements
Before you install MdEditor, ensure your system meets the following requirements:
- Operating System: macOS X 10.14 or later
- Runtime Environment: Xcode 15.1 or higher
- Additional Dependencies: tuist, swiftgen.

### Installation
Follow these steps to install MdEditor:

1. **Clone the repository:**
    git@github.com:ioskendev/MdEditorRepository.git
2. **Navigate to the project directory in console:**
```
cd ./MdEditorRepository/Progect
```
3. **Run:**
```
tuist generate
```
   
   After these steps, MdEditor should be running on your machine and you can build the project.

---

We hope you enjoy using MdEditor project, and we welcome any feedback, contributions, or bug reports in our issues section.

## Developers(ioskendev team):
- Yuri Volegov (iosken - teamlead)
- Maxim Alexeev
- Alexey Turulin
- Dinar Khakimov
- Rinat
