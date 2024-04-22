# Decorators. Staticmethod, classmethod, property.

**![](https://lh5.googleusercontent.com/GF9YVJS8b-q3eYSOp-1wP1NZb5fZSr-6R2q5iailRWnoylHwsieJ5sR24es1Tf4LdqDGRS6h8ZR-Dw9DW7JAGlTgayjBGiYwGrIxlIg2vc1YyG5vKAGcqmHILKPgX9zdrQtSCGICNm8HqtjCosJobvL5PA=s2048)**

## План

1.  Що таке декоратор
2.  Декоратори класів
    1.  classmethod
    2.  staticmethod
    3.  property

## Що таке декоратор

**Підпрограма** (англ. subroutine) — частина програми, яка реалізує
певний алгоритм і дозволяє звернення до неї з різних частин загальної
(головної) програми. В термінах мов програмування: *функції, процедури,
методи*.

***Декоратор** - це функція, яка приймає функцію і повертає функцію.*

Щоб зрозуміти, як працюють декоратори, в першу чергу потрібно
усвідомити, що в Python функції також є об’єктами.

Давайте подивимося, що з цього випливає:

```python
def shout(word="yes"):
    return word.capitalize()+"!"
 
print(shout())
# виведе: 'Yes!'
 
# Оскільки функція - це об'єкт, ви можете пов'язати її зі змінною,
# як і будь-який інший об'єкт
scream = shout
 
# Зверніть увагу, що ми не використовуємо дужок: ми НЕ викликаємо функцію "shout",
# ми пов'язуємо її зі змінною "scream". Це означає, що тепер ми
# можемо викликати "shout" через "scream":
 
print(scream())
# виведе: 'Yes!'

# Більше того, це означає, що ми можемо видалити "shout", і функція все ще
# буде доступна через змінну "scream"
 
del shout
try:
    print(shout())
except NameError as e:
    print (e)
    # виведе: "name 'shout' is not defined"
 
print (scream())
# виведе: 'Yes!'
```

Запам’ятаймо цей факт, скоро ми повернемося до нього. Однак, варто
знати, що функція в Python може бути визначена … всередині іншої
функції!

```python
def talk():
    # В межах визначення функції "talk" ми можемо визначити іншу...
    def whisper(word="yes"):
        return word.lower()+"..."
 
    # ... і відразу ж її використовувати!
    print(whisper())

# Тепер, КОЖНИЙ РАЗ при виклику "talk", всередині нього визначається а потім
# викликається функція "whisper".
talk()
# виведе: "yes..."
 
# Але поза функцією "talk" НЕ існує жодної функції "whisper":
try:
    print(whisper())
except NameError as e:
    print(e)
    # виведе: "name 'whisper' is not defined"
```

### Посилання на функції

Тепер ми знаємо, що функції є повноцінними об’єктами, що означає:

- їх можна пов’язати зі змінною;
- їх можна визначати всередині інших функцій.

Отже, це означає, що одна функція може повертати іншу функцію!

Давайте подивимося:

```python
def get_talk(type_="shout"):
 
    # Ми визначаємо функції прямо тут
    def shout(word="yes"):
        return word.capitalize()+"!"
 
    def whisper(word="yes") :
        return word.lower()+"..."
 
    # Потім повертаємо потрібну
    if type_ == "shout":
        # Зверніть увагу, ми НЕ використовуємо "()", нам не потрібно викликати функцію,
        # ми повертаємо об'єкт функції
        return shout
    else:
        return whisper
 
# Як використовувати це незрозуміле щось?
# Візьмемо функцію і пов'яжемо її зі змінною
talk = get_talk()
 
# Як ми можемо бачити, "talk" тепер - об'єкт "function":
print(talk)
# виведе: <function get_talk.<locals>.shout at 0x10117dd00>
 
# Який можна викликати, як і функцію, визначену "звичайним способом":
print(talk())
# виведе: Yes!
 
# Якщо нам захочеться - можна викликати її безпосередньо з повернутої значення:
print(get_talk("whisper")())
# виведе: yes...
```

Зачекайте, якщо ми можемо повертати функцію, то, очевидно, ми можемо
передавати її іншій функції, у якості параметра:

```python
def do_something_before(func):
    print("Я роблю щось ще, перед тим як викликати функцію, яку ти мені передав")
    print(func())
 
do_something_before(scream)

# виведе:
# Я роблю щось ще, перед тим як викликати функцію, яку ти мені передав
# Yes!
```

Отже, тепер у нас є всі необхідні знання для того, щоб зрозуміти, як
працюють декоратори.

**![](https://lh4.googleusercontent.com/3m_WEH8OrkMNKv2R_gCskyUNh0BB1FRs2pgMc2SIjxftYUoBeOPFm0yoImNWGQ4R-Bm6-apDh03jEN5zGYgkVtUNo_NZnq_0PwImE_wXPmgP2dOJHMVKniXfPGjg1m3VoHqJbAM-ukaFQ4Ka_HjX1NzO_Q=s2048)**  
**![](https://lh3.googleusercontent.com/hYWKYLWnPkqdD6ESHsN7sFdy6Pnk7XVnfLgwaz68nzzC2IUZ_Ocuu3wC9HXquBIWt2HRiX4MqZ9_zP0AcjumARO50MbgUh0GKvgUvJP8TFc_Sr9LrB0dzpkYF-N9NUTpbMgosgOTPePYtQbCa8Odfy2viA=s2048)**

Як ви могли здогадатися, декоратори - це, по суті, певні “обгортки”, які
дають нам можливість робити щось до і після того, що робить декорована
функція, не змінюючи її.

Створимо свій декоратор «власноруч»:

```python
# Декоратор - це функція, яка очікує ІНШУ функцію як параметр
def my_shiny_new_decorator(a_function_to_decorate):
    # Всередині декоратора визначається функція-обгортка.
    # Вона буде (що б ви подумали?..) обгортати декоровану функцію,
    # надаючи можливість виконати довільний код до і після неї.

    def the_wrapper_around_the_original_function():
        # Тут ми розмістимо код, який ми хочемо виконати ПЕРЕД викликом
        # оригінальної функції
        print("Я - код, який виконається до виклику функції")
 
        # ВИКЛИКАЄМО саму декоровану функцію
        a_function_to_decorate()

        # А тут розмістимо код, який ми хочемо виконати ПІСЛЯ виклику
        # оригінальної функції
        print("А я - код, який виконується після")

    # На даний момент функцію "a_function_to_decorate" НЕ БУЛО ВИКЛИКАНО ЖОДЕН РАЗ

    # Тепер повертаємо функцію-обгортку, яка містить в собі
    # декоровану функцію і код, який необхідно виконати до і після.
    # Все просто!
    return the_wrapper_around_the_original_function

# Уявімо тепер, що у нас є функція, яку ми не плануємо змінювати.
def a_stand_alone_function():
    print("Я просто самотня функція, ти ж не посмієш змінювати мене?..")
 
a_stand_alone_function()
# виведе: Я просто самотня функція, ти ж не посмієш змінювати мене?..

# Але, щоб змінити її поведінку, ми можемо задекорувати її, тобто
# просто передати декоратору, який обгорне початкову функцію в будь-який код,
# який нам знадобиться, і поверне нову, готову до використання функцію

a_stand_alone_function_decorated = my_shiny_new_decorator(a_stand_alone_function)
a_stand_alone_function_decorated()
# виведе:
# Я - код, який виконається до виклику функції
# Я просто самотня функція, ти ж не посмієш змінювати мене?..
# А я - код, який виконується після

# Можливо, тепер ми б хотіли, щоб при кожному виклику a_stand_alone_function
# замість неї викликався a_stand_alone_function_decorated. Нічого простішого,
# просто перезапишемо a_stand_alone_function функцією, яку повернув my_shiny_new_decorator:
a_stand_alone_function = my_shiny_new_decorator(a_stand_alone_function)
a_stand_alone_function()
# виведе:
# Я - код, який виконається до виклику функції
# Я просто самотня функція, ти ж не посмієш змінювати мене?..
# А я - код, який виконується після
```

Цей же синтаксис можна реалізувати за допомогою використання знаку `@`,
це один з прикладів так званого “синтаксичного цукру”.

Ось як можна було записати попередній приклад, використовуючи синтаксис
декораторів:

```python
@my_shiny_new_decorator
def another_stand_alone_function():
    print("Залиш мене в спокої")
 
another_stand_alone_function()
# виведе:
# Я - код, який виконається до виклику функції
# Залиш мене в спокої
# А я - код, який виконується після
```

Так, все дійсно настільки просто!

Тобто, ситаксис декоратор з використанням `@` - це просто скорочений
запис (синтаксичний цукор) для конструкцій такого виду:

```python
another_stand_alone_function = my_shiny_new_decorator(another_stand_alone_function)
```

Декоратори - це просто pythonic реалізація патерну проектування
“Декоратор”. В Python включені деякі класичні патерни проектування, такі
як розглянуті в цій статті декоратори або ітератори, з якими будь-який
пітоніст знайомий.

Можна вкладати декоратори один в одного, наприклад, так:

```python
def bread(func):
    def wrapper():
        print("</------\>")
        func()
        print("<\______/>")
    return wrapper
 
def ingredients(func):
    def wrapper():
        print("#помідори#")
        func()
        print("~салат~")
    return wrapper
 
def sandwich(food="--шинка--"):
    print(food)
 
sandwich()
# виведе: --шинка--
sandwich = bread(ingredients(sandwich))
sandwich()
# виведе:
# </------\>
# #помідори#
# --шинка--
# ~салат~
# <\______/>
```

У цьому прикладі функція `sandwich` спочатку декорується декоратором
`ingredients`, а потім декорується декоратором `bread`. При виклику
`sandwich()` відбувається виконання коду з обох декораторів та самої
функції `sandwich` у визначеній послідовності.

І використовуючи синтаксис декораторів:

```python
@bread
@ingredients
def sandwich(food="--шинка--"):
    print(food)
 
sandwich()
# виведе:
# </------\>
# #помідори#
# --шинка--
# ~салат~
# <\______/>
```

Слід пам’ятати, що порядок застосування декораторів МАЄ ЗНАЧЕННЯ:

```python
@ingredients
@bread
def sandwich(food="--шинка--"):
    print(food)
 
sandwich()
# виведе:
# #помідори#
# </------\>
# --шинка--
# <\______/>
# ~салат~
```

Однак, всі декоратори, які ми розглядали раніше, не мали одного дуже
важливого функціоналу - передачі аргументів декорованій функції.

Ну що ж, виправимо це непорозуміння!

#### Передача («прокидання») аргументів у декоровану функцію

Немає ніякої чорної магії, все, що нам потрібно - це передати аргументи
далі!

```python
def a_decorator_passing_arguments(function_to_decorate):
    def a_wrapper_accepting_arguments(arg1, arg2):  # аргументи надходять звідси
        print("Ось що я отримав:", arg1, arg2)
        function_to_decorate(arg1, arg2)
    return a_wrapper_accepting_arguments
 
# Тепер, коли ми викликаємо функцію, яку повертає декоратор,
# ми викликаємо її "обгортку", передаємо їй аргументи, і вона, у свою чергу,
# передає їх декорованій функції
 
@a_decorator_passing_arguments
def print_full_name(first_name, last_name):
    print("Мене звуть", first_name, last_name)
 
print_full_name("John", "Smith")
# виведе:
# Ось що я отримав: John Smith
# Мене звуть John Smith
```

### Декорування методів

Один із важливих фактів, які слід розуміти, полягає в тому, що функції
та методи в Python - це практично одне й те саме, за винятком того, що
методи завжди очікують першим параметром посилання на сам об’єкт (self).
Це означає, що ми можемо створювати декоратори для методів так само, як
і для функцій, просто не забуваючи про self.

```python
def method_friendly_decorator(method_to_decorate):
    def wrapper(self, lie):
        lie = lie - 3 # справді, дружелюбно - знизимо вік іще сильніше :-)
        return method_to_decorate(self, lie)
    return wrapper
 
 
class Lucy(object):
 
    def __init__(self):
        self.age = 32
 
    @method_friendly_decorator
    def say_your_age(self, lie):
        print("Мені %s, а ти б скільки дав?" % (self.age + lie))
 
l = Lucy()
l.say_your_age(-3)
# виведе: Мені 26, а ти б скільки дав?
```

Звичайно, якщо ми створюємо максимально загальний декоратор і хочемо,
щоб його можна було застосувати до будь-якої функції або методу, то
варто скористатися тим, що `*args` розпаковує кортеж args, а `**kwargs`
розпаковує словник kwargs:

```python
def a_decorator_passing_arbitrary_arguments(function_to_decorate):
    # Ця "обгортка" приймає будь-які аргументи
    def a_wrapper_accepting_arbitrary_arguments(*args, **kwargs):
        print("Чи передали мені що-небудь?:")
        print(args)
        print(kwargs)
        # Тепер ми розпакуємо *args і **kwargs
        # Якщо ви не дуже добре знайомі з розпакуванням, можете прочитати наступну статтю:
        # http://www.saltycrane.com/blog/2008/01/how-to-use-args-and-kwargs-in-python/
        function_to_decorate(*args, **kwargs)
    return a_wrapper_accepting_arbitrary_arguments
 
@a_decorator_passing_arbitrary_arguments
def function_with_no_argument():
    print("Python - це круто, аргументів немає")
 
function_with_no_argument()
# виведе:
# Чи передали мені що-небудь?
# ()
# {}
# Python - це круто, тут не посперечаєшся.
 
@a_decorator_passing_arbitrary_arguments
def function_with_arguments(a, b, c):
    print(a, b, c)
 
function_with_arguments(1,2,3)

# виведе:
# Чи передали мені що-небудь?
# (1, 2, 3)
# {}
# 1 2 3
 
@a_decorator_passing_arbitrary_arguments
def function_with_named_arguments(a, b, c, platypus="Чому ні?"):
    print("Чи люблять %s, %s і %s качкодзьобів? %s" % (a, b, c, platypus))
 
function_with_named_arguments("Білл", "Лінус", "Стів", platypus="Безумовно!")
# виведе:
# Чи передали мені що-небудь?
# ('Білл', 'Лінус', 'Стів')
# {'platypus': 'Безумовно!'}
# Чи люблять Білл, Лінус і Стів качкодзьобів? Безумовно!
 
class Mary(object):
 
    def __init__(self):
        self.age = 31
 
    @a_decorator_passing_arbitrary_arguments
    def say_your_age(self, lie=-3): # Тепер ми можемо вказати значення за замовчуванням
        print("Мені %s, а ти б скільки дав?" % (self.age + lie))
 
m = Mary()
m.say_your_age()
# виведе:
# Чи передали мені що-небудь?
# (<__main__ .Mary object at 0xb7d303ac>,)
# {}
# Мені 28, а ти б скільки дав?
```

### Виклик декоратора з різними аргументами

Чудово, з цим розібралися. Що ви тепер скажете про те, щоб спробувати
викликати декоратори з різними аргументами?

Це не так просто, як здається, оскільки декоратор повинен приймати
функцію як аргумент, і ми не можемо просто так передати йому що-небудь
ще.

Тож перед тим, як показати вам рішення, я б хотів освіжити в пам’яті те,
що ми вже знаємо:

```python
# Декоратори - це просто функції
def my_decorator(func):
    print("Я звичайна функція")
    def wrapper():
        print("Я - функція, що повертається декоратором")
        func()
    return wrapper
 
# Отже, ми можемо викликати її, не використовуючи "@"-синтаксис:
 
def lazy_function():
    print("zzzzzzzzzz")
 
decorated_function = my_decorator(lazy_function)
# виведе: Я звичайна функція
 
# Цей код виводить "Я звичайна функція", тому що це саме те, що ми зробили:
# викликали функцію. Нічого надприродного
 
@my_decorator
def lazy_function():
    print("zzzzzzzzzz")
 
# виведе: Я звичайна функція

```

Як ми бачимо, це дві аналогічні дії. Коли ми пишемо `@my_decorator` - ми
просто говоримо інтерпретатору “викликати функцію, під назвою
my_decorator”. Це важливий момент, тому що ця назва може як привести нас
безпосередньо до декоратора… так і ні!  
Давайте зробимо щось страшне!:)

```python
def decorator_maker():
 
    print("Я створюю декоратори! Я буду викликаний тільки раз: "+\
          "коли ти попросиш мене створити тобі декоратор.")
 
    def my_decorator(func):
 
        print("Я - декоратор! Я буду викликаний тільки раз: у момент декорування функції.")
 
        def wrapped():
            print("Я - обгортка навколо декорованої функції. "
                  "Я буду викликана кожного разу, коли ти викликаєш декоровану функцію. "
                  "Я повертаю результат роботи декорованої функції.")
            return func()
 
        print("Я повертаю обгорнуту функцію.")
 
        return wrapped
 
    print("Я повертаю декоратор.")
    return my_decorator
 
# Давайте тепер створимо декоратор. Це всього лише ще один виклик функції
new_decorator = decorator_maker()
# виведе:
# Я створюю декоратори! Я буду викликаний тільки раз: коли ти попросиш мене створити тобі декоратор. 
# Я повертаю декоратор.
 
# Тепер декоруємо функцію
 
def decorated_function():
    print("Я - декорована функція.")
 
decorated_function = new_decorator(decorated_function)
# виведе:
# Я - декоратор! Я буду викликаний тільки раз: у момент декорування функції.
# Я повертаю обгорнуту функцію.
 
# Тепер нарешті викличемо функцію:
decorated_function()
# виведе:
# Я - обгортка навколо декорованої функції. Я буду викликана щоразу, коли ти викликаєш декоровану функцію.
# Я повертаю результат роботи декорованої функції.
# Я - декорована функція.
```

Довго? Довго. Перепишемо цей код без використання проміжних змінних:

```python
def decorated_function():
    print "Я - декорована функція."
decorated_function = decorator_maker()(decorated_function)
# виведе:
# Я створюю декоратори! Я буду викликаний тільки раз: коли ти попросиш мене створити тобі декоратор. 
# Я повертаю декоратор.
# Я - декоратор! Я буду викликаний тільки раз: у момент декорування функції.
# Я повертаю обгорнуту функцію.
 
# Нарешті:
decorated_function()
# виведе:
# Я - обгортка навколо декорованої функції. Я буду викликана щоразу, коли ти викликаєш декоровану функцію.
# Я повертаю результат роботи декорованої функції.
# Я - декорована функція.
```

А тепер ще раз, ще коротше:

```python
@decorator_maker()
def decorated_function():
    print("Я - оформлена функція").

# виведе:
# Я створюю декоратори! Я буду викликаний тільки раз: коли ти попросиш мене створити тобі декоратор. 
# Я повертаю декоратор.
# Я - декоратор! Я буду викликаний тільки раз: у момент декорування функції.
# Я повертаю обгорнуту функцію.
 
# І знову:
decorated_function()
# виведе:
# Я - обгортка навколо декорованої функції. Я буду викликана щоразу, коли ти викликаєш декоровану функцію.
# Я повертаю результат роботи декорованої функції.
# Я - декорована функція.
```

Ви помітили, що ми викликали функцію, після знака `@`?:)

Повернемося, нарешті, до аргументів декораторів, адже якщо ми
використовуємо функцію, щоб створювати декоратори “на льоту”, ми можемо
передавати їй будь-які аргументи, вірно?

```python
def decorator_maker_with_arguments(decorator_arg1, decorator_arg2):
 
    print("Я створюю декоратори! І я отримав такі аргументи:", decorator_arg1, decorator_arg2)
 
    def my_decorator(func):
        print("Я - декоратор. І ти все ж зміг передати мені ці аргументи:", decorator_arg1, decorator_arg2)
 
        # Не переплутайте аргументи декораторів з аргументами функцій!
        def wrapped(function_arg1, function_arg2) :
            print ("Я - обгортка навколо декорованої функції.\n"
                  "І я маю доступ до всіх аргументів: \n"
                  "\t- і декоратора: {0} {1}\n"
                  "\t- і функції: {2} {3}\n"
                  "Тепер я можу передати потрібні аргументи далі"
                  .format(decorator_arg1, decorator_arg2,
                          function_arg1, function_arg2))
            return func(function_arg1, function_arg2)
 
        return wrapped
 
    return my_decorator
 
@decorator_maker_with_arguments("Леонард", "Шелдон")
def decorated_function_with_arguments(function_arg1, function_arg2):
    print ("Я - декорована функція і я знаю тільки про свої аргументи: {0}"
           " {1}".format(function_arg1, function_arg2))
 
decorated_function_with_arguments("Раджеш", "Говард")
# виведе:
# Я створюю декоратори! І я отримав такі аргументи: Леонард Шелдон
# Я - декоратор. І ти все ж зміг передати мені ці аргументи: Леонард Шелдон
# Я - обгортка навколо декорованої функції.
# І я маю доступ до всіх аргументів: 
# - і декоратора: Леонард Шелдон
# - і функції: Раджеш Говард
# Тепер я можу передати потрібні аргументи далі
# Я - декорована функція і я знаю тільки про свої аргументи: Раджеш Говард
```

Ось він, шуканий декоратор, якому можна передавати довільні аргументи.

Безумовно, аргументами можуть бути будь-які змінні:

```python
c1 = "Пенні"
c2 = "Леслі"
 
@decorator_maker_with_arguments("Леонард", c1)
def decorated_function_with_arguments(function_arg1, function_arg2):
    print ("Я - декорована функція і я знаю тільки про свої аргументи: {0}"
           " {1}".format(function_arg1, function_arg2))
 
decorated_function_with_arguments(c2, "Говард")
# виведе:
# Я створюю декоратори! І я отримав такі аргументи: Леонард Пенні
# Я - декоратор. І ти все ж зміг передати мені ці аргументи: Леонард Пенні
# Я - обгортка навколо декорованої функції.
# І я маю доступ до всіх аргументів: 
# - і декоратора: Леонард Пенні
# - і функції: Леслі Говард
# Тепер я можу передати потрібні аргументи далі
# Я - декорована функція і я знаю тільки про свої аргументи: Леслі Говард
```

Таким чином, ми можемо передавати декоратору будь-які аргументи, як
звичайній функції. Ми можемо використовувати і розпакування через
`*args` та `**kwargs` у разі потреби.

Але необхідно завжди тримати в голові, що декоратор викликається рівно
один раз. У момент, коли Python імпортує Ваш скрипт. Після цього ми вже
не можемо ніяк змінити аргументи, з якими створили декоратор.

Коли ми пишемо “import x”, усі функції з x декоруються відразу ж, і ми
вже не зможемо нічого змінити.

#### Трохи практики: напишемо декоратор декоратора, що декорує декоратор

Ось вам бонус :) Ця невелика хитрість дасть вам змогу перетворити
будь-який звичайний декоратор на декоратор, який приймає аргументи.

Спочатку, щоб отримати декоратор, який приймає аргументи, ми створили
його за допомогою іншої функції.

Ми обернули наш декоратор.

Чи є у нас що-небудь, чим можна обернути функцію?

Точно, декоратори!

Давайте ж трохи розважимося і напишемо декоратор для декораторів:

```python
def decorator_with_args(decorator_to_enhance):
    """
    Ця функція замислюється ЯК декоратор і ДЛЯ декораторів.
    Вона має декорувати іншу функцію, яка має бути декоратором.
    Краще випийте чашку кави.
    Вона дає можливість будь-якому декоратору приймати довільні аргументи,
    позбавляючи Вас головного болю про те, як же це робиться, щоразу, коли цей функціонал необхідний.
    """
 
    # Ми використовуємо той самий трюк, який ми використовували для передачі аргументів:
    def decorator_maker(*args, **kwargs):
 
        # створимо на льоту декоратор, який приймає як аргумент тільки 
        # функцію, але зберігає всі аргументи, передані своєму "творцеві"
        def decorator_wrapper(func):
 
            # Ми повертаємо те, що поверне нам початковий декоратор, який, у свою чергу
            # ПРОСТО ФУНКЦІЯ (яка повертає функцію).
            # Єдина пастка в тому, що цей декоратор повинен бути саме такого
            # decorator(func, *args, **kwargs)
            # виду, інакше нічого не спрацює
            return decorator_to_enhance(func, *args, **kwargs)
 
        return decorator_wrapper
 
    return decorator_maker
```

Це може бути використано так:

```python
# Ми створюємо функцію, яку будемо використовувати як декоратор і декоруємо її :-)
# Не варто забувати, що вона повинна мати вигляд "decorator(func, *args, **kwargs)"
@decorator_with_args
def decorated_decorator(func, *args, **kwargs):
    def wrapper(function_arg1, function_arg2):
        print("Мені тут передали...:", args, kwargs)
        return func(function_arg1, function_arg2)
    return wrapper
 
# Тепер декоруємо будь-яку потрібну функцію нашим новеньким, ще блискучим декоратором:
 
@decorated_decorator(42, 404, 1024)
def decorated_function(function_arg1, function_arg2):
    print ("Привіт", function_arg1, function_arg2)
 
decorated_function("Всесвіт і", "все інше")
# виведе:
# Мені тут передали...: (42, 404, 1024) {}
# Привіт Всесвіт і все інше
 
```

Рекомендації для роботи з декораторами

Декоратори дещо уповільнюють виклик функції, не забувайте про це.

Ви не можете “роздекорувати” функцію. Безумовно, існують трюки, що дають
змогу створити декоратор, який можна від’єднати від функції, але це
погана практика. Правильніше буде запам’ятати, що якщо функція
декорована - це не скасувати.

Декоратори обертають функції, що може ускладнити налагодження.

*Як можна використовувати декоратори? Навіщо ж потрібні декоратори?*  
Декоратори можуть бути використані для розширення можливостей функцій зі
сторонніх бібліотек (код яких ми не можемо змінювати).

Так само корисно використовувати декоратори для розширення різних
функцій одним і тим самим кодом, без повторного його переписування
щоразу, наприклад:

```python
def benchmark(func):
    """
    Декоратор, що виводить час, який зайняв
    виконання декорованої функції.
    """
    import time
    def wrapper(*args, **kwargs):
        start = time.monotonic()
        res = func(*args, **kwargs)
        end = time.monotonic()
        print(func.__name__, end - start)
        return res

    return wrapper


def logging(func):
    """
    Декоратор, що логірує роботу коду.
    (добре, він просто виводить виклики, але тут могло бути й логування!)
    """

    def wrapper(*args, **kwargs):
        res = func(*args, **kwargs)
        print(func.__name__, args, kwargs)
        return res

    return wrapper


def counter(func):
    """
    Декоратор, що зчитує і виводить кількість викликів
    декорованої функції.
    """

    def wrapper(*args, **kwargs):
        wrapper.count += 1
        res = func(*args, **kwargs)
        print("{0} було викликано: {1}x".format(func.__name__, wrapper.count))
        return res

    wrapper.count = 0
    return wrapper


@benchmark
@logging
@counter
def reverse_string(string):
    return string[::-1]


print(reverse_string("Паліндром — і ні морд, ні лап"))
print(reverse_string("A man, a plan, a canoe, pasta, heros, rajahs, a coloratura, maps, snipe, percale, macaroni, "
                     "a gag, a banana bag, a tan, a tag, a banana bag again (or a camel), a crepe, pins, Spam, a rut, "
                     "a Rolo, cash, a jar, sore hats, a peon, a canal: Panama!"))

# виведе:
# reverse_string було викликано: 1x
# wrapper ('Паліндром — і ні морд, ні лап',) {}
# wrapper 1.8040998838841915e-05
# пал ін ,дром ін і — морднілаП
# reverse_string було викликано: 2x
# wrapper ('A man, a plan, a canoe, pasta, heros, rajahs, a coloratura, maps, snipe, percale, macaroni, a gag, a banana bag, a tan, a tag, a banana bag again (or a camel), a crepe, pins, Spam, a rut, a Rolo, cash, a jar, sore hats, a peon, a canal: Panama!',) {}
# wrapper 8.042086847126484e-06
# !amanaP :lanac a ,noep a ,stah eros ,raj a ,hsac ,oloR a ,tur a ,mapS ,snip ,eperc a ,)lemac a ro( niaga gab ananab a ,gat a ,nat a ,gab ananab a ,gag a ,inoracam ,elacrep ,epins ,spam ,arutaroloc a ,shajar ,soreh ,atsap ,eonac a ,nalp a ,nam A
```

Як бачите, замість імені оригінальної функції ми отримуємо wrapper, імʼя
обгортки, для того, щоб зберегти і прокинути оригінальне імʼя, треба
додати декоратор `wraps` із модуля `functools`

```python
from functools import wraps
def logged(func):
    @wraps(func)
    def with_logging(*args, **kwargs):
        print(func.__name__ + " was called")
        return func(*args, **kwargs)
    return with_logging

@logged
def f(x):
    """does some math"""
    return x + x * x

print(f.__name__)  # prints 'f'
print(f.__doc__)   # prints 'does some math'
```

Таким чином, декоратори можна застосувати до будь-якої функції,
розширивши її функціонал і не переписуючи жодного рядка коду!

```python
from functools import wraps


def benchmark(func):
    """
    Декоратор, що виводить час, який зайняв
    виконання декорованої функції.
    """
    import time
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.monotonic()
        res = func(*args, **kwargs)
        end = time.monotonic()
        print(func.__name__, end - start)
        return res

    return wrapper


def logging(func):
    """
    Декоратор, що логірує роботу коду.
    (добре, він просто виводить виклики, але тут могло бути й логування!)
    """

    @wraps(func)
    def wrapper(*args, **kwargs):
        res = func(*args, **kwargs)
        print(func.__name__, args, kwargs)
        return res

    return wrapper


def counter(func):
    """
    Декоратор, що зчитує і виводить кількість викликів
    декорованої функції.
    """

    @wraps(func)
    def wrapper(*args, **kwargs):
        wrapper.count += 1
        res = func(*args, **kwargs)
        print("{0} було викликано: {1}x".format(func.__name__, wrapper.count))
        return res

    wrapper.count = 0
    return wrapper


@benchmark
@logging
@counter
def reverse_string(string):
    return string[::-1]


print(reverse_string("Паліндром — і ні морд, ні лап"))
print(reverse_string("A man, a plan, a canoe, pasta, heros, rajahs, a coloratura, maps, snipe, percale, macaroni, "
                     "a gag, a banana bag, a tan, a tag, a banana bag again (or a camel), a crepe, pins, Spam, a rut, "
                     "a Rolo, cash, a jar, sore hats, a peon, a canal: Panama!"))

# reverse_string було викликано: 1x
# reverse_string ('Паліндром — і ні морд, ні лап',) {}
# reverse_string 1.8167000234825537e-05
# пал ін ,дром ін і — морднілаП
# reverse_string було викликано: 2x
# reverse_string ('A man, a plan, a canoe, pasta, heros, rajahs, a coloratura, maps, snipe, percale, macaroni, a gag, a banana bag, a tan, a tag, a banana bag again (or a camel), a crepe, pins, Spam, a rut, a Rolo, cash, a jar, sore hats, a peon, a canal: Panama!',) {}
# reverse_string 9.87499879556708e-06
# !amanaP :lanac a ,noep a ,stah eros ,raj a ,hsac ,oloR a ,tur a ,mapS ,snip ,eperc a ,)lemac a ro( niaga gab ananab a ,gat a ,nat a ,gab ananab a ,gag a ,inoracam ,elacrep ,epins ,spam ,arutaroloc a ,shajar ,soreh ,atsap ,eonac a ,nalp a ,nam A
```

## Декоратори класів

**![](https://lh3.googleusercontent.com/7qhK29J0Cx2k1j6s8N6Lfq_hAY4kRnA6TCpOqvgFHamGeInMUUAwhGTlMrTOANkZ7akWu_2hRq3OfVMEGFoDdIoHCUlr1z4JNKV3lPmxI0R1cMIPg-vhoGyKn9pY5-sfpt-aDZuXpZcQPYOq1WCYAilPJQ=s2048)**

Згідно з моделлю даних Python, мова пропонує три види методів: статичні,
методи класу та екземпляра класу. Давайте подивимося, що ж відбувається
за лаштунками кожного з видів методів. Розуміння принципів їхньої роботи
допоможе у створенні красивого та ефективного коду. Почнемо з
найпростішого прикладу, в якому демонструються всі три види методів.

```python
class ToyClass:
    def instancemethod(self):
        return 'instance method called', self

    @classmethod
    def classmethod(cls):
        return 'class method called', cls

    @staticmethod
    def staticmethod():
        return 'static method called'
```

### Методи екземпляра класу

Не розглядатимемо докладно, тому що це будь-який уже знайомий нам,
звичайний метод класу.

Це найбільш часто використовуваний вид методів. Методи екземпляра класу
приймають об’єкт класу як перший аргумент, який прийнято називати `self`
і який вказує на сам екземпляр. Кількість параметрів методу не обмежена.

Використовуючи параметр `self` , ми можемо змінювати стан об’єкта і
звертатися до інших його методів і параметрів. До того ж, використовуючи
атрибут self.`__class__` , ми отримуємо доступ до атрибутів класу і
можливості змінювати стан самого класу. Тобто методи екземплярів класу
дозволяють змінювати як стан певного об’єкта, так і класу.

Вбудований приклад методу екземпляра - `str.upper()`:

```python
>>> "welcome".upper() # <- викликається на строкових даних
'WELCOME'
```

### Методи класу

Методи класу приймають клас як параметр, який прийнято позначати як
`cls`. Він вказує на клас ToyClass, а не на об’єкт цього класу. При
декларації методів цього виду використовується декоратор `classmethod`.

Методи класу прив’язані до самого класу, а не його екземпляра. Вони
можуть змінювати стан класу, що позначиться на всіх об’єктах цього
класу, але не можуть змінювати конкретний об’єкт.

Вбудований приклад методу класу - `dict.fromkeys()` - повертає новий
словник із переданими елементами як ключами.

```python
dict.fromkeys('AEIOU') # <- викликається за допомогою класу dict
{'A': None, 'E': None, 'I': None, 'O': None, 'U': None}
```

### Статичні методи

Статичні методи декларуються за допомогою декоратора `staticmethod`. Їм
не потрібен певний перший аргумент (ні `self`, ні `cls`).

Їх можна сприймати як методи, які “не знають, до якого класу належать”.

Таким чином, статичні методи прикріплені до класу лише для зручності і
не можуть змінювати стан ні класу, ні його екземпляра.

З теорією достатньо. Давайте розберемося з роботою методів, створивши
об’єкт нашого класу і викликавши по черзі кожен із методів:
`instancemethod`, `classmethod` and `staticmethod`.

```python
>>> obj = ToyClass()
>>> obj.instancemethod()
('instance method called', ToyClass instance at 0x10f47e7a0>)
>>> ToyClass.instancemethod(obj)
('instance method called', ToyClass instance at 0x10f47e7a0>)
```

Приклад вище підтверджує те, що метод instancemethod має доступ до
об’єкта класу ToyClass через аргумент self.

Тепер давайте викличемо метод класу:

```python
>>> obj.classmethod()
('class method called', <class  ToyClass at 0x10f453a10>)
```

Ми бачимо, що метод класу `classmethod()` має доступ до самого класу
ToyClass, але не до його конкретного екземпляра об’єкта. Запам’ятайте, у
Python все є об’єктом. Клас теж об’єкт, який ми можемо передати функції
як аргумент.

Зауважте, що `self` і `cls` - не обов’язкові назви і ці параметри можна
називати інакше, aле так робити не варто.

```python
def instancemethod(self, ...)
def classmethod(cls, ...)
```

-------те ж саме, що й----------

```python
def instancemethod(my_object, ...)
def classmethod(my_class, ...)
```

Це лише загальноприйняті позначення, яких дотримуються всі. Проте вони
мають бути першими в списку параметрів.

Викличемо статичний метод:

```python
>>> obj.staticmethod()
static method called
```

Так, це може вас здивувати, але статичні методи можна викликати через
об’єкт класу. Виклик через крапку потрібен лише для зручності. Насправді
ж у разі статичного методу жодні аргументи (`self` або `cls`) методу не
передаються.

Тобто статичні методи не можуть отримати доступ до параметрів класу або
об’єкта. Вони працюють тільки з тими даними, які їм передаються як
аргументи.

Тепер давайте викличемо ті ж самі методи, але на самому класі.

```python
>>> ToyClass.classmethod()
('class method called', <class ToyClass at 0x10f453a10>)
>>> ToyClass.staticmethod()
'static method called'
>>> ToyClass.instancemethod()
TypeError: unbound method instancemethod() 
must be called with ToyClass instance as 
first argument (got nothing instead)
```

Метод класу і статичний метод працюють, як потрібно. Однак виклик методу
екземпляра класу видає TypeError, оскільки метод не може отримати на
вхід екземпляр класу.

Тепер, коли ви знаєте різницю між трьома видами методів, давайте
розглянемо реальний приклад для розуміння того, коли і який метод варто
використовувати.

```python
from datetime import date


class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    @classmethod
    def from_birth_year(cls, name, year):
        return cls(name, date.today().year - year)
    
    @staticmethod
    def is_adult(age):
        return age > 18

person1 = Person('Sarah', 25)
person2 = Person.from_birth_year('Roark', 1994)
>>> person1.name, person1.age
Sarah 25
>>> person2.name, person2.age
Roark 24
>>> Person.is_adult(25)
True
```

#### Коли використовувати кожен із методів?

Вибір того, який із методів використовувати, може здатися досить
складним. Проте з досвідом цей вибір робити набагато простіше.

Найчастіше метод класу використовується тоді, коли потрібен генеруючий
метод, що повертає об’єкт класу. Як бачимо, метод класу from_birth_year
використовується для створення об’єкта класу Person за роком народження,
а не віком.

Статичні методи здебільшого використовуються як допоміжні функції і
працюють з даними, які їм передаються.

### @property (властивість)

*Конвертація методу клас в атрибути тільки для читання.*

Один із найпростіших способів використання `property`, це
використовувати його як декоратор методу. Це дозволить вам перетворити
метод класу на атрибут класу.

Давайте поглянемо на простий приклад:

```python
class Person:
    def __init__(self, first_name, last_name):
        self.first_name = first_name
        self.last_name = last_name

    @property
    def full_name(self):
        """
        return full name
        """
        return f'{self.first_name} {self.last_name}'
```

У цьому коді ми створили два класи атрибута, або властивостей:
self.first_name і self.last_name.

Далі ми створили метод full_name, який містить декоратор `@property`. Це
дозволяє нам використовувати наступний код у сесії інтерпретатора:

```python
person = Person("Mike", "Driscoll")

print(person.full_name) # Mike Driscoll
print(person.first_name) # Mike

person.full_name = "Jackalope"
Traceback (most recent call last):
    File "<string>", line 1, in <fragment>
AttributeError: can't set attribute
```

Як ви бачите, в результаті перетворення методу на властивість, ми можемо
отримати до нього доступ за допомогою звичайної точкової нотації. Однак,
якщо ми спробуємо налаштувати властивість на щось інше, ми отримаємо
помилку `AttributeError`. Єдиний спосіб змінити властивість full_name,
це зробити це опосередковано:

```python
person.first_name = "Dan"
print(person.full_name) # Ден Дрісколл
```

Декоратори відкривають найширший простір для експериментів!

## Практика і домашнє завдання:

1.  Створити клас Candidate
2.  В `__init__` передавати
    1.  first name
    2.  last name
    3.  email
    4.  tech_stack
    5.  main_skill
    6.  main_skill_grade
3.  Створити `@property` метод який повертає first name + ‘ ‘ + last
    name
4.  Створити `@classmethod` generate_candidates, який приймає в якості
    аргументу шлях до файлу
5.  Метод generate_candidates має повертати список об’єктів класу
    Candidate  
    Файл [тут
    (тиць)](https://bitbucket.org/ivnukov/lesson2/raw/4f59074e6fbb552398f87636b5bf089a1618da0a/candidates.csv)
6.  \*\* Розширити метод generate_candidates, щоб він міг отримувати в
    якості аргументу URL на файл та генерувати кандидатів з нього

## Література

1.  [Primer on Python
    Decorators](https://realpython.com/primer-on-python-decorators/)
2.  [Об’єкт першого
    класу](https://uk.wikipedia.org/wiki/%D0%9E%D0%B1%27%D1%94%D0%BA%D1%82_%D0%BF%D0%B5%D1%80%D1%88%D0%BE%D0%B3%D0%BE_%D0%BA%D0%BB%D0%B0%D1%81%D1%83)
3.  [Python’s Functions Are
    First-Class](https://dbader.org/blog/python-first-class-functions)
4.  [The @property Decorator in Python (getter, setter,
    deleter)](https://www.freecodecamp.org/news/python-property-decorator/)
