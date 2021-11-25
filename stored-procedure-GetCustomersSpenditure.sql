CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomersSpenditure`(
	IN product varchar(255)
)
BEGIN
	SELECT 
	c.f_name AS 'First name',
	c.l_name AS 'Last name',
	pt.amount AS 'Amount spent'
	FROM customers c
	JOIN payments pt
		ON c.id = pt.cus_id;
END