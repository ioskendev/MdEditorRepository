Бинарный поиск — это эффективный алгоритм поиска элемента в отсортированном списке элементов. Он работает, разделяя список на две части, сравнивая искомый элемент с элементом в середине списка и отбрасывая половину списка, в которой точно не может находиться искомый элемент. Процесс повторяется до тех пор, пока не будет найден элемент или до того, как поисковой интервал сократится до нуля.

Давайте рассмотрим реализацию бинарного поиска на языке Swift.

func binarySearch<T: Comparable>(_ array: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = array.count

    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2

        if array[midIndex] == key {
            return midIndex
        } else if array[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }

    return nil
}

### Объяснение кода:

- Функция `binarySearch`: Принимает отсортированный массив `array` и ключ `key`, который нужно найти. Возвращает индекс найденного элемента или `nil`, если элемент не найден.

- Переменные `lowerBound` и `upperBound`: `lowerBound` указывает на начальный индекс диапазона поиска, а `upperBound` указывает на конец. Изначально `lowerBound` равен 0, а `upperBound` — размеру массива.

- Цикл `while`: Продолжается до тех пор, пока `lowerBound` меньше `upperBound`. Это удерживает цикл в рабочем состоянии, пока весь массив или его часть не будет исследована.

- Определение `midIndex`: Рассчитывается как средний индекс между `lowerBound` и `upperBound`.

- Сравнение ключа с элементом по `midIndex`: Если элемент по `midIndex` равен ключу, поиск завершается успешно. Если элемент меньше ключа, поиск продолжается в правой половине. В противном случае — в левой половине.

- Возвращение результата: Если элемент найден, возвращается его индекс. Если элемент не найден, возвращается `nil`.

### Пример использования:

let numbers = [1, 5, 15, 17, 19, 22, 24, 31, 105, 150]
let searchKey = 31

if let index = binarySearch(numbers, key: searchKey) {
    print("Найден элемент \(searchKey) под индексом \(index).")
} else {
    print("Элемент \(searchKey) не найден.")
}

Бинарный поиск значительно более эффективен по сравнению с линейным поиском, особенно в больших списках, поскольку время его выполнения растет логарифмически с увеличением размера списка.