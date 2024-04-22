# Exceptions. Debugging

**![](https://lh5.googleusercontent.com/Irw82ie0j4T3i3TsIAmmx625GLiB3A7T61hLKShno9fiDReb4W0PRlp31uxSvD5YShR2whQXx7MJwp-MXvRgC56ZBSnYZhImNJatkSzwckRXL6sC50qZjeLY9-0yLocdo0aY94zeszE4b6GOs7VgM5AB8A=s2048)**

## План

1.  Основні винятки
    1.  Як обробляти винятки?
    2.  bare except
    3.  Оператор `finally`
    4.  Оператор `else`
    5.  Оператор `raise`
2.  Створення власних типів винятків
3.  Практика і домашнє завдання
4.  Debugging
5.  Література

Що ви робите, коли щось йде не так у вашій програмі? Скажімо, ви
намагаєтесь відкрити файл, але вводите неправильний шлях, або ви хочете
отримати інформацію від користувачів, і вони пишуть щось безглузде. Ви
не хочете, щоб ваша програма аварійно завершувалась, тому ви
використовуєте обробку винятків. У Python така конструкція обгортається
у блок `try/except`.

Ієрархія винятків виглядає так:  
**![](https://lh3.googleusercontent.com/e4ONJuZal2P5auKGDfCIWT7tXj49DM0r_sP98UoIEsBVrpP45O3Moepz5qABP7phppysZJ__fTpCaf02bS_VhY3zl9J5yl8dNJnvItQt1MjYrcaaKUcNYWgHAaie2ov8gKj1lE87M0dSDMM3lw3unbN6TA=s2048)**  
Давайте почнемо знайомство з найпоширенішими винятками, які ви побачите
в Python. Зверніть увагу, що помилка і виняток - це два різні слова, що
описують те саме у контексті обробки винятків

## Основні винятки

Нижче наведений список основних вбудованих винятків (визначення з
документації Python):

`Exception` - клас, на якому фактично ґрунтується всі інші помилки;

`AttributeError` - виникає, коли посилання на атрибут або присвоєння не
можуть бути виконані;

`OSError` - виникає, коли системна функція повертає системну помилку,
включаючи помилки вводу-виводу, такі як «file not found» або «disk
full».

`ImportError` - виникає, коли оператор import не може знайти визначення
модуля або коли оператор не може знайти ім’я файлу, який має бути
імпортований;

`IndexError` - виникає, коли індекс послідовності знаходиться поза
допустимим діапазоном;

`KeyError` - виникає, коли ключ словника не знайдений у наборі існуючих
ключів;

`KeyboardInterrupt` - виникає, коли користувач натискає клавішу
переривання (зазвичай Delete або Ctrl+C);

`NameError` - виникає, коли локальне або глобальне ім’я не знайдене;

`SyntaxError` - виникає, коли синтаксична помилка зустрічається
синтаксичним аналізатором;

`TypeError` - виникає, коли операція або функція застосовується до
об’єкта неправильного типу. Пов’язане значення є рядком, який містить
деталі про неправильність типів;

`ValueError` - виникає, коли вбудована операція або функція отримує
аргумент, тип якого правильний, але значення неправильне, і ситуацію
неможливо більш точно описати, якщо виникає IndexError;

`ZeroDivisionError` - виникає, коли другий аргумент операції ділення або
модуля є нулем.

Існує багато інших винятків, але ви ймовірно не зіткнетесь з ними так
само часто.

### Як обробляти винятки?

Обробка винятків у Python дуже просто. Витратимо трохи часу і напишемо
декілька прикладів, які їх викличуть. Почнемо з однієї з найпростіших
проблем: ділення на нуль.

```python
1 / 0
```

```python
Traceback (most recent call last):
    File "<string>", line 1, in <fragment>
ZeroDivisionError: integer division or modulo by zero
```

```python
try:
    1 / 0
except ZeroDivisionError:
    print("You cannot divide by zero!")
```

```python
>>> You cannot divide by zero!
```

Якщо звернутися до уроків елементарної математики, то пам’ятатимемо, що
на нуль ділити неможливо. У Python ця операція призводить до помилки, як
ми можемо бачити вище. Щоб перехопити помилку, ми використовуємо
конструкцію `try/except`.

#### bare except

Є ще один спосіб перехопити помилку:

```python
try:
    1 / 0
except:
    print("You cannot divide by zero!")
# ЦЕ ПРАЦЮВАТИМЕ, АЛЕ ТАК РОБИТИ НЕ РЕКОМЕНДОВАНО
```

У мові Python це називається “голим” (bare) винятком, що означає, що
будуть перехоплені будь-які винятки. Причина, чому це не рекомендується,
полягає в тому, що ви не будете знати, який саме виняток ви перехопили.
Коли у вас виникає щось на кшталт `ZeroDivisionError`, ви хочете
визначити фрагмент коду, де відбувається ділення на нуль. У
вищенаведеному коді ви не можете вказати, що саме ви хочете визначити.
Давайте розглянемо ще кілька прикладів:

```python
my_dict = {"a":1, "b":2, "c":3}

try:
    value = my_dict["d"]
except KeyError:
    print("That key does not exist!")
```

```python
my_list = [1, 2, 3, 4, 5]

try:
    my_list[6]
except IndexError:
    print("That index is not in the list!")
```

В першому прикладі ми створили словник з трьома елементами. Потім ми
спробували отримати доступ до ключа, якого немає в словнику. Оскільки
ключ не знайдено, виникає помилка `KeyError`, яку ми перехопили.

Другий приклад показує список, який складається з п’яти об’єктів. Ми
спробували отримати об’єкт з сьомого індексу. Згадайте, що в Python
індекси списків починаються з нуля, тому коли ви говорите 6, ви
запитуєте 7 об’єкт. В будь-якому випадку, у нашому списку є лише п’ять
об’єктів, тому виникає `IndexError`, яку ми перехопили.

Також ви можете перехопити кілька помилок одночасно за допомогою одного
оператора. Існує кілька різних способів цього зробити. Давайте
розглянемо їх:

```python
my_dict = {"a":1, "b":2, "c":3}

try:
    value = my_dict["d"]
except IndexError:
    print("This index does not exist!")
except KeyError:
    print("This key is not in the dictionary!")
except:
    print("Some other error occurred!")
```

Це найбільш стандартний спосіб перехопити кілька винятків. Спочатку ми
спробували отримати доступ до неіснуючого ключа, якого немає в нашому
словнику. За допомогою `try/except` ми перевірили код на наявність
помилки `KeyError`, яка знаходиться у другому блоку `except`. Зверніть
увагу, що в кінці коду у нас є “голе” виняткове оброблення. Зазвичай це
не рекомендується, але ви можливо час від часу зіткнетеся з цим, тому
краще бути проінформованим про це. До речі, також зверніть увагу, що вам
не потрібно використовувати цілий блок коду для обробки кількох
винятків. Зазвичай цілий блок використовується для перехоплення одного
єдиного винятку. Давайте розглянемо другий спосіб перехоплення кількох
винятків:

```python
try:
    value = my_dict["d"]
except IndexError, KeyError:
    print("An IndexError or KeyError occurred!")
```

Зверніть увагу, що у цьому прикладі ми помістили помилки, які ми хочемо
виявити, всередину круглих дужок. Проблема цього методу полягає в тому,
що важко сказати, яка саме помилка сталася, тому ми рекомендуємо
попередній приклад більше, ніж цей. Зазвичай, коли сталася помилка, вам
потрібно повідомити користувача за допомогою повідомлення.

Залежно від складності помилки, вам може знадобитися вийти з програми.
Іноді вам може знадобитися виконати очищення перед виходом з програми.
Наприклад, якщо ви відкрили з’єднання з базою даних, вам потрібно його
закрити перед виходом з програми, або ви можете завершити з відкритим
з’єднанням. Інший приклад - закриття файлового дескриптора, до якого ви
звертаєтеся. Тепер нам потрібно навчитися прибирати за собою. Це дуже
просто, якщо використовувати оператор `finally`.

### Оператор `finally`

Оператор `finally` використовується дуже просто. Подивіться на наступний
приклад:

```python
my_dict = {"a":1, "b":2, "c":3}

try:
    value = my_dict["d"]
except KeyError:
    print("A KeyError occurred!")
finally:
    print("The finally statement has executed!")
```

Якщо ви запустите цей код, він буде виконуватися як у блоку `except`,
так і в `finally`. Досить просто, чи не так? Тепер ви можете
використовувати оператор `finally`, щоб очистити після себе. Ви також
можете вставити код `exit` в кінці оператора `finally`.

### Оператор `else`

Оператор `try/except` також має варіант `else`. Він виконується тільки у
випадку, якщо в вашому коді не виникло жодної помилки. Давайте трохи
часу приділимо і подивимося кілька прикладів:

```python
my_dict = {"a":1, "b":2, "c":3}

try:
    value = my_dict["a"]
except KeyError:
    print("A KeyError occurred!")
else:
    print("No error occurred!")
```

Ми бачимо словник, що складається з трьох елементів, і в операторі
`try/except` ми відкриваємо доступ до існуючого ключа. Це працює, тому
що помилка `KeyError` не виникає. Оскільки помилки немає, виконується
блок `else`, і на екран виводиться повідомлення “No error occurred!”.
Тепер додамо оператор `finally`:

```python
my_dict = {"a":1, "b":2, "c":3}

try:
    value = my_dict["a"]
except KeyError:
    print("A KeyError occurred!")
else:
    print("No error occurred!")
finally:
    print("The finally statement ran!")
```

В цьому коді працюють оператори `else` і `finally`. Більшість часу ви не
зіткнетеся з оператором `else`, який використовується у коді, що слідує
за оператором `try/except`, якщо жодна помилка не була знайдена. Як
приклад, застосування оператора `else`, полягає в тому, що ви хочете
виконати другу частину коду, в якій може виникнути помилка. Звичайно,
якщо помилка виникає в `else`, то вона не буде перехоплена.

### Оператор `raise`

Якщо дані у вашому коді не відповідають вашим очікуванням, ви завжди
можете викликати виняток, якщо це потрібно, за допомогою ключового слова
`raise`.

```python
def even_the_odds(odds):
    if odds % 2 != 1:
        raise ValueError("Did not get an odd number")
    return odds + 1
```

Будь-яка виняткове ситуація припиняє виконання коду із виходом з функції
до досягнення точки повернення в разі винятку.

Ми можемо використовувати `raise` всередині будь-якої конструкції.
Наприклад, якщо нам потрібно надіслати помилку на зовнішній сервіс, але
не обробляти її в коді, це також можливо.

```python
try:
    do_stuff(resource)
except SomeException as e:
    log_error(e)
    raise  # re-raise the error
finally:
    free_expensive_resource(resource)
```

`raise` у цьому випадку просто повториться

Ще один такий приклад:

```python
try:
    5 / 0
except ZeroDivisionError:
    print("Got an error")
    raise
```

Майте на увазі, що хтось інший вище у стеку викликів все ж таки може
перехопити виняток і обробити його. У такому випадку, готовий результат
може бути неприємним, оскільки це станеться незалежно від того, чи був
виняток перехоплений, чи ні. Тому, можливо, краще створити новий
виняток, який містить ваш коментар про ситуацію, а також початковий
виняток. Ось приклад коду:

```python
try:
    5 / 0
except ZeroDivisionError as e:
    raise ZeroDivisionError("Got an error", e)
```

В змінній `e` буде зберігатися вся інформація про виняток, і таким чином
ми викличемо потрібний тип винятка з нашим коментарем та всією системною
інформацією.

### Винятки теж об’єкти

Винятки в Python є лише звичайними об’єктами, які успадковують від
вбудованого класу `BaseException` . В коді Python можна використовувати
оператор `raise` для переривання виконання, що призводить до виведення
трасування стеку зі стеку викликів у цій точці та відображення
екземпляру винятку.

Наприклад:

```python
 >>> def failing_function():
...     raise ValueError('Example error!')
>>> failing_function()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 2, in failing_function
ValueError: Example error!
```

Цей код показує, що `ValueError` з повідомленням ‘Example error!’ було
викинуто нашою функцією `failing_function()`, яка була викликана у
інтерпретаторі.

Цю помилку можна так само перехопити:

```python
 >>> try:
...     failing_function()
... except ValueError:
...     print('Handled the error')
Handled the error
```

Або вивести оригінальний текст:

```python
>>> try:
...     failing_function()
... except ValueError as e:
...     print('Caught exception', repr(e))
Caught exception ValueError('Example error!',)
```

## Створення власних типів винятків

Створіть клас, успадкований від `Exception`:

```python
class FooException(Exception):
    pass

try:
    raise FooException("insert description here")
except FooException:
    print("A FooException was raised.")
```

або інший тип винятку:

```python
class NegativeError(ValueError):  
    pass  
  
  
def foo(x):  
    # function that only accepts positive values of x  
  if x < 0:  
        raise NegativeError("Cannot process negative numbers")  
    return x  
  
  
try:  
    result = input("Enter a positive integer: ")  
    result = int(result)  
    result = foo(result)  
except NegativeError:  
    print("You entered a negative number!")  
else:  
    print("The result was " + str(result))
```

Загальний вигляд обробки винятків:

```python
try:
    # some code-which may raise exception
    pass
except KeyError as err:
    # what should •be done in case of KeyError pass
    pass
except (TypeError, ValueError, ZeroDivisionError):
    # Multiple exception handling for similar behavior
    pass
except Exception as exc:
    # Broad exception handling, can be used in the case when
    # developer is not sure, what exception can -be raised.
    # NOT RECOMMENDED.
    pass
else:
    # The code will be executed in the case if no exception was raised.
    pass
finally:
    # This code-will be executed in any case after exception handling or
    # if exception was not raised.
    pass
```

## Debugging

**![](https://lh7-us.googleusercontent.com/HemT9-NabQ56zcTn6vBodLXFoZI-TsUCGhEZA3smLOmNqbuihIQKPkSsDUQO0og7NlD9pbaa4Q6kLQiex2F4V8m5cNQEooPfwkQtZy_50UzikB_xgMu6zkfuVIitdwHNM0cLhfuPWHDvybo0CiMq5QAyhw=s2048)**

Налагодження програми (англ. debugging) - методичний процес пошуку та
зменшення числа помилок або дефектів у комп’ютерній програмі або
електронному обладнанні з метою отримання очікуваної поведінки.

Щоб зрозуміти, де виникла помилка, доводиться:

- дізнаватися про поточні значення змінних;
- з’ясовувати, яким шляхом виконувалася програма.

Існують дві взаємодоповнюючі технології налагодження:

1.  Використання налагоджувачів — програм, які включають в себе  
    інтерфейс користувача для покрокового виконання програми: оператор  
    за оператором, функція за функцією, із зупинками на деяких рядках  
    вихідного коду або при досягненні певної умови.
2.  Виведення поточного стану програми за допомогою розміщених у  
    критичних точках програми операторів виведення — на екран,
    принтер,  
    гучномовець або файл. Виведення налагоджувальних відомостей у файл  
    називається журналом

**Точка зупину (розбиття)** (англ. breakpoint; сленнґ. бря́ка) — це
позначка місця припинення чи призупинення виконання програми, яка
застосовується для відладки ПЗ. Т  
Взагалі, їх використовують, щоб досліджувати сам процес виконання
програми. По зупинці виконання програми програміст перевіряє середовище
(регістри загального призначення, пам’ять, журнали, файли тощо) для
того, щоб з’ясувати, чи програма працює належним чином. На практиці
точка розбиття визначається однією або кількома умовами.  
\*\*

### Debugging in PyCharm![](https://lh7-us.googleusercontent.com/_PWLZ3oRNMlh5iFDLeew9o3ukp_5Dp7NVu5r10HPW9l8rW8gOnRr2pb3BV5hF1S08oaCEew8k1PchUr86xgqgPcLsTOckTa9OMZOC2kQeDsXwsFvLpssXVvhqaywXTJd-t9JRQA83zMKu7gODE57l4Y5pw=s2048)\*\*

**![](https://lh7-us.googleusercontent.com/SvRfSPOPaIcZ2vMh-bjdJ0DLCFUAtL_E3--HzAj8LTIFcRjsGCFPXxwNj7nKfn73JtGAGRGeH1st9NSugQtgmqmV0HcpgimmpqWYxecaihYkiaSETkbTDky-IqPCA613OLEpwJ4rZg30zKuhVZt4nUm_DQ=s2048)**

![](https://lh7-us.googleusercontent.com/Sezcrq8EUL4drKnHMB6cH9zHFgB5XZd_NqMsT8kuj18mp5kHSYEvLhmkzvMprNvQhLWizbwKtjtF3LvBUuH2onz4j1WJjzVOI3zbUQ3RODJB1NHX4elU_yxxcw7LD8ZFs-RfHyin5XT0F3G1qHNLMeZGWw=s2048)

**![](https://lh7-us.googleusercontent.com/XPuZUguETxpWoNiIr_2ucQTdnC8BTgQTDJmUGCE9ttrvQiUC3dpO42sxmHhHAvCOAkzX_8P7WVPU0NdfuHEfO_3QX_1kQicT9PeofCFp5ng0K3XV5bZDk7z3kKiluiDEP84FI5rjVHhNi8CCR0AAj5R9EA=s2048)**

## Практика і домашнє завдання:

1.  Додати до класу Employee методи `save_email(self)` та
    `validate_email(self, email)` та атрибут `email`
2.  Створити виняток `EmailAlreadyExistsException`
3.  Метод `save_email` має викликатись в кінці методу `__init__` та
    записувати email в файл `emails.csv`
4.  Метод `validate_email` має перевіряти чи існує імейл в файлі. Якщо
    імейл вже існує, то викликати помилку `EmailAlreadyExistsException`

`*` У разі виникнення винятку `EmailAlreadyExistsException` записати в
файл `logs.txt` повідомлення у вигляді: %дата% %час% \| %traceback%

## Література

1.  [Built-in
    Exceptions](https://docs.python.org/3.10/library/exceptions.html)
2.  [Exception & Error Handling in
    Python](https://www.datacamp.com/tutorial/exception-handling-python)
3.  [Debugging in
    PyCharm](https://www.jetbrains.com/help/pycharm/debugging-your-first-python-application.html?keymap=windows)
4.  [Debugging in VS
    Code](https://code.visualstudio.com/docs/editor/debugging)
