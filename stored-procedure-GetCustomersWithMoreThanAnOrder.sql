CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomersWithMoreThanAnOrder`()
BEGIN
	SELECT 
	c.f_name AS 'First name',
	c.l_name AS 'Last name',
    MAX(o.cus_id) AS 'Number of orders'
	FROM customers c
	JOIN orders o
		ON c.id = o.cus_id
	WHERE MAX(o.cus_id) >= 1;
END