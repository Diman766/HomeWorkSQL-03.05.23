USE homework_5;

CREATE TABLE Cars
(id SERIAL PRIMARY KEY, 
Name VARCHAR(255) NOT NULL,
Cost INT DEFAULT 0
);

INSERT INTO cars(Name, Cost)
VALUES
('Audi', 52642), ('Mercedes', 57127), ('Skoda', 9000), ('Volvo', 29000), ('Bentley', 350000),
('Citroen', 21000), ('Hummer', 41400), ('Volkswagen', 21600);

DROP VIEW Cars1;

CREATE VIEW Cars1 AS
SELECT id, Name, Cost
FROM Cars
WHERE Cost > 25000;

SELECT * FROM Cars1;

ALTER VIEW Cars1 AS
SELECT id, Name, Cost
FROM Cars
WHERE Cost > 30000;

SELECT * FROM Cars1;

DROP VIEW Cars2;

CREATE VIEW Cars2 AS
SELECT id, Name, Cost
FROM Cars
WHERE Name = 'Skoda' OR Name ='Audi';

SELECT * FROM Cars2;

CREATE TABLE Analysis
(an_id SERIAL PRIMARY KEY, 
an_name VARCHAR(40) NOT NULL,
an_cost INT DEFAULT 0,
an_price INT DEFAULT 0,
an_group VARCHAR(40) NOT NULL
);

INSERT INTO Analysis(an_name, an_cost, an_price, an_group)
VALUES
('эритроциты', 10, 50, 'Общеклинические'), ('лейкоциты', 10, 60, 'Общеклинические'),
('тромбоциты', 20, 100, 'Общеклинические'), ('плазмы', 10, 100, 'Общеклинические'), 
('белки', 40, 500, 'Биохимические'), ('углеводы', 50, 400, 'Биохимические'), 
('жиры', 10, 80, 'Биохимические'), ('Щетовидки', 45, 550, 'Гормональные'),
('надпочечникови', 15, 240, 'Гормональные'), ('гипофиза', 12, 314, 'Гормональные'),
('Туберкулез', 21, 347, 'Инфекционные'), ('Паротит', 24, 367, 'Инфекционные'),
('Корь', 42, 678, 'Инфекционные');

CREATE TABLE Groups_
(gr_id SERIAL PRIMARY KEY, 
gr_name VARCHAR(40) NOT NULL,
gr_temp INT DEFAULT 0
);

INSERT INTO Groups_(gr_name, gr_temp)
VALUES
('Общеклинические', -10), ('Биохимические', 0), ('Гормональные', -20),
('Инфекционные', 15);

DROP TABLES Orders;

CREATE TABLE Orders
(ord_id SERIAL PRIMARY KEY, 
ord_datatime DATETIME NOT NULL,
ord_an INT
-- FOREIGN KEY (ord_an) REFERENCES Analysis(an_id)
);

INSERT INTO Orders(ord_datatime, ord_an)
VALUES
(20200202103722, 2), (20200201143444, 1), (20200210153755, 4), (20200224112734, 1),
(20200217170011, 3), (20200227115633, 5);

DROP VIEW Test;

CREATE VIEW Test AS
SELECT an_name, an_price
FROM Analysis
WHERE an_id = (SELECT ord_an
FROM Orders
WHERE ord_datatime
BETWEEN '20200205000000' AND '20200211000000');

SELECT * FROM Test;

CREATE TABLE Trains
(train_id INT NOT NULL, 
station VARCHAR(20) NOT NULL,
station_time TIME NOT NULL
);

INSERT INTO Trains(train_id, station, station_time)
VALUES
(110, 'San Francisco', 100000), (110, 'Redwood City', 105400),
(110, 'Palo Alto', 110200), (110, 'San Jose', 123500),
(120, 'San Francisco', 110000), (120, 'Palo Alto', 124900),
(120,'San Jose', 133000);

SELECT *,
TIMEDIFF(LEAD(station_time, 1, 'end') 
OVER(PARTITION BY train_id ORDER BY station_time), station_time)
AS time_to_next_station_interval
FROM Trains;