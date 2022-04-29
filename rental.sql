/*Q1*/
INSERT INTO rental_records VALUES
 (NULL,
 'SBA1111A', 
 (SELECT customer_id FROM customers WHERE name='Angel'),
 CURDATE(), DATE_ADD(CURDATE(), INTERVAL 10 DAY),
NULL);
/*Q2*/
INSERT INTO rental_records VALUES
 (NULL,
'GA5555E',
 (SELECT customer_id FROM customers WHERE name='Kumar'),
 CURDATE() + 1,
DATE_ADD(CURDATE() + 1, INTERVAL 3 month),
NULL);
/*Q3*/
SELECT
a.start_date AS `Start Date`,
a.end_date AS `End Date`,
a.veh_reg_no AS `Vehicle No`,
b.brand AS `Vehicle Brand`,
c.name AS `Customer Name`
FROM rental_records AS a
INNER JOIN vehicles AS b USING (veh_reg_no)
INNER JOIN customers AS c USING (customer_id)
ORDER BY b.category, start_date;
/*Q4*/
SELECT * FROM rental_records
WHERE end_date < curdate();
/*Q5*/
SELECT veh_reg_no, name, start_date, end_date FROM rental_records
INNER JOIN customers USING (customer_id)
WHERE start_date < '2012-01-10' AND end_date > '2012-01-10';
/*Q6*/
SELECT DISTINCT veh_reg_no, name, start_date, end_date FROM rental_records
INNER JOIN customers USING (customer_id)
WHERE start_date = curdate();
/*Q7*/
SELECT veh_reg_no, name, start_date, end_date FROM rental_records
INNER JOIN customers USING (customer_id)
WHERE (start_date > '2012-01-03' AND start_date < '2012-01-18') or
(end_date < '2012-01-03' AND end_date < '2012-01-18') or 
(start_date < '2012-01-03' AND end_date > '2012-01-18');
/*Q8*/
SELECT veh_reg_no, brand, vehicles.desc FROM vehicles
LEFT JOIN rental_records USING (veh_reg_no)
WHERE veh_reg_no NOT IN (
	SELECT veh_reg_no FROM rental_records
	WHERE start_date < '2012-01-10' AND end_date > '2012-01-10'
);
/*Q9*/
SELECT veh_reg_no, brand, vehicles.desc FROM vehicles
LEFT JOIN rental_records USING (veh_reg_no)
WHERE veh_reg_no NOT IN (
	SELECT veh_reg_no FROM rental_records
    WHERE (start_date > '2012-01-03' AND start_date < '2012-01-18') or
	(end_date < '2012-01-03' AND end_date < '2012-01-18') or 
	(start_date < '2012-01-03' AND end_date > '2012-01-18')
);
/*Q10*/
SELECT DISTINCT 
vehicles.veh_reg_no AS 'registration number',
vehicles.brand AS 'brand',
vehicles.desc AS  DESCRIPTION 
FROM vehicles
LEFT JOIN rental_records
ON vehicles.veh_reg_no = rental_records.veh_reg_no
WHERE vehicles.veh_reg_no NOT IN   (
SELECT veh_reg_no 
FROM rental_records 
WHERE rental_records.start_date BETWEEN curdate() AND date_add(curdate(), INTERVAL 10 day))

