# MdEditor

**MdEditor** - это простой текстовый редактор с поддержкой язык разметки Markdown.

В проекте используются следующие шаблоны проектирования:
- DI
- CleanSwift

Для верстки экранов используется: 
- PinLayout

## Getting Started

- Установите менеджер недостающих пакетов для macOS Homebrew с помощью команды в терминале 
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- Скачайте и установите SwiftLint - утилиту для автоматической проверки Swift-кода
```
brew install swiftlint
```
- Скачайте и установите SwiftGen - инструмент для автоматической кодогенерации ресурсов проекта в Swift-код, чтобы сделать их типобезопасными в использовании
```
brew install swiftgen
```

- Клонируйте репозиторий
```
cd ~/Developer
git clone https://github.com/ChervotkinaTeam/MdEditor.git
cd ./MdEditor
xed .
```

- Запустите файл MdEditor.xcodeproj

## Features


## Требования

- Написано на Swift 5;
- Поддерживается версия iOS 14;
- Необходим Xcode 14+;
- SwiftLint;
- SwiftGen.
