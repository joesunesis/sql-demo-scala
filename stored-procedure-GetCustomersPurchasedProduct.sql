CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomersPurchasedProduct`(
	IN product varchar(255)
)
BEGIN
	SELECT 
	c.f_name AS 'First name',
	c.l_name AS 'Last name',
    p.`name` AS 'Product Purchased'
	FROM customers c
	JOIN orders o
		ON c.id = o.cus_id
			JOIN products p
				ON p.id = o.prod_id
	WHERE `name` = product;
END