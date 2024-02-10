Паттерн Mediator (Посредник) позволяет упростить взаимодействие между объектами, снижая их зависимости друг от друга. Суть паттерна заключается в создании объекта-посредника, который централизует взаимодействие между различными компонентами системы.

  

Давайте рассмотрим пример использования паттерна Mediator на языке Swift с использованием Xcode. Допустим, у нас есть система чата, состоящая из нескольких пользователей (User) и посредника (ChatMediator). Каждый пользователь может отправлять сообщения другим пользователям через посредника.

  

// Протокол для общего поведения пользователей

protocol User {

    var name: String { get }

    func sendMessage(message: String)

    func receiveMessage(message: String)

}

  

// Конкретный пользователь

class ConcreteUser: User {

    let name: String

    let mediator: ChatMediator

    init(name: String, mediator: ChatMediator) {

        self.name = name

        self.mediator = mediator

    }

    func sendMessage(message: String) {

        mediator.sendMessage(message: message, sender: self)

    }

    func receiveMessage(message: String) {

        print("\(name) received message: \(message)")

    }

}

  

// Посредник

class ChatMediator {

    private var users = [User]()

    func addUser(user: User) {

        users.append(user)

    }

    func sendMessage(message: String, sender: User) {

        for user in users {

            if user !== sender {

                user.receiveMessage(message: message)

            }

        }

    }

}

  

// Использование паттерна Mediator

let mediator = ChatMediator()

  

let user1 = ConcreteUser(name: "User 1", mediator: mediator)

let user2 = ConcreteUser(name: "User 2", mediator: mediator)

let user3 = ConcreteUser(name: "User 3", mediator: mediator)

  

mediator.addUser(user: user1)

mediator.addUser(user: user2)

mediator.addUser(user: user3)

  

user1.sendMessage(message: "Hello, everyone!")

  

В данном примере класс `User` представляет абстракцию для пользователей, имеющую свойство `name` и методы `sendMessage` и `receiveMessage`. Класс `ConcreteUser` представляет конкретную реализацию пользователя, который отправляет сообщение через посредника.

  

Класс `ChatMediator` представляет посредника, который содержит список всех пользователей. Он имеет методы `addUser` для добавления пользователей в список и `sendMessage` для отправки сообщения всем пользователям, кроме отправителя.

  

В приведенном коде мы создаем пользователей и добавляем их в список посредника. Затем пользователь `user1` отправляет сообщение через посредника, который пересылает это сообщение всем другим пользователям.

  

Таким образом, паттерн Mediator помогает упростить взаимодействие между объектами, централизуя его через посредника, и уменьшает зависимость между компонентами системы. Это позволяет легко добавлять новых пользователей и расширять функциональность системы чата.