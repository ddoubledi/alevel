# Тестування в Python

**![](https://lh6.googleusercontent.com/rY5cuQgas-8Ah_GlWnnZ-z3corbdov6WRmWLsR0zrYShqerLHeM3FPrshp6NMBrvYC3KCD_nRdH_XswPeYT4fapO2w81CSQnfJHQLHBFSe4xKvvqm6najp8a4OQAhoiZPpLn2PcmOcxBfGIjy--yx5Sa9g=s2048)**

## План

1.  [Вступ до тестування](19-python.html#intro-to-test)
    1.  Що таке тестування і баг
    2.  Поширені причини появи помилок
    3.  Види тестування
    4.  Хто має тестувати?
    5.  Коли починати тестувати?
    6.  TDD
2.  [Тестування в Python](19-python.html#python-test)
    1.  assert
    2.  unittest
    3.  pytest tox, nose2,
    4.  docktest
    5.  mock
3.  [Література (Що почитати)](19-python.html#literature)

## <span id="intro-to-test"></span>Вступ до тестування

**Тестування програмного забезпечення** - процес дослідження,
випробування програмного продукту, що має на меті перевірку
відповідності між реальною поведінкою програми та її очікуваною
поведінкою.

***Тестування*** - порівняння фактичного результату з очікуваним.

**![](https://lh4.googleusercontent.com/r2271NYCt2oDA6NpHLlFX2j10CxJky89KAUPHdoBBYLYqLxK1KdT71-fhNgdbhdZmqXOtbTPz1pM9yje3XFvXnYrkiONQhs6-ttEDrEiV0Q2THdOXjVyDtBnbEdhuUjmP7PnHfDbeAG3gEbnCamO7lPRsg=s2048)**

**Очікуваний результат == Фактичний результат**

**Цілі тестування**

- Підвищити ймовірність того, що ПЗ, призначене для тестування,
  працюватиме правильно за будь-яких обставин.
- Підвищити ймовірність того, що ПЗ, призначене для тестування,
  відповідатиме всім описаним вимогам.
- Надання актуальної інформації про стан продукту на даний момент.

**Програмна помилка** він же **баг**

**Очікуваний результат != Фактичний результат**

**![](https://lh6.googleusercontent.com/9_Euf8qRlkDnAG7Tsy2NMJ0RzaEPIfrQ5wNiS6cFL11Y8JV3P1GortpeK9Lf0OSYHTeUoG1_8bygYwjLpG3-n_N7uBDFzy0V77TZM4uVxeF3tRn0zVGi6_nbc2HjRHC7DWZJUvikGwrdKWE-akZkqmSKyQ=s2048)**

**[Баг](https://uk.wikipedia.org/wiki/%D0%91%D0%B0%D0%B3)** (bug)- це
помилка в програмі, що спричиняє її неправильну та (або) непередбачувану
роботу, також багом називають відмінність між фактичним та очікуваним
результатом. Через дефекти, допущені ще під час написання коду, програма
може не виконувати закладених функцій, працювати не так, як зазначено в
специфікації, або виконувати дії, які не передбачені. Такі випадки
називаються збоями програми (failure).

**Етимологія**  
В англійській мові вживання терміна bug у значенні «хиба або технічні
труднощі» було започатковано Томасом Едісоном ще у 1870-х.

Протягом Другої світової війни словом «bugs» позначались проблеми з
військовим спорядженням.

За легендою, 9 вересня 1945 року вчені Гарвардського університету, що
тестували обчислювальну машину Mark II Aiken Relay Calculator, знайшли
метелика, що застряг між контактами електромеханічного реле й Ґрейс
Гоппер вжила цей термін. Знайдена комаха була вклеєна до технічного
щоденника, з супроводжувальним написом: «Перший справжній випадок
віднайдення комахи» (англ. «`First actual case of bug being found`»).
Гра слів щодо значень «комаха» і «хиба» зумовила популярність цієї
історії.

![](https://lh6.googleusercontent.com/QfQOMLRmVCyltH_E7YuJ8ZN9Q5L58KSUPNjxXos13xVWTF7Zmsrc5FOgfFF8YAbd6wD8LXMQ_vjGeu-BHlaqA0XzfWZLi2SjGBw9LWeMNXroAECs2V_q2_C3mblFX6PGr7J4_RBP7PacNU3XMaqQtjP_Qg=s2048)

**Поширені причини появи помилок** ([докладніше
тут](https://training.qatestlab.com/blog/technical-articles/causes-of-defects-and-failures/)):

1.  Проблеми в комунікаціях між членами команди
2.  Зміна вимог
3.  Тимчасові рамки
4.  Помилки програмістів
    - помилки та неуважність;
    - нерозуміння логіки ділянки коду;
    - незнання тонкощів мови розробки;
    - помилкові тести;
    - відсутність обробки помилок;
    - копіювання чужих помилок;
5.  Баги в інструментах для розробки програмного забезпечення
6.  Апаратні проблеми (бита пам’ять, [баг у процесорах Intel
    Skylake](https://habr.com/ru/post/332552/))
7.  Помилки тестувальників
8.  Неякісний контроль версій коду
9.  Архітектура програмного забезпечення
10. Брак фінансування

***Project management triangle***
([детальніше](https://asana.com/resources/project-management-triangle))![](https://lh3.googleusercontent.com/Co9stbHYmzGnfN2RHUnmf8IDoQMKb_tf87gXcF437VXAyXUV_D80mihzeISXU8HKqMHNySsLsJW0YGjFXFjbqtDs5Yt9pZgtmrdb7aML7WYq6XFvAA8rIlmF8qUeuW6hOiqHVMCiG5O9uYLIqzrl97pRWw=s2048)

![](https://lh6.googleusercontent.com/BQ-MUkBZ37aMZKqK5w1H-IWwb1Fqy6Nkh_2WatsuJkOydc_rVQ95Jn-AtgDd6tyRqppXK_6UNMN6SU90vapO8qbsG3zMVWaB5YLIXYUZOzyGWgrtpzaZpZ8lU-C-CziU9gha596rBJTTFqfD8-zsua8Ozw=s2048)

### Triangle Dilemma of Quality, Cost & Time

**![](https://lh3.googleusercontent.com/rM1l82vRbirCeP5lApnDvEOJP6HvZcrqwrtAHTg9JNt9JlVNrykSMza5DAbkkcDSDt1B3uBcPHcbNVkGbV-8fM8cn6zxD9M_1n97MDpXjaRqypYO8GldBOyfKcXvoy6hb1WBIXv-ksYRBBRKs8Hjzdr6BA=s2048)**

**Наслідки**

1.  Помилки в програмному забезпеченні медичного апарата променевої
    терапії
    [Therac-25](https://habr.com/ru/company/pvs-studio/blog/307788/)
    призвели до перевищення доз опромінення кількох людей. З червня 1985
    року по січень 1987 року цей апарат став причиною шести передозувань
    радіації, деякі пацієнти отримали дози в десятки тисяч рад. Як
    мінімум двоє померли безпосередньо від передозувань
2.  Ракета Ariane 5: збиток у 8,5 млрд доларів  
    4 червня 1996 року стався невдалий запуск ракети-носія Ariane 5, яка
    була розроблена Європейським космічним агентством. Ракета
    зруйнувалася на 39-й секунді польоту через неправильну роботу
    бортового програмного забезпечення. Ця історія запам’яталася, як
    одна з найдорожчих комп’ютерних помилок.
3.  Фінансова організація Knight Capital Group втратила 440 мільйонів
    доларів за 45 хвилин через помилку в програмі високочастотного
    трейдингу.

[Найгірші комп’ютерні баги в
історії](https://xakep.ru/2005/11/14/28735/)  
[Найдорожчі та доленосні помилки в
ІТ-індустрії](https://habr.com/ru/post/307394/)

**![](https://lh6.googleusercontent.com/bSAe0-DRfV0qi3AwjIyWP3dsTmw4LZS1JBhgmthNfSlqXfwIJlYM-e8vIE9GXQm3Aldqot12AuS2yyCeaOH1JENRUtxeWTG7tYDIvXHKlELhIrrZk7OLv4CyLY9nWmw_f6j3zRfjMTVoBJYL5jN4QRAo6g=s2048)**

**Види тестування**

*Функціональне тестування* - це тестування ПЗ з метою перевірки
реалізованості функціональних вимог, тобто здатності ПЗ за певних умов
розв’язувати завдання, потрібні користувачам. Функціональні вимоги
визначають, що саме робить ПЗ, які завдання воно вирішує.

Функціональні вимоги містять у собі:

- Функціональна придатність (англ. suitability).
- Точність (англ. accuracy).
- Здатність до взаємодії (англ. interoperability).
- Відповідність стандартам і правилам (англ. compliance).
- Захищеність (англ. security).

*Не функціональне тестування ПЗ* - насамперед перевірка на відповідність
не функціональним вимогам:

- Зручність (Здебільшого проводять оцінювання зручності для
  користувачів)
- Масштабованість (перевіряється як вертикальна, так і горизонтальна
  маштабованість додатка, що тестується)
- Продуктивність (Здатність роботи програми за різних навантажень)
- Безпека (Захист користувацьких даних, захист даних додатка, стійкість
  до злому)
- Портованість (Сумісність і переносимість застосунку для і під різні
  оточення, платформи тощо)
- Надійність (Поведінка системи за різних непередбачених ситуацій,
  здатність опрацювання нестандартних дій користувача)

І ще трохи видів тестування:

**![](https://lh3.googleusercontent.com/vOv5nbEC7LkjAC2ZPLTgreKJueJNFjki70nxfzsyqHpxsTPUPnlQ6mZL5QTUT3lKtlfIibP5oNAJhXWDIbVLuTJhFZGw_sLJJwAUy4ZSBc1NQyonN4zlDI-sy5dCD_4We2KeMoLFC-8kutxYuJr6c5PD0w=s2048)**

**Хто має тестувати** (усі, хто може)  
**![](https://lh4.googleusercontent.com/esSVUbR0npphjd8nAK6Az9QQ8GweOU9JVdJOygCJ87QABjyhE8LcaFpoI1xHPYfxI8qLBptYfj2mN2TsuE7BWo2V-cF5L-CyrMCPBbFWKtIgSCdUosYoRe-4hEptnbVDOnAxhCArCGuy32f-zZ_5EC2qQw=s2048)**  
Хороший програміст ніколи не повинен передавати програму у відділ
тестування без першої обробки тестових сценаріїв, яка визначає, чи
відповідає програма певним вимогам.  
У тестувальників і програмістів є різні цілі, коли вони тестують
програмне забезпечення.

- *Тестувальник* - це той, хто пише та/або виконує тестування
  програмного забезпечення з наміром продемонструвати, що програма не
  працює.
- *Програміст* - це той, чиї тести призначені для того, щоб показати, що
  програма дійсно працює.  
  (Борис Бейзер “Методи тестування програмного забезпечення”)

**Коли починати тестувати?**  
Що раніше в життєвому циклі програми розпочнеться тестування, то більшою
мірою ми можемо бути впевнені в її якості.  
**![](https://lh4.googleusercontent.com/amJ7jQzHF89tMTe1MbKFRX2_IZHSOX7QFCyNqSCgOxTcdstDo6pflp2ZPhxWM0LIBZmv5wqm_C_GyQErmMXmdWPnr4eC2vqW2-sqmyP3gdbKHEkSDsRhnapQzm27GqAKDsCPNfwCkEPLMSGE5oRVKIzlzw=s2048)**

**TDD** (test-driven development)  
Розробка через тестування - техніка розробки програмного забезпечення,
що ґрунтується на повторенні дуже коротких циклів розробки: спершу
пишеться тест, що покриває бажану зміну, потім пишеться код, що дасть
змогу пройти тест, і під кінець проводиться рефакторинг нового коду до
відповідних стандартів.  
**![](https://lh3.googleusercontent.com/4xdIfKJaqiDpcCIwXIXCF7igpOwdLizyfDRGof79gdTKrTJ3w2LelmxYwYQmWdCkAPSNZ1rSxXkaFVIpM4AV9zXD0701YukZdPSREoP6jfYUCTIGhGae-UQQqYsF0wS0TdLhWFoB2QXoYoocowIu0guFBg=s2048)**

## <span id="python-test"></span> Тестування в Python

**Що таке Assertion**  
Assertions (твердження) - це інструкції, які “стверджують” певний кейс у
програмі. У Python вони виступають булевими виразами, які перевіряють,
чи є умова істинною або хибною.  
Для перевірки використовується оператор assert

```python
assert condition
```

Якщо вираз істинний, то програма нічого не робить і переходить до
виконання наступного рядка коду.  
Але якщо воно хибне, то програма зупиняється і повертає помилку.

Якщо ж потрібно додати повідомлення для виведення за хибної умови, то
синтаксис буде таким.

```python
assert condition, message
```

```python
a = None  
b = 2  
assert a != b

assert a is not None and b is not None, 'a and b can not be empty'

# Traceback (most recent call last):  
#   File "assert.py", line 4, in <module>  
#     assert a is not None and b is not None, 'a and b can not be empty'  
# AssertionError: a and b can not be empty
```

`assert` може використовуватися прямо в коді, а не в тесті, для
запобігання базовим помилкам, наприклад, передача `None` у важливому
аргументі. Не підходить для серйозних проєктів, але на етапі
прототипування може дуже заощадити час розробки.

**Інструменти для тестування**

- unittest
- pytest
- doctest
- tox
- nose

### [unittest](https://docs.python.org/3/library/unittest.html)

unittest - це framework для тестування, що входить до стандартної
бібліотеки мови Python. Його архітектура виконана в стилі xUnit. xUnit
являє собою сімейство framework’ів для тестування в різних мовах
програмування, в Java - це JUnit (а Unittest - це порт JUnit), C# -
NUnit і т.д.

У використанні unittest присутні кілька концепцій:

- *test case* - це найменша одиниця тестування. Він перевіряє конкретну
  відповідь для конкретного набору вхідних даних. Для реалізації цієї
  сутності використовується клас `TestCase`.

- *test suite* - це колекція тестів, яка може містити як окремі test
  case’и, так і цілі колекції (тобто можна створювати колекції
  колекцій). Колекції використовуються з метою об’єднання тестів для
  спільного запуску.

- *test runner* - це компонент, який організовує виконання тестів і
  надає результат користувачеві.Test runner може мати графічний
  інтерфейс, текстовий інтерфейс або повертати якесь заздалегідь задане
  значення, що описуватиме результат проходження тестів.

- *test fixture* - це фіксований стан об’єктів, що використовуються, як
  вихідний, під час виконання тестів.

Мета використання `fixture` - якщо у вас складний test case, то
підготовка потрібного стану легко може займати багато ресурсів
(наприклад, ви рахуєте функцію з певною точністю, і кожен наступний знак
точності в розрахунках займає день). Використовуючи fixture (на сленгу -
фікстури), попередню підготовку стану пропускаємо й одразу приступаємо
до тестування.

Test fixture може виступати, наприклад, у вигляді:  
– стан бази даних  
– набір змінних середовища  
– набір файлів із необхідним змістом.

```python
from unittest import TestCase


class StringMethodTest(TestCase):

    def test_isupper(self):
        self.assertTrue('FOO'.isupper())
        self.assertFalse('Foo'.isupper())

    def test_split(self):
        s = 'hello world'
        self.assertEqual(['hello', 'world'], s.split())
```

Для того, щоб метод класу виконувався як тест, необхідно, щоб він
починався зі слова *test*. Незважаючи на те, що методи *framework’а
unittest* написані не відповідно до *PEP 8* (з огляду на те, що ідейно
він спадкоємець *xUnit*), необхідно дотримуватися правил стилю для
Python скрізь, де це можливо. Тому імена тестів будемо починати з
префікса *test*\_.

```python
from unittest import TestCase


class TestSum(TestCase):
    def test_sum(self):
        self.assertEqual(6, sum([1, 2, 3]), "Should be 6")

    def test_sum_tuple(self):
        self.assertEqual(6, sum((1, 2, 2)), "Should be 6")
```

**Методи, що використовуються під час запуску тестів**

- `setUp()`  
  Метод викликається перед запуском тесту. Як правило, використовується
  для підготовки оточення для тесту.

- `tearDown()`  
  Метод викликається після завершення роботи тесту. Використовується для
  закриття файлу, видалення даних тощо.

Методи *setUp()* і *tearDown()* викликаються для всіх тестів у межах
класу, в якому вони перевизначені. За замовчуванням, ці методи нічого не
роблять.

**![](https://lh3.googleusercontent.com/QtbLNScBeDHLoH8REyT4MPHoCBjFzm5A43ih9mi1ibkuTp82GgRErDPl0t4eNtJEDDSAix8YUNLddnsISCekWEHYgMZ94vgH7zP-wyyCEvW9HpjHNZBhYhNQSHUwnJPha0yttR7Ff1CjT_KXSq9fCEjRsg=s2048)**

- `setUpClass()`  
  Метод класу, що викликається 1 раз перед запуском тестів в окремому
  класі. setUpClass викликається з класом як єдиним аргументом і має
  бути оформлений як classmethod():

```python
@classmethod
def setUpClass(cls):
    ...
```

- `tearDownClass()`  
  Метод класу, що викликається 1 раз після виконання тестів в окремому
  класі. tearDownClass викликається з класом як єдиним аргументом і має
  бути оформлений як classmethod():

```python
@classmethod
def tearDownClass(cls):
    ...
```

**![](https://lh7-us.googleusercontent.com/FEyqg3FD2NrsGFZWuC91mdfA85wKiu7SbUwh8nA3fKi0hnlqwA151s1QxCS_3pQI4HC4UiL5cE-KX-Q4p6ql8q9eEpeVqY1bnqXA6sC50b38C1ar1lQUJOfiZiX-pe4CBjq8WIvB_JkO97XhTOYi72SVgw=s2048)**

```python
import unittest


class ExampleTestCase(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print('setUpClass')

    def setUp(self):
        print('setUp')

    def testA(self):
        self.assertEqual(2 + 4, 6)
        print('testA')

    def testB(self):
        self.assertTrue('test'.isalpha())
        self.assertFalse('test'.isdigit())
        print('testB')

    def tearDown(self):
        print('tearDown')

    @classmethod
    def tearDownClass(cls):
        print('tearDownClass')
```

*TestCase* клас надає набір *assert*-методів для перевірки та генерації
помилок:

|                                                                                                                    |                      |
|--------------------------------------------------------------------------------------------------------------------|----------------------|
| [assertEqual(a, b)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertEqual)                 | a == b               |
| [assertNotEqual(a, b)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertNotEqual)           | a != b               |
| [assertTrue(x)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertTrue)                      | bool(x) is True      |
| [assertFalse(x)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertFalse)                    | bool(x) is False     |
| [assertIs(a, b)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertIs)                       | a is b               |
| [assertIsNot(a, b)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertIsNot)                 | a is not b           |
| [assertIsNone(x)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertIsNone)                  | x is None            |
| [assertIsNotNone(x)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertIsNotNone)            | x is not None        |
| [assertIn(a, b)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertIn)                       | a in b               |
| [assertNotIn(a, b)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertNotIn)                 | a not in b           |
| [assertIsInstance(a, b)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertIsInstance)       | isinstance(a, b)     |
| [assertNotIsInstance(a, b)](https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertNotIsInstance) | not isinstance(a, b) |

Це далеко не весь список, інші методи описані в документації.

**Де писати тест**

Розпочати написання тесту можна зі створення файлу `test.py`, у якому
міститиметься ваш перший тест-кейс. Для тестування файл повинен мати
можливість імпортувати ваш додаток, тому покладіть `test.py` у папку над
пакетом.  
У міру додавання нових тестів, ваш файл стає дедалі громіздкішим і
складнішим для підтримки, тому радимо створити папку `tests/` і
розділити тести на кілька файлів. Назви всіх файлів мають починатися з
`test_`, щоб виконавці тестів розуміли, що файли Python містять тести,
які потрібно виконати. На великих проєктах тести ділять на кілька
директорій залежно від їхнього призначення або використання.

**Запуск тестів**

1.  ***Інтерфейс командного рядка (CLI)***  
    Щоб знайти і запустити всі тести, можна просто викликати модуль
    unittest, при цьому буде запущено Test Discovery для пошуку.

```python
  python -m unittest 
  
..F
======================================================================
FAIL: test_split_2 (test_view.StringMethodTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/artem/PycharmProjects/pythonProject/test_view.py", line 15, in test_split_2
    self.assertEqual(s.split(), ['hello', 'wodrld'])
AssertionError: Lists differ: ['hello', 'world'] != ['hello', 'wodrld']

First differing element 1:
'world'
'wodrld'

- ['hello', 'world']
+ ['hello', 'wodrld']
?              +


----------------------------------------------------------------------
Ran 3 tests in 0.001s

FAILED (failures=1)
```

Як параметри можна вказати ім’я директорії, файлу, класу або навіть
конкретної функції.

       python -m unittest tests
       python -m unittest test_something.py
       python -m unittest test_module1 test_module2
       python -m unittest test_module.TestClass
       python -m unittest test_module.TestClass.test_method

2.  ***Графічний інтерфейс користувача (GUI)***  
    У PyCharm є зручний спосіб запуску тестів:  
    **![](https://lh7-us.googleusercontent.com/Y2rRzHB_l4pGROU9BZ0e-P00X5-Won3L2xII8wZS8MeNPE2eIATOsvvgUmfhhKkbJ02qQ0kJOPo5tnxkW01T-xOliUpsCZ8Oyg02fK3Z4ZbAE5IaaEZih4e2RGWF-FkQEiofZRfqS33Ny7znCvovIuQX9w=s2048)**  
    **![](https://lh7-us.googleusercontent.com/Q7E2ss06Gr3VTyKiJzSBOUDYP8Qbzn1WQBrXOiJpp-xYgsT2LCrRtRqrkme2RCe0BlP0c0zxkVBsaR6bdJTTgOV2Zc_4iAvnua0hpNYyjw0uo4zWEV8K4ZF6sOkAQ4V1lMqmMR3xRHum8--DUZ3G3uwV4Q=s2048)**

**Пропуск тестів**  
Для пропуску тестів у unittest є декоратори `skip` і `skipIf`,
`skipUnless`.

```python
class Calculator:
    @staticmethod
    def add(a, b):
        return a + b

    @staticmethod
    def mul(a, b):
        return a * b

    @staticmethod
    def div(a, b):
        return a / b
```

```python
import datetime
from unittest import TestCase, skip, skipIf, skipUnless

from calculator import Calculator

TODAY = datetime.datetime.today().weekday()
SATURDAY = 5


class CalcBasicTests(TestCase):
    def setUp(self):
        self.calc = Calculator()

    # Тест буде пропущено
    @skip("Temporaly skip test_add")
    def test_add(self):
        self.assertEqual(self.calc.add(1, 2), 3)

    # Тест буде пропущено, якщо умова (condition) істинна
    @skipIf(TODAY == SATURDAY, "Can't check at saturday")
    def test_sub(self):
        self.assertEqual(self.calc.div(4, 2), 2)

    # Тест буде пропущено, якщо умова (condition) не істинна.
    @skipUnless(TODAY != SATURDAY, "Should be checked only at saturday")
    def test_mul(self):
        self.assertEqual(self.calc.mul(2, 5), 10)

    def test_div(self):
        self.assertEqual(self.calc.div(8, 4), 2)
```

### [pytest](https://docs.pytest.org/en/latest/)

    pip install pytest

pytest досить потужний інструмент для тестування, і багато розробників
залишають свій вибір саме на ньому. pytest за “духом” ближче до мови
Python ніж unittest. Як було сказано вище, unittest у своїй базі -
xUnit, що накладає певні зобов’язання при розробці тестів (створення
класів-спадкоємців від unittest.TestCase, виконання певної процедури
запуску тестів тощо). При розробці на pytest нічого цього робити не
потрібно, ви просто пишете функції, які повинні починатися з “test\_” і
використовуєте assert’и, вбудовані в Python (unittest використовує
свої). pytest також підтримує виконання тест-кейсів unittest.  
Є в ньому й інші корисні функції:

- Підтримка вбудованих виразів assert замість використання спеціальних
  self.assert\*() методів;
- Підтримка фільтрації тест-кейсів;
- Можливість повторного запуску з останнього проваленого тесту;
- Екосистема із сотень плагінів, що розширюють функціональність.

Приклад тест-кейса TestSum для pytest матиме такий вигляд:

```python
def test_sum():
    assert sum([1, 2, 3]) == 6, "Should be 6"

def test_sum_tuple():
    assert sum((1, 2, 2)) == 6, "Should be 6"
```

Щоб запустити

    pytest

### [tox](https://tox.readthedocs.io/en/latest/)

    pip install tox

tox - бібліотека, що автоматизує тестування в декількох віртуальних
середовищах.  
Tox налаштовується через файл конфігурації в каталозі проекту. У ньому
міститься таке:

- Що встановити
- Які версії Python використовувати
- Що зробити перед запуском тестів
- Як запускати тести
- Що робити після запуску тестів

Замість того, щоб вивчати синтаксис налаштування Tox, можна почати з
запуску quickstart-додатку.

    tox-quickstart

Інструмент налаштування Tox поставить вам запитання і створить файл,
схожий на наступний, у `tox.ini`:

    [tox]
    envlist = py27, py36

    [testenv]
    deps = requests
    commands = python -m unittest

Запуск tox із командного рядка:

    tox

Tox видасть результати тестів для кожного оточення. Під час першого
запуску Tox потрібен час на створення віртуальних оточень, але під час
другого запуску все працюватиме набагато швидше.  
Результати роботи Tox досить прості. Створюються оточення для кожної
версії, встановлюються залежності, а потім запускаються тестові команди.

### [nose 2](https://docs.nose2.io/en/latest/)

    pip install nose2

Мета nose2 - розширити unittest, щоб зробити тестування приємнішим і
зрозумілішим. Згодом, після написання сотні, а то й тисячі тестів для
застосунку, стає дедалі складніше розуміти і використовувати дані
виведення unittest.

Nose сумісний з усіма тестами, написаними з unittest фреймворком, і може
замінити його тестовий виконавець. Розробка nose, як додатка з відкритим
вихідним кодом, стала гальмуватися, і було створено nose2. Якщо ви
починаєте з нуля, рекомендується використовувати саме nose2.

```python
# in test_fancy.py
from nose2.tools import params

@params("Sir Bedevere", "Miss Islington", "Duck")
def test_is_knight(value):
    assert value.startswith('Sir')
```

    nose2 -v --pretty-assert
    test_fancy.test_is_knight:1
    'Sir Bedevere' ... ok
    test_fancy.test_is_knight:2
    'Miss Islington' ... FAIL
    test_fancy.test_is_knight:3
    'Duck' ... FAIL

    ======================================================================
    FAIL: test_fancy.test_is_knight:2
    'Miss Islington'
    ----------------------------------------------------------------------
    Traceback (most recent call last):
      File "/mnt/ebs/home/sirosen/tmp/test_fancy.py", line 6, in test_is_knight
        assert value.startswith('Sir')
    AssertionError

    >>> assert value.startswith('Sir')

    values:
        value = 'Miss Islington'
        value.startswith = <built-in method startswith of str object at 0x7f3c3172f430>
    ======================================================================
    FAIL: test_fancy.test_is_knight:3
    'Duck'
    ----------------------------------------------------------------------
    Traceback (most recent call last):
      File "/mnt/ebs/home/sirosen/tmp/test_fancy.py", line 6, in test_is_knight
        assert value.startswith('Sir')
    AssertionError

    >>> assert value.startswith('Sir')

    values:
        value = 'Duck'
        value.startswith = <built-in method startswith of str object at 0x7f3c3172d490>
    ----------------------------------------------------------------------
    Ran 3 tests in 0.001s

    FAILED (failures=2)

### [doctest](https://docs.python.org/3/library/doctest.html)

Модуль doctest шукає шматки тексту, які виглядають як інтерактивні
сеанси Python, а потім виконує ці сеанси, щоб перевірити, чи працюють
вони так само, як показано. Є кілька стандартних причин використовувати
doctest:

- Для того, щоб перевірити актуальність рядків документації,
  переконавшись, що всі інтерактивні приклади працюють саме так, як
  задокументовано.
- Щоб організувати регресійне тестування, перевіряючи, що інтерактивні
  приклади з тестового файлу або тестового об’єкта працюють як
  очікується.
- Щоб написати посібник для пакета, ілюстрований прикладами
  введення-виведення. Залежно від того, на що звертається увага - на
  приклади чи на пояснювальний текст, це можна назвати або “літературним
  тестуванням”, або “документацією, що виконується”.

```python
"""
Це модуль-приклад.

Цей модуль надає одну функцію - factorial().  Наприклад,

>>> factorial(5)
120
"""

def factorial(n):
    """"Повертає факторіал числа n, яке є числом >= 0.

 Якщо резульатат вміщається в int, повертається int.
 Інакше повертається long.

 >>> [factorial(n) for n in range(6)]
 [1, 1, 2, 6, 24, 120]
 >>> [factorial(long(n)) for n in range(6)]
 [1, 1, 2, 6, 24, 120]
 >>> factorial(30)
 265252859812191058636308480000000L
 >>> factorial(30L)
 265252859812191058636308480000000L
 >>> factorial(-1)
 Traceback (most recent call last):
 ...
 ValueError: n must be >= 0

 Можна обчислювати факторіал числа з десятковою частиною, якщо вона
 дорівнює 0:
 >>> factorial(30.1)
 Traceback (most recent call last):
 ...
 ValueError: n must be exact integer
 >>> factorial(30.0)
 265252859812191058636308480000000L

 Крім того, число не має бути занадто великим:
 >>> factorial(1e100)
 Traceback (most recent call last):
 ...
 OverflowError: n too large
 """

    import math
    if not n >= 0:
        raise ValueError("n must be >= 0")
    if math.floor(n) != n:
        raise ValueError("n must be exact integer")
    if n+1 == n:  # перехоплюємо значення типу 1e300
        raise OverflowError("n too large")
    result = 1
    factor = 2
    while factor <= n:
        result *= factor
        factor += 1
    return result

if __name__ == "__main__":
    import doctest
    doctest.testmod()
```

Якщо запустити `example.py` прямо з командного рядка, то doctest виконає
свої чари:

    python example.py

Тут немає жодного висновку. Це нормально і це означає, що всі приклади
працюють. Якщо передати `-v` скрипту, то doctest виведе детальний лог
того, що він робить, і підведе підсумок наприкінці:

    python example.py -v
    Trying:
        factorial(5)
    Expecting:
        120
    ok
    Trying:
        [factorial(n) for n in range(6)]
    Expecting:
        [1, 1, 2, 6, 24, 120]
    ok
    Trying:
        [factorial(long(n)) for n in range(6)]
    Expecting:
        [1, 1, 2, 6, 24, 120]
    ok

І так далі, аж до:

        factorial(1e100)
    Expecting:
        Traceback (most recent call last):
            ...
        OverflowError: n too large
    ok
    2 items passed all tests:
       1 tests in __main__
       8 tests in __main__.factorial
    9 tests in 2 items.
    9 passed and 0 failed.
    Test passed.
    $

### [mock](https://docs.python.org/3/library/unittest.mock.html)

Mock англійською означає “імітація”, “підробка”. Модуль із такою назвою
допомагає сильно спростити тести модулів на Python.

Принцип його роботи простий: якщо потрібно тестувати функцію, то все, що
не відноситься до неї самої (наприклад, читання з диска або з мережі),
можна підмінити макетами-заглушками. При цьому тестовані функції не
потрібно адаптувати для тестів: mock підміняє об’єкти в інших модулях,
навіть якщо код не приймає їх у вигляді параметрів. Тобто, тестувати
можна взагалі без адаптації під тести.

**![](https://lh5.googleusercontent.com/hBhuWaKiY7V4DyNA0uUJEiC6xvNVh4eqcDD9tZH6Wylrra3t8lz841uJNxKY0KDN_rDd73av5iSP-W2zt_eTx5RHLDuHX0HY9if5CixmmpmJW-dqTR-KmOzKTO7JZJOGjhMJH8uOY2K49wiGGQ3iCEYi9g=s2048)**

```python
>>> from unittest.mock import Mock
>>> mock = Mock()
>>> mock
<Mock id='140395983149664'>

>>> mock.some_attribute
<Mock name='mock.some_attribute' id='4394778696'>
>>> mock.do_something()
<Mock name='mock.do_something()' id='4394778920'>
```

**Які переваги має mock?**

- *Висока швидкість*  
  Швидкі тести бувають дуже корисними. Наприклад, якщо у вас є
  ресурсоємна функція, mock для цієї функції скоротить непотрібне
  використання ресурсів під час тестування, тим самим скоротивши час
  виконання тесту.

- *Уникнення небажаних побічних ефектів під час тестування*  
  Якщо ви тестуєте функцію, яка викликає зовнішній API, найімовірніше,
  вам не особливо хочеться щоразу викликати API для того, щоб запустити
  тест. Вам доведеться змінювати код щоразу, коли змінюється API, або
  можуть бути деякі обмеження швидкості, але mock допомагає цього
  уникнути.

**Ланцюжки атрибутів:**

```python
>>> m = Mock()
>>> m
<Mock id='167387660'>

>>> m.any_attribute
<Mock name='mock.any_attribute' id='167387436'>

>>> m.any_attribute
<Mock name='mock.any_attribute' id='167387436'>

>>> m.another_attribute
<Mock name='mock.another_attribute' id='167185324'>>
```

Звернення до атрибута видає ще один екземпляр класу Mock, а повторне
звернення до того самого атрибута - знову той самий екземпляр. Атрибут
може бути чим завгодно, зокрема й функцією. Нарешті, будь-який макет
можна викликати (скажімо, замість класу):

```python
>>> m()
<Mock name='mock()' id='167186284'>

>>> m() is m
False
```

Це буде інший екземпляр, але якщо викликати ще раз, екземпляр буде тим
самим. Так ми можемо призначити цим об’єктам деякі властивості, після
чого передати цей об’єкт у код, що тестується, і вони там будуть
зчитані.

Якщо ми призначимо атрибуту значення, то жодних сюрпризів: при
наступному зверненні отримаємо саме це значення:

```python
>>> m.any_attribute
<Mock name='mock.any_attribute' id='167387436'>
>>> m.any_attribute = 5
>>> m.any_attribute
5
```

**return_value і side_effect**

Припустимо, вам потрібно переконатися, що ваш код у робочі та у вихідні
дні поводиться по-різному, а код передбачає використання строєної
бібліотеки `datetime`.

```python
from datetime import datetime

def is_weekday():
    today = datetime.today()
    # Python's datetime library treats Monday as 0 and Sunday as 6
    return 0 <= today.weekday() < 5

# Test if today is a weekday
assert is_weekday()
```

Якщо запустити цей тест у неділю, то буде ексепшен, що ж із цим робити?
Замокати… Mock об’єкт може повертати за викликом будь-якої функції
необхідне нам значення, за допомогою заповнення `return_value`

```python
import datetime
from unittest.mock import Mock

# Save a couple of test days
tuesday = datetime.datetime(year=2019, month=1, day=1)
saturday = datetime.datetime(year=2019, month=1, day=5)

# Mock datetime to control today's date
datetime = Mock()


def is_weekday():
    today = datetime.datetime.today()
    # Python's datetime library treats Monday as 0 and Sunday as 6
    return 0 <= today.weekday() < 5


# Mock .today() to return Tuesday
datetime.datetime.today.return_value = tuesday
# Test Tuesday is a weekday
assert is_weekday()
# Mock .today() to return Saturday
datetime.datetime.today.return_value = saturday
# Test Saturday is not a weekday
assert not is_weekday()
```

Якщо необхідно, щоб після повторного виклику отримати інші результати,
то в цьому допоможе `side_effect`, який працює так само, як і
`return_value`, тільки приймає об’єкт, що перебирається, і з кожним
викликом повертає наступне значення.

```python
>>> mock_poll = Mock(side_effect=[None, 'data'])
>>> mock_poll()
Немає
>>> mock_poll()
"дані
```

Або як на минулому прикладі

```python
import datetime
from unittest.mock import Mock

# Save a couple of test days
tuesday = datetime.datetime(year=2019, month=1, day=1)
saturday = datetime.datetime(year=2019, month=1, day=5)

# Mock datetime to control today's date
datetime = Mock()


def is_weekday():
    today = datetime.datetime.today()
    # Python's datetime library treats Monday as 0 and Sunday as 6
    return 0 <= today.weekday() < 5


# Mock .today() to return Tuesday first time and Saturday second time
datetime.datetime.today.side_effect = [tuesday, saturday]
assert is_weekday()
assert not is_weekday()
```

**Декоратор patch**  
Є клас, який імітує тривалі обчислення:

```python
import time

class Calculator:
    def sum(self, a, b):
        time.sleep(10)  # long running process
        return a + b
```

І тест до цієї функції:

```python
from unittest import TestCase
from main import Calculator


class TestCalculator(TestCase):
    def setUp(self):
        self.calc = Calculator()

    def test_sum(self):
        answer = self.calc.sum(2, 4)
        self.assertEqual(answer, 6)
```

Цей тест буде йти 10 секунд, імітуючи тривалий процес, але можна
зімітувати виконання цього методу.

```python
from unittest import TestCase
from unittest.mock import patch


class TestCalculator(TestCase):
    @patch('main.Calculator.sum', return_value=9)
    def test_sum(self, sum):
        self.assertEqual(sum(2, 3), 9)
```

або

```python
from unittest import TestCase
from unittest.mock import patch


class TestCalculator(TestCase):
    @patch('main.Calculator.sum')
    def test_sum(self, sum):
        sum.return_value = 9
        self.assertEqual(sum(2, 3), 9)
```

Пропатчені методи потрапляють в аргументи методу тесту.

**Більш просунутий приклад використання**

```python
import requests

class Blog:
    def __init__(self, name):
        self.name = name

    def posts(self):
        response = requests.get("https://jsonplaceholder.typicode.com/posts")

        return response.json()

    def __repr__(self):
        return '<Blog: {}>'.format(self.name)
```

Цей код визначає клас Blog з методом posts. Запустивши posts у Blog,
відбудеться ініціювання виклику API. Посилаючись на post у Blog, об’єкт
ініціюватиме виклик API jsonplaceholder.

У цьому тесті необхідно імітувати непередбачений виклик API і
перевірити, що функція posts об’єкта Blog повертає posts. Необхідно буде
виправити всі posts об’єкта Blog таким чином.

```python
from unittest import TestCase
from unittest.mock import patch, Mock


class TestBlog(TestCase):
    @patch('main.Blog')
    def test_blog_posts(self, MockBlog):
        blog = MockBlog()

        blog.posts.return_value = [
            {
                'userId': 1,
                'id': 1,
                'title': 'Test Title',
                'body': 'Far out in the uncharted backwaters of the unfashionable end of the western spiral arm of the Galaxy\ lies a small unregarded yellow sun.'
            }
        ]

        response = blog.posts()
        self.assertIsNotNone(response)
        self.assertIsInstance(response[0], dict)
```

Ви можете звернути увагу на те, що функція test_blog_posts прикрашена
декоратором @patch. Коли функція оформлена через @patch, mock класу,
методу або функції, передана як ціль для @patch, повертається і
передається в якості аргументу функції, що декорується.

У цьому випадку @patch викликається за допомогою main.Blog і повертає
mock, який передається функції тесту як MockBlog. Важливо зазначити, що
мета, яка перейшла до @patch, повинна бути імпортована в @patch, з якої
вона була викликана. У нашому випадку імпорт форми
`from main import Blog` має бути дозволений без будь-яких проблем.

Крім того, зверніть увагу, що MockBlog є звичайною змінною і ви можете
назвати її, як хочете.

Виклик blog.posts() на нашому моковому об’єкті блогу повертає
підготовлений JSON.  
Зверніть увагу, що тестування mock замість фактичного об’єкта блогу,
дозволяє нам робити додаткові твердження про те, як mock
використовувався.

Наприклад, mock дає змогу перевірити, скільки разів його викликали,
аргументи, з якими його викликали, і навіть чи був mock взагалі
коли-небудь викликаний.

## Домашнє завдання:

- Покрити тестами класи Employee, Recruiter, Developer, Candidate.
- Зробити тести у окремих файлах у каталозі tests.

Для того, щоб файли (імейлів, логів) бачились у тестах, треба
використовувати абсолютний шлях до них:

[settings.py](http://settings.py) (у корені проекту)

```python
from pathlib import Path  
  
ROOT = Path(__file__).parent  
EMAILS = Path(ROOT, 'emails.csv')
```

## <span id="literature"></span>Література (Що почитати)

1.  [Understanding the Python Mock Object
    Library](https://realpython.com/python-mock-library/)
2.  [White/black/grey
    box-тестування](https://qalight.ua/baza-znaniy/white-black-grey-box-testuvannya/)
3.  [Introduction to the Quality
    Triangle](https://fmsreliability.medium.com/introduction-to-the-quality-triangle-f7e771884caa)
