Паттерн Декоратор (Decorator) относится к структурным паттернам проектирования и предназначен для динамического добавления нового функционала объектам. Он позволяет оборачивать объекты в различные декораторы, которые могут добавлять новое поведение без изменения основной структуры объекта.

  

Вот пример использования паттерна Декоратор на языке Swift:

  

// Базовый протокол для компонента

protocol Component {

    func operation() -> String

}

  

// Конкретный компонент

class ConcreteComponent: Component {

    func operation() -> String {

        return "Основная операция"

    }

}

  

// Базовый декоратор

class Decorator: Component {

    private let component: Component

    init(component: Component) {

        self.component = component

    }

    func operation() -> String {

        return component.operation()

    }

}

  

// Конкретный декоратор 1

class ConcreteDecorator1: Decorator {

    override func operation() -> String {

        return "Дополнительная операция 1, " + super.operation()

    }

}

  

// Конкретный декоратор 2

class ConcreteDecorator2: Decorator {

    override func operation() -> String {

        return "Дополнительная операция 2, " + super.operation()

    }

}

  

// Пример использования

let component: Component = ConcreteComponent()

let decorator1 = ConcreteDecorator1(component: component)

let decorator2 = ConcreteDecorator2(component: decorator1)

  

print(decorator2.operation()) // Выводит: "Дополнительная операция 2, Дополнительная операция 1, Основная операция"

  

В данном примере у нас есть базовый протокол `Component`, определяющий операцию `operation()`. Класс `ConcreteComponent` - это конкретная реализация этого протокола. Затем у нас есть базовый класс `Decorator`, который также реализует протокол `Component` и имеет ссылку на объект типа `Component`. Конкретные декораторы `ConcreteDecorator1` и `ConcreteDecorator2` наследуются от `Decorator` и добавляют свое дополнительное поведение к операции.

  

В примере мы создаем объект `component` типа `ConcreteComponent`, затем оборачиваем его в `ConcreteDecorator1`, а затем в `ConcreteDecorator2`. Вызов `operation()` на объекте `decorator2` приводит к выполнению операций всех декораторов и базового компонента.

  

Паттерн Декоратор позволяет добавлять новую функциональность объектам на лету, не изменяя их основной код и структуру. Это обеспечивает гибкость и расширяемость системы.