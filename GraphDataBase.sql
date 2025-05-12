USE master;

DROP DATABASE IF EXISTS Theatre;

CREATE DATABASE	Theatre;

USE Theatre;


CREATE TABLE Actor
(
ActorID INT NOT NULL PRIMARY KEY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
) AS NODE;


CREATE TABLE Viewer
(
ViewerID INT NOT NULL PRIMARY KEY,
InfoName NVARCHAR(50) NOT NULL,
) AS NODE;


CREATE TABLE Perfomance
(
PerfomanceID INT NOT NULL PRIMARY KEY,
PerfomanceName NVARCHAR(50) NOT NULL,
PerfomanceDate DATETIME NOT NULL,
) AS NODE;




/* Актер играет в спекткале */
CREATE TABLE TakePartIn
(CONSTRAINT EC_TakePartIn CONNECTION (Actor TO Perfomance)) AS EDGE 

/* Зритель смотрит спектакль*/
CREATE TABLE IsWatchedBy
(
RowOfViewer INT NOT NULL,
SeatOfViewer INT NOT NULL,
CONSTRAINT EC_IsWatchedBy CONNECTION (Perfomance TO Viewer)
) AS EDGE   


/*  Зритель дарит подарок(благодарит) актеру(а) за выступление*/
CREATE TABLE GivePresentTo 
(
DescriptionPresent NVARCHAR(100),
CONSTRAINT EC_BringFlowers CONNECTION (Viewer TO Actor)
) AS EDGE 

/*Зрители дружат между собой*/
CREATE TABLE FriendWith
(CONSTRAINT EC_FriendWith CONNECTION (Viewer TO Viewer)) AS EDGE



/* Заполнение узлов */
INSERT INTO Actor (ActorID, firstName, lastName)
VALUES  (1, 'Сергей', 'Бурунов'),
		(2, 'Александр', 'Петров'),
		(3, 'Алиса', 'Фрейндлих'),
		(4, 'Сергей', 'Безруков'),
		(5, 'Павел', 'Прилучный'),
		(6, 'Николай', 'Климович'),
		(7, 'Алексей', 'Чадов'),
		(8, 'Сергей', 'Оскар'),
		(9, 'Конастантин', 'Канов'),
		(10, 'Энтони', 'Хопкинс ');

INSERT INTO Viewer (ViewerID, InfoName)
VALUES  (1, 'Зритель 1'),
		(2, 'Зритель 2'),
		(3, 'Зритель 3'),
		(4, 'Зритель 4'),
		(5, 'Зритель 5'),
		(6, 'Зритель 6'),
		(7, 'Зритель 7'),
		(8, 'Зритель 8'),
		(9, 'Зритель 9'),
		(10, 'Зритель 10');
		
INSERT INTO Perfomance (PerfomanceID, PerfomanceDate, PerfomanceName)
VALUES  (1, '2025-05-08 19:00', 'Гамлет'),
        (2, '2025-05-15 20:00', 'Король Лир'),
		(3, '2025-05-22 18:30', 'Отелло'),
		(4, '2025-05-29 20:00', 'Ромео и Джульетта'),
		(5, '2025-06-05 19:30', 'Макбет'),
		(6, '2025-06-12 20:00', 'Двенадцатая ночь'),
		(7, '2025-06-19 19:00', 'Сон в летнюю ночь'),
		(8, '2025-06-26 20:30', 'Укрощение строптивой'),
		(9, '2025-07-03 19:00', 'Ричард III'),
		(10, '2025-07-10 20:00', 'Буря');

		

/*Заполнение ребер*/
INSERT INTO FriendWith ($from_id, $to_id)
VALUES  ((SELECT $node_id FROM Viewer WHERE ViewerID = 1),(SELECT $node_id FROM Viewer WHERE ViewerID = 2 )),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 1),(SELECT $node_id FROM Viewer WHERE ViewerID = 6 )),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 2),(SELECT $node_id FROM Viewer WHERE ViewerID = 7 )),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 4),(SELECT $node_id FROM Viewer WHERE ViewerID = 3 )),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 4),(SELECT $node_id FROM Viewer WHERE ViewerID = 1 )),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 6),(SELECT $node_id FROM Viewer WHERE ViewerID = 10 )),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 7),(SELECT $node_id FROM Viewer WHERE ViewerID = 9 )),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 8),(SELECT $node_id FROM Viewer WHERE ViewerID = 2 )),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 9),(SELECT $node_id FROM Viewer WHERE ViewerID = 3 )),	
		((SELECT $node_id FROM Viewer WHERE ViewerID = 10),(SELECT $node_id FROM Viewer WHERE ViewerID = 4 ));

INSERT INTO TakePartIn ($from_id, $to_id)
VALUES  ((SELECT $node_id FROM Actor WHERE ActorID = 1),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 2 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 2),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 1 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 2),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 2 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 2),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 6)),
		((SELECT $node_id FROM Actor WHERE ActorID = 3),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 1 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 4),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 2 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 4),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 6 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 4),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 7 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 5),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 4 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 5),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 7 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 5),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 8 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 6),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 7 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 6),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 3 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 7),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 8 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 7),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 9 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 7),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 10 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 8),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 3 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 8),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 7 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 9),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 4 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 10),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 5 )),
		((SELECT $node_id FROM Actor WHERE ActorID = 10),(SELECT $node_id FROM Perfomance WHERE PerfomanceID = 6 ));

	

INSERT INTO IsWatchedBy($from_id, $to_id, RowOfViewer, SeatOfViewer)
VALUES  ((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 1 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 6), 4, 22),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 1 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 10), 4, 21),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 2 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 10), 6, 10),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 2 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 3), 8, 14),

		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 3 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 1), 5, 12),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 4 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 8), 1, 2),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 4 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 4), 12, 18),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 5 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 7), 3, 16),

		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 6 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 10), 11, 15),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 6),(SELECT $node_id FROM Viewer WHERE ViewerID = 2), 13, 4),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 7 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 5), 5, 2),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 7 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 4), 1, 14),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 7 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 1), 8, 11),

		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 8 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 4), 6, 8),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 8 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 9), 8, 8),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 9 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 9), 10, 10),
		((SELECT $node_id FROM Perfomance WHERE PerfomanceID = 10 ),(SELECT $node_id FROM Viewer WHERE ViewerID = 9), 9, 6);

INSERT INTO GivePresentTo ($from_id, $to_id, DescriptionPresent)
VALUES  ((SELECT $node_id FROM Viewer WHERE ViewerID = 1),(SELECT $node_id FROM Actor WHERE ActorID = 6 ), 'Цветы'),
        ((SELECT $node_id FROM Viewer WHERE ViewerID = 1),(SELECT $node_id FROM Actor WHERE ActorID = 8 ), 'Ключи от новенького автомобиля'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 2),(SELECT $node_id FROM Actor WHERE ActorID = 4 ), 'Цветы'),
        ((SELECT $node_id FROM Viewer WHERE ViewerID = 2),(SELECT $node_id FROM Actor WHERE ActorID = 10 ), 'Цветы'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 3),(SELECT $node_id FROM Actor WHERE ActorID = 4 ), 'Конфеты'),
        ((SELECT $node_id FROM Viewer WHERE ViewerID = 3),(SELECT $node_id FROM Actor WHERE ActorID = 1 ), 'Цветы'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 4),(SELECT $node_id FROM Actor WHERE ActorID = 5 ), 'Комплимент'),
        ((SELECT $node_id FROM Viewer WHERE ViewerID = 5),(SELECT $node_id FROM Actor WHERE ActorID = 4 ), 'Цветы'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 6),(SELECT $node_id FROM Actor WHERE ActorID = 2 ), 'Коньяк'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 6),(SELECT $node_id FROM Actor WHERE ActorID = 3 ), 'Цветы'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 7),(SELECT $node_id FROM Actor WHERE ActorID = 10 ), 'Телефон'),

        ((SELECT $node_id FROM Viewer WHERE ViewerID = 8),(SELECT $node_id FROM Actor WHERE ActorID = 9 ), 'Цветы'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 9),(SELECT $node_id FROM Actor WHERE ActorID = 7 ), 'Картина'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 10),(SELECT $node_id FROM Actor WHERE ActorID = 2 ), 'Печатная машинка');



/* Какие зрители дарили подарки актеру после его спектаклей */
SELECT 
    Viewer.InfoName AS [Зритель],
    Actor.FirstName + ' ' +  Actor.LastName AS [Актер],
    GivePresentTo.DescriptionPresent AS [Подарок],
    Perfomance.PerfomanceName AS [После спектакля]
FROM
    Viewer,
    Actor,
    Perfomance,
    GivePresentTo,
    IsWatchedBy
WHERE
    MATCH(Perfomance-(IsWatchedBy)->Viewer
	AND Viewer-(GivePresentTo)->Actor)
    AND GivePresentTo.DescriptionPresent = 'Цветы'
ORDER BY Viewer.InfoName 
GO

/*Какие актеры играли в спектаклях, которые проходили в определенную дату?*/
SELECT
    Actor.FirstName + ' ' + Actor.LastName AS [Актер],
    Perfomance.PerfomanceName AS [Спектакль],
    Perfomance.PerfomanceDate AS [Дата]
FROM
    Actor,
    Perfomance,
    TakePartIn
WHERE
    MATCH(Actor-(TakePartIn)->Perfomance)
    AND Perfomance.PerfomanceDate = '2025-05-08 19:00' 
ORDER BY Actor.LastName;
GO


/*Какие актеры получали подарки от зрителей, которые сидели в определенном ряду?*/
SELECT
    Actor.FirstName + ' ' + Actor.LastName AS [Актер],
    Viewer.InfoName AS [Зритель],
    IsWatchedBy.RowOfViewer AS [Ряд]
FROM
    Actor,
    Viewer,
    Perfomance,
    GivePresentTo,
    IsWatchedBy
WHERE
    MATCH(Perfomance-(IsWatchedBy)->Viewer-(GivePresentTo)->Actor)
    AND IsWatchedBy.RowOfViewer = 1 
ORDER BY Actor.LastName;
GO

/*Какие зрители дарили подарки актерам, игравшим в определенном спектакле?*/
SELECT
    Viewer.InfoName AS [Зритель],
    Actor.FirstName + ' ' + Actor.LastName AS [Актер],
    Perfomance.PerfomanceName AS [Спектакль],
	GivePresentTo.DescriptionPresent AS [Подарок]
FROM
    Viewer,
    Actor,
    Perfomance,
    GivePresentTo,
    TakePartIn
WHERE
    MATCH(Viewer-(GivePresentTo)->Actor-(TakePartIn)->Perfomance)
    AND Perfomance.PerfomanceName = 'Гамлет' 
GO

/*Какие спектакли посещали друзья определенного зрителя?*/
SELECT
    Viewer.InfoName AS [Друг зрителя],
    Perfomance.PerfomanceName AS [Спектакль]
FROM
    Perfomance,
    Viewer,
    IsWatchedBy,
    FriendWith,
    Viewer AS MainViewer
WHERE
    MATCH(Perfomance-(IsWatchedBy)->MainViewer-(FriendWith)->Viewer)
    AND MainViewer.ViewerID = 4 
ORDER BY Viewer.InfoName


/*SHORTEST_PATH*/

/*С какими людьми связан человек(по теории рукопожатия)*/
SELECT  V1.InfoName AS [Зритель], 
		STRING_AGG(V2.InfoName, '->') WITHIN GROUP (GRAPH PATH) AS [Дружат]
FROM    
	Viewer AS V1
	, FriendWith FOR PATH AS fw
	, Viewer FOR PATH AS V2
WHERE MATCH(SHORTEST_PATH(V1(-(fw)->V2)+))
AND V1.InfoName = 'Зритель 2'
GO

SELECT  V1.InfoName AS [Зритель], 
		STRING_AGG(V2.InfoName, '->') WITHIN GROUP (GRAPH PATH) AS [Дружат]
FROM    
	Viewer AS V1
	, FriendWith FOR PATH AS fw
	, Viewer FOR PATH AS V2
WHERE MATCH(SHORTEST_PATH(V1(-(fw)->V2){1,2}))
AND V1.InfoName = 'Зритель 1'
GO

/*For Power BI*/

SELECT @@SERVERNAME
SELECT   A.ActorID AS IdFirst
		,A.LastName AS First
		,CONCAT(N'Actor', A.ActorID) AS [First image name]
		,P.PerfomanceID AS IdSecond
		,P.PerfomanceName AS Second
		,CONCAT(N'Performance', P.PerfomanceID) AS [Second image name]
FROM
	Actor AS A,
	TakePartIn AS tpi,
	Perfomance AS P
WHERE MATCH (A-(tpi)->P)


SELECT @@SERVERNAME
SELECT   V.ViewerID AS IdFirst
		,V.InfoName AS First
		,CONCAT(N'Viewer', V.ViewerID) AS [First image name]
		,A.ActorID AS IdSecond
		,A.LastName AS Second
		,CONCAT(N'Actor', A.ActorID) AS [Second image name]
		,gp.DescriptionPresent

FROM
	Viewer AS V,
	GivePresentTo AS gp,
	Actor AS A
WHERE MATCH (V-(gp)->A)


SELECT @@SERVERNAME
SELECT   V1.ViewerID AS IdFirst
		,V1.InfoName AS First
		,CONCAT(N'Viewer', V1.ViewerID) AS [First image name]
		,V2.ViewerID AS IdSecond
		,V2.InfoName AS Second
		,CONCAT(N'Viewer', V2.ViewerID) AS [Second image name]

FROM
	Viewer AS V1,
	FriendWith AS f,
	Viewer AS V2
WHERE MATCH(V1-(f)->V2)


SELECT @@SERVERNAME
SELECT   P.PerfomanceID AS IdFirst
		,P.PerfomanceName AS First
		,CONCAT(N'Performance', P.PerfomanceID) AS [First image name]
		,V.ViewerID AS IdSecond
		,V.InfoName AS Second
		,CONCAT(N'Viewer', V.ViewerID) AS [Second image name]
		,iwb.RowOfViewer
		,iwb.SeatOfViewer 
FROM
	Perfomance AS P,
	IsWatchedBy AS iwb,
	Viewer AS V
WHERE MATCH(P-(iwb)->V)
