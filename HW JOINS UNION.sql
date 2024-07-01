--1. Îòîáðàçèòü íàçâàíèÿ èçäàòåëüñòâ, êîòîðûå âûïóñòèëè êíèãè ñî ñðåäíèì êîëè÷åñòâîì ñòðàíèö áîëüøèì 100.
--2. Âûâåñòè îáùóþ ñóììó ñòðàíèö âñåõ èìåþùèõñÿ â áèáëèîòåêå êíèã, âûïóùåííûõ èçäàòåëüñòâàìè BHV è ÁÈÍÎÌ.
--3. Íàéòè âñåõ ñòóäåíòîâ, êòî íà äàííûé ìîìåíò ðàáîòàåò ñ êíèãîé "Ðååñòð Windows 2000" àâòîðà Îëüãà Êîêîðåâà.
--4. Îòîáðàçèòü âñåõ ïîñåòèòåëåé áèáëèîòåêè (è ñòóäåíòîâ è ïðåïîäà-âàòåëåé) è êíèãè, êîòîðûå îíè áðàëè.
--5. Âûâåñòè ñàìîãî ïîïóëÿðíîãî àâòîðà(îâ) ñðåäè ñòóäåíòîâ è êîëè÷å-ñòâî êíèã ýòîãî àâòîðà, âçÿòûõ â áèáëèîòåêå.
--6. Âûâåñòè ñàìîãî ïîïóëÿðíîãî àâòîðà(îâ) ñðåäè ïðåïîäàâàòå-ëåé è êîëè÷åñòâî êíèã ýòîãî àâòîðà, âçÿòûõ â áèáëèîòåêå.
--7. Ïîêàçàòü âñåõ ñòóäåíòîâ è ïðåïîäàâàòåëåé äèçàéíåðîâ.
--8. Ïîêàçàòü ñêîëüêî êíèã âûäàë êàæäûé èç áèáëèîòåêàðåé.

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
WHERE Press.Name IN ('BHV', 'Binom')

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

