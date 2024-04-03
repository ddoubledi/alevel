[12-postgresql-join.excalidraw](12-postgresql-join.excalidraw.md)

# PosgreSQL, відносини, складні запити, JOIN

# Зміст

- [Види логічного зв’язку (відношення між таблицями)](#%D0%92%D0%B8%D0%B4%D0%B8-%D0%BB%D0%BE%D0%B3%D1%96%D1%87%D0%BD%D0%BE%D0%B3%D0%BE-%D0%B7%D0%B2%D1%8F%D0%B7%D0%BA%D1%83-%D0%B2%D1%96%D0%B4%D0%BD%D0%BE%D1%88%D0%B5%D0%BD%D0%BD%D1%8F-%D0%BC%D1%96%D0%B6-%D1%82%D0%B0%D0%B1%D0%BB%D0%B8%D1%86%D1%8F%D0%BC%D0%B8)
- [Об’єднання (JOINS)](#%D0%9E%D0%B1%D1%94%D0%B4%D0%BD%D0%B0%D0%BD%D0%BD%D1%8F-joins)
	- [`CASE`](#case)
	- [Коментарі](#%D0%9A%D0%BE%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%D1%80%D1%96)
- [Практика](#%D0%9F%D1%80%D0%B0%D0%BA%D1%82%D0%B8%D0%BA%D0%B0)
- [Домашнє завдання:](#%D0%94%D0%BE%D0%BC%D0%B0%D1%88%D0%BD%D1%94-%D0%B7%D0%B0%D0%B2%D0%B4%D0%B0%D0%BD%D0%BD%D1%8F)
- [Література та Корисні посилання](#%D0%9B%D1%96%D1%82%D0%B5%D1%80%D0%B0%D1%82%D1%83%D1%80%D0%B0-%D1%82%D0%B0-%D0%9A%D0%BE%D1%80%D0%B8%D1%81%D0%BD%D1%96-%D0%BF%D0%BE%D1%81%D0%B8%D0%BB%D0%B0%D0%BD%D0%BD%D1%8F)


## Види логічного зв’язку (відношення між таблицями)

Зв’язок встановлюється між двома загальними полями (стовпцями) двох таблиць.

Відносини, які можуть існувати між записами двох таблиць:

1.  **One-to-one** (1:1) _**один-до-одного**_ — кожному запису з однієї таблиці відповідає один запис у іншій таблиці; створюється в тому випадку, коли обидва поля є ключовими або мають унікальні індекси.  ![](attachments/Pasted%20image%2020240403102811.png)
2.  **One-to-many** (1:N) ***один-до-багатьох*** — кожному запису з однієї таблиці відповідає кілька записів у іншій таблиці; створюється в тому випадку, коли тільки одне з полів є полем первинного ключа або унікального індексу.  _**багато-до-одного**_ — безлічі записів з однієї таблиці відповідає один запис у іншій таблиці;![](attachments/Pasted%20image%2020240403102852.png)
4.  **Many-to-many** (N:N) _**багато-до-багатьох**_ — безліч записів з однієї таблиці відповідає кілька записів в іншій таблиці; фактично є двома відносинами «один-до-багатьох» з третьої таблицею, первинний ключ якої складається з полів зовнішнього ключа двох інших таблиць. ![](attachments/Pasted%20image%2020240403102909.png)

![](attachments/Pasted%20image%2020240403102919.png)

## Об’єднання (JOINS)

![](attachments/Pasted%20image%2020240403102927.png)

Запити до однієї таблиці досить рідкісні. Найчастіше запити до баз даних пишуться з метою отримати інформацію з кількох таблиць, інформація з яких поєднується за певними умовами.

![](attachments/Pasted%20image%2020240403102936.png)

Створимо таблиці авторів, книг, жанрів та таблицю зв’язків для авторів та книг (Many-to-many):

```sql
CREATE TABLE authors  
(  
    id SERIAL PRIMARY KEY,  
    name VARCHAR(200) NOT NULL,  
    year DATE         NOT NULL DEFAULT '1970-01-01'  
);  
  
CREATE TABLE genres  
(  
    id SERIAL PRIMARY KEY,  
    genre VARCHAR(100) NOT NULL  DEFAULT 0
);  
  
CREATE TABLE books  
(  
    id SERIAL PRIMARY KEY,  
    title VARCHAR(200) NOT NULL,  
    genre_id INT          NOT NULL REFERENCES genres (id)  
);  
  
  
CREATE TABLE authors_books  
(  
    id SERIAL PRIMARY KEY,  
    author_id INT NOT NULL REFERENCES authors (id),  
    book_id INT NOT NULL REFERENCES books (id)  
);
```

Далі слід заповнити таблицю даними:

```sql
INSERT INTO genres (genre) VALUES
	('SF'),
	('novel'),
	('story'),
	('horror');

INSERT INTO books(title, genre_id) VALUES
	('Майстер і Маргарита', 2),
	('Фауст', 0),
	('Білий клик', 3),
	('Дюна', 1),
	('Острів скарбів', 2),
	('Залізна п''ята', 3),
	('Дракон у морі', 1);

INSERT INTO authors (name) VALUES
	('Френк Герберт'),
	('Михайло Булгаков'), 
	('Джек Лондон'), 
	('Йоган Ґете'), 
	('Роберт Хайнлайн');

INSERT INTO authors_books (author_id, book_id) VALUES 
	(1, 4),
	(1, 7),
	(2, 1),
	(3, 3),
	(3, 6),
	(4, 2);
```

Дані готові, тепер можна вивчати об’єднання таблиць. Почнемо ми з об’єднання двох таблиць в одному запиті:

```sql
SELECT title, genre
FROM books
INNER JOIN genres ON (genres.id = books.genre_id);

       title         | genre
---------------------+-------
 Майстер і Маргарита | novel
 Білий клик          | story
 Дюна                | SF
 Острів скарбів      | novel
 Залізна п'ята       | story
 Дракон у морі       | SF
(6 rows)

```
*   Для відображення назви колонок на кількості рядків треба виконати команду `\t`

**`INNER JOIN`** виводить записи з лівої таблиці (першої з двох таблиць, які він об’єднує), для яких знайдеться відповідний запис у правій (другій та останній у списку) таблиці. Якщо відповідності у правій таблиці немає, такий запис не виводиться. В даному випадку можна бачити, що запис про книгу “Фауст” не виводиться. Це відбувається через те, що `genre_id` цей запис дорівнює нулю, а такого жанру в таблиці жанрів немає.  
Так само в результат не потрапляє жанр horror, тому що немає жодної книги з таким жанром.

```sql
SELECT title, genre
FROM books
LEFT JOIN genres ON (genres.id = books.genre_id);

       title         | genre
---------------------+-------
 Майстер і Маргарита | novel
 Фауст               |
 Білий клик          | story
 Дюна                | SF
 Острів скарбів      | novel
 Залізна п'ята       | story
 Дракон у морі       | SF
(7 rows)

```

**`LEFT JOIN`** виводить **ВСІ** записи з лівої таблиці. Для тих записів, яким знаходиться відповідність у правій, він, аналогічно **INNER JOIN**, виведе відповідні дані з другої таблиці. Для тих, яким відповідності не знайшлося, він нічого не виведе в стовпцях правої таблиці, залишивши їх порожніми.

Щоб визначити, яким книгам не знайдені у відповідність жанри, можна виконати запит із підзапитом:

```sql
SELECT title
FROM books
WHERE NOT EXISTS (
	SELECT * 
	FROM genres 
	WHERE books.genre_id = genres.id
);

 title
-------
 Фауст
(1 row)
```

Цей шлях вважається правильнішим, ніж класичний:

```sql
SELECT title, genre 
FROM books 
LEFT JOIN genres ON (genres.id = books.genre_id)
WHERE genre IS NULL;


 title| genre
 -----+-------
 Фауст | NULL
(1 row)

```

**`RIGHT JOIN`** надходить аналогічним чином з правою таблицею: виводить усі записи з неї, додаючи записи з лівої. Де відповідності немає, залишає в стовпцях лівої таблиці порожнечу.

```sql
SELECT title, genre
FROM books
RIGHT JOIN genres ON (genres.id = books.genre_id);

       title         | genre
---------------------+--------
 Майстер і Маргарита | novel
 Білий клик          | story
 Дюна                | SF
 Острів скарбів      | novel
 NULL                | horror
(5 rows)
```
Якщо у вас виникне потреба побачити всі книги та всі жанри незалежно від наявності відповідних записів в іншій таблиці, але де зв’язки є – зв’язати таблиці, можна об’єднати результати двох запитів за допомогою `UNION`:

```sql
SELECT title, genre 
FROM books 
LEFT JOIN genres ON (genres.id = books.genre_id) 
UNION 
SELECT title, genre 
FROM books RIGHT JOIN genres ON (genres.id = books.genre_id);


       title         | genre
---------------------+--------
 Фауст               | NULL
 NULL                | horror
 Острів скарбів      | novel
 Білий клик          | story
 Дюна                | SF
 Майстер і Маргарита | novel
(6 rows)
```

Аналогічного результату можна досягти і спеціальним видом об’єднань - **`FULL JOIN`**:

```sql
SELECT title, genre
FROM books
FULL JOIN genres ON (genres.id = books.genre_id);


       title         | genre
---------------------+--------
 Майстер і Маргарита | novel
 Фауст               | NULL
 Білий клик          | story
 Дюна                | SF
 Острів скарбів      | novel
 NULL                | horror 
(6 rows)
```

Якщо поля зв’язку називаються однаково, наприклад, поле `id` у таблиці `genres` називається `genre_id`, запит можна трохи спростити. Для демонстрації перейменуємо поле та виконаємо цей запит:

```sql
ALTER TABLE genres RENAME COLUMN id TO genre_id;


SELECT title, genre
FROM books 
RIGHT JOIN genres USING(genre_id);


       title         | genre
---------------------+--------
 Майстер і Маргарита | novel
 Білий клик          | story
 Дюна                | SF
 Острів скарбів      | novel
 Залізна п'ята       | story
 Дракон у морі       | SF
                     | horror                     
(7 rows)

```

### `CASE`

Вираз `CASE` перевіряє умови та повертає значення, коли виконується перша умова (наприклад, інструкція if-then-else). Отже, як тільки умова виконується, вона припинить читання та поверне результат. Якщо жодна умова не виконується, повертається значення в пропозиції `ELSE`.  
[Детальніше](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-case/)

Якщо немає частини `ELSE` і немає умов, повертає NULL.

Результат буде той же, що і у звичайного `RIGHT JOIN` запиту, але сам запит коротше.

**Синтаксис**

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;
```

```sql
SELECT name,
CASE 
	WHEN COUNT(book_id) = 0 THEN 'None' 
ELSE CAST(COUNT(book_id) as varchar)
END as book_count
FROM authors
LEFT JOIN authors_books ON (authors.id = authors_books.author_id)
GROUP BY name;

       name       | book_count
------------------+------------
 Роберт Хайнлайн  | None
 Михайло Булгаков | 1
 Йоган Ґете       | 1
 Джек Лондон      | 2
 Френк Герберт    | 2
(5 rows)

```

### Коментарі

_Коментарі_ — це рядки тексту в коді, які допомагають усім, хто його читає, краще зрозуміти, що й навіщо робить код. Коментарі повністю ігноруються (тобто не виконуються) системами управління базами даних (СУБД).

**Однорядкові коментарі**  
У SQL подвійне тире `--` використовується для написання однорядкового коментаря.

```sql
-- Отримання всіх даних з таблиці Students
SELECT *
FROM Students;
```

**Коментарі на одному рядку з кодом**  
Також можна писати коментарі на одному рядку із SQL-командами. Наприклад:

```sql
SELECT * -- вибираємо всі дані
FROM Students; -- з таблиці Students
```
**Багаторядкові коментарі**  
В SQL багаторядкові коментарі починаються з /\* і закінчуються \*/. Наприклад:

```sql
/* Вибираємо всі дані
з таблиці Students */
SELECT *
FROM Students;
```

**Коментарі всередині рядків коду**  
Подібно до однорядкових коментарів, багаторядкові коментарі можна поміщати безпосередньо в рядки SQL-коду. Наприклад:

```sql
SELECT *
FROM /* тут ім'я таблиці */ Students;
```

## Практика

1.  Об’єднати авторів із назвами книг за допомогою таблиці зв’язків
2.  [https://github.com/pthom/northwind\_psql](https://github.com/pthom/northwind_psql)

```sql
CREATE TABLE authors_books_1 (
	id SERIAL PRIMARY KEY,
	author_id INT NOT NULL DEFAULT 0,
	book_id INT NOT NULL DEFAULT 0,
	CONSTRAINT fk_books
	 FOREIGN KEY(book_id) 
	  REFERENCES books(id)
	   ON DELETE CASCADE, 
	CONSTRAINT fk_author
	 FOREIGN KEY(author_id) 
	  REFERENCES authors(id)
	   ON DELETE CASCADE
);
```
## Домашнє завдання:

1.  Практикуємо все, що пройдено на уроці.
2.  Переписати базу даних фільмів (із таблицями акторів, фільмів, режисерів), додавши `many-to-many` звʼязки
3.  Створити базу даних студенти-групи-викладачі-кафедри (students-groups-teachers-departments).  Заповнити даними:

```sql
INSERT INTO departments (name) VALUES
('Computer Science'),
('Mathematics'),
('Physics');

INSERT INTO teachers (first_name, last_name, department_id) VALUES
('John', 'Doe', 1),
('Jane', 'Smith', 2),
('Robert', 'Johnson', 3),
('Emily', 'Williams', 1),
('Michael', 'Brown', 2);

INSERT INTO groups (name, department_id) VALUES
('CS50', 1),
('Math101', 2),
('Phys101', 3),
('CS101', 1);

INSERT INTO students (first_name, last_name, group_id) VALUES
('Alice', 'Johnson', 1),
('Bob', 'Smith', 2),
('Charlie', 'Williams', 3),
('David', 'Brown', 1),
('Eva', 'Davis', 2),
('Frank', 'Miller', 3),
('Grace', 'Jones', 4),
('Henry', 'Anderson', 1),
('Ivy', 'Moore', 2),
('Jack', 'Taylor', 3),
('Kate', 'White', 4),
('Leo', 'Martin', 1),
('Mia', 'Young', 2),
('Noah', 'Lee', 3),
('Olivia', 'Harris', 4),
('Paul', 'Clark', 1),
('Quinn', 'Evans', 2),
('Ryan', 'Wright', 3),
('Sophia', 'Walker', 4),
('Tyler', 'Hill', 1);
```

Зробити наступні запити:

1.  Вивести ім’я та прізвище студентів разом із назвами їх груп
2.  Отримати список викладачів та назви кафедр, на яких вони працюють
3.  Вивести кількість студентів у кожній групі
4.  Вивести назву кафедри, імʼя та прізвище викладача, назву групи, імʼя та прізвище студента для викладачів із прізвищем Smith, Williams та Johnson, відсортувати за групою на прізвищем студента. Застосувати JOIN для з’єднання даних з усіх чотирьох таблиць на основі відповідних зовнішніх ключів.

## Література та Корисні посилання

1.  [Introduction to PostgreSQL Foreign Key Constraint](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-foreign-key/)

