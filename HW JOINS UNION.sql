--1. Отобразить названия издательств, которые выпустили книги со средним количеством страниц большим 100.
--2. Вывести общую сумму страниц всех имеющихся в библиотеке книг, выпущенных издательствами BHV и БИНОМ.
--3. Найти всех студентов, кто на данный момент работает с книгой "Реестр Windows 2000" автора Ольга Кокорева.
--4. Отобразить всех посетителей библиотеки (и студентов и препода-вателей) и книги, которые они брали.
--5. Вывести самого популярного автора(ов) среди студентов и количе-ство книг этого автора, взятых в библиотеке.
--6. Вывести самого популярного автора(ов) среди преподавате-лей и количество книг этого автора, взятых в библиотеке.
--7. Показать всех студентов и преподавателей дизайнеров.
--8. Показать сколько книг выдал каждый из библиотекарей.

--1
SELECT DISTINCT Press.Name
FROM Books
JOIN Press ON Books.Id_Press = Press.Id
GROUP BY Press.Name
HAVING AVG(Books.Pages) > 100



--2
SELECT SUM(Books.Pages) AS TotalPages
FROM Books
JOIN Press ON Books.Id_Press = Press.Id
WHERE Press.Name IN ('BHV', 'Binom');

--3
SELECT Students.FirstName, Students.LastName, Books.Name AS BookName
FROM S_Cards
JOIN Students ON S_Cards.Id_Student = Students.Id
JOIN Books ON S_Cards.Id_Book = Books.Id
JOIN Authors ON Books.Id_Author = Authors.Id
WHERE Authors.FirstName = 'Olga' AND Authors.LastName = 'Kokoreva'
  AND Books.Name = 'Windows 2000 registry'


 --4
SELECT Students.FirstName, Students.LastName ,
       Books.Name AS BookName
FROM S_Cards
JOIN Students ON S_Cards.Id_Student = Students.Id
JOIN Books ON S_Cards.Id_Book = Books.Id
UNION ALL
SELECT Teachers.FirstName , Teachers.LastName ,
       Books.Name AS BookName
FROM S_Cards
JOIN Teachers ON S_Cards.Id_Student = Teachers.Id
JOIN Books ON S_Cards.Id_Book = Books.Id


--5
SELECT TOP 1 Authors.FirstName, Authors.LastName, COUNT(*) AS BooksCount
FROM S_Cards
JOIN Books ON S_Cards.Id_Book = Books.Id
JOIN Authors ON Books.Id_Author = Authors.Id
GROUP BY Authors.FirstName, Authors.LastName
ORDER BY BooksCount DESC



--6
SELECT TOP 1 Authors.FirstName, Authors.LastName, COUNT(*) AS BooksCount
FROM T_Cards
JOIN Books ON T_Cards.Id_Book = Books.Id
JOIN Authors ON Books.Id_Author = Authors.Id
GROUP BY Authors.FirstName, Authors.LastName
ORDER BY BooksCount DESC

--7
SELECT Students.FirstName, Students.LastName
FROM Students
JOIN Groups ON Students.Id_Group = Groups.Id
JOIN Faculties ON Groups.Id_Faculty = Faculties.Id
WHERE Faculties.Name = 'Web Design'
UNION
SELECT Teachers.FirstName, Teachers.LastName
FROM Teachers
JOIN Faculties ON Teachers.Id_Dep = Faculties.Id
WHERE Faculties.Name = 'Web Design'

--8
SELECT Libs.FirstName, Libs.LastName, COUNT(*) AS BooksCount
FROM S_Cards
JOIN Libs ON S_Cards.Id_Lib = Libs.Id
GROUP BY Libs.FirstName, Libs.LastName

