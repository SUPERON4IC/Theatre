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




/* ����� ������ � ��������� */
CREATE TABLE TakePartIn
(CONSTRAINT EC_TakePartIn CONNECTION (Actor TO Perfomance)) AS EDGE 

/* ������� ������� ���������*/
CREATE TABLE IsWatchedBy
(
RowOfViewer INT NOT NULL,
SeatOfViewer INT NOT NULL,
CONSTRAINT EC_IsWatchedBy CONNECTION (Perfomance TO Viewer)
) AS EDGE   


/*  ������� ����� �������(����������) ������(�) �� �����������*/
CREATE TABLE GivePresentTo 
(
DescriptionPresent NVARCHAR(100),
CONSTRAINT EC_BringFlowers CONNECTION (Viewer TO Actor)
) AS EDGE 

/*������� ������ ����� �����*/
CREATE TABLE FriendWith
(CONSTRAINT EC_FriendWith CONNECTION (Viewer TO Viewer)) AS EDGE



/* ���������� ����� */
INSERT INTO Actor (ActorID, firstName, lastName)
VALUES  (1, '������', '�������'),
		(2, '���������', '������'),
		(3, '�����', '���������'),
		(4, '������', '��������'),
		(5, '�����', '���������'),
		(6, '�������', '��������'),
		(7, '�������', '�����'),
		(8, '������', '�����'),
		(9, '�����������', '�����'),
		(10, '������', '������� ');

INSERT INTO Viewer (ViewerID, InfoName)
VALUES  (1, '������� 1'),
		(2, '������� 2'),
		(3, '������� 3'),
		(4, '������� 4'),
		(5, '������� 5'),
		(6, '������� 6'),
		(7, '������� 7'),
		(8, '������� 8'),
		(9, '������� 9'),
		(10, '������� 10');
		
INSERT INTO Perfomance (PerfomanceID, PerfomanceDate, PerfomanceName)
VALUES  (1, '2025-05-08 19:00', '������'),
        (2, '2025-05-15 20:00', '������ ���'),
		(3, '2025-05-22 18:30', '������'),
		(4, '2025-05-29 20:00', '����� � ���������'),
		(5, '2025-06-05 19:30', '������'),
		(6, '2025-06-12 20:00', '����������� ����'),
		(7, '2025-06-19 19:00', '��� � ������ ����'),
		(8, '2025-06-26 20:30', '��������� ����������'),
		(9, '2025-07-03 19:00', '������ III'),
		(10, '2025-07-10 20:00', '����');

		

/*���������� �����*/
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
VALUES  ((SELECT $node_id FROM Viewer WHERE ViewerID = 1),(SELECT $node_id FROM Actor WHERE ActorID = 6 ), '�����'),
        ((SELECT $node_id FROM Viewer WHERE ViewerID = 1),(SELECT $node_id FROM Actor WHERE ActorID = 8 ), '����� �� ���������� ����������'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 2),(SELECT $node_id FROM Actor WHERE ActorID = 4 ), '�����'),
        ((SELECT $node_id FROM Viewer WHERE ViewerID = 2),(SELECT $node_id FROM Actor WHERE ActorID = 10 ), '�����'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 3),(SELECT $node_id FROM Actor WHERE ActorID = 4 ), '�������'),
        ((SELECT $node_id FROM Viewer WHERE ViewerID = 3),(SELECT $node_id FROM Actor WHERE ActorID = 1 ), '�����'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 4),(SELECT $node_id FROM Actor WHERE ActorID = 5 ), '����������'),
        ((SELECT $node_id FROM Viewer WHERE ViewerID = 5),(SELECT $node_id FROM Actor WHERE ActorID = 4 ), '�����'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 6),(SELECT $node_id FROM Actor WHERE ActorID = 2 ), '������'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 6),(SELECT $node_id FROM Actor WHERE ActorID = 3 ), '�����'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 7),(SELECT $node_id FROM Actor WHERE ActorID = 10 ), '�������'),

        ((SELECT $node_id FROM Viewer WHERE ViewerID = 8),(SELECT $node_id FROM Actor WHERE ActorID = 9 ), '�����'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 9),(SELECT $node_id FROM Actor WHERE ActorID = 7 ), '�������'),
		((SELECT $node_id FROM Viewer WHERE ViewerID = 10),(SELECT $node_id FROM Actor WHERE ActorID = 2 ), '�������� �������');



/* ����� ������� ������ ������� ������ ����� ��� ���������� */
SELECT 
    Viewer.InfoName AS [�������],
    Actor.FirstName + ' ' +  Actor.LastName AS [�����],
    GivePresentTo.DescriptionPresent AS [�������],
    Perfomance.PerfomanceName AS [����� ���������]
FROM
    Viewer,
    Actor,
    Perfomance,
    GivePresentTo,
    IsWatchedBy
WHERE
    MATCH(Perfomance-(IsWatchedBy)->Viewer
	AND Viewer-(GivePresentTo)->Actor)
    AND GivePresentTo.DescriptionPresent = '�����'
ORDER BY Viewer.InfoName 
GO

/*����� ������ ������ � ����������, ������� ��������� � ������������ ����?*/
SELECT
    Actor.FirstName + ' ' + Actor.LastName AS [�����],
    Perfomance.PerfomanceName AS [���������],
    Perfomance.PerfomanceDate AS [����]
FROM
    Actor,
    Perfomance,
    TakePartIn
WHERE
    MATCH(Actor-(TakePartIn)->Perfomance)
    AND Perfomance.PerfomanceDate = '2025-05-08 19:00' 
ORDER BY Actor.LastName;
GO


/*����� ������ �������� ������� �� ��������, ������� ������ � ������������ ����?*/
SELECT
    Actor.FirstName + ' ' + Actor.LastName AS [�����],
    Viewer.InfoName AS [�������],
    IsWatchedBy.RowOfViewer AS [���]
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

/*����� ������� ������ ������� �������, �������� � ������������ ���������?*/
SELECT
    Viewer.InfoName AS [�������],
    Actor.FirstName + ' ' + Actor.LastName AS [�����],
    Perfomance.PerfomanceName AS [���������],
	GivePresentTo.DescriptionPresent AS [�������]
FROM
    Viewer,
    Actor,
    Perfomance,
    GivePresentTo,
    TakePartIn
WHERE
    MATCH(Viewer-(GivePresentTo)->Actor-(TakePartIn)->Perfomance)
    AND Perfomance.PerfomanceName = '������' 
GO

/*����� ��������� �������� ������ ������������� �������?*/
SELECT
    Viewer.InfoName AS [���� �������],
    Perfomance.PerfomanceName AS [���������]
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

/*� ������ ������ ������ �������(�� ������ �����������)*/
SELECT  V1.InfoName AS [�������], 
		STRING_AGG(V2.InfoName, '->') WITHIN GROUP (GRAPH PATH) AS [������]
FROM    
	Viewer AS V1
	, FriendWith FOR PATH AS fw
	, Viewer FOR PATH AS V2
WHERE MATCH(SHORTEST_PATH(V1(-(fw)->V2)+))
AND V1.InfoName = '������� 2'
GO

SELECT  V1.InfoName AS [�������], 
		STRING_AGG(V2.InfoName, '->') WITHIN GROUP (GRAPH PATH) AS [������]
FROM    
	Viewer AS V1
	, FriendWith FOR PATH AS fw
	, Viewer FOR PATH AS V2
WHERE MATCH(SHORTEST_PATH(V1(-(fw)->V2){1,2}))
AND V1.InfoName = '������� 1'
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
