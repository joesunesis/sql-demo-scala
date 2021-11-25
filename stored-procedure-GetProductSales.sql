CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductSales`(
	IN product varchar(255)
)
BEGIN
	SELECT 
	p.`name` AS Product,
    ot.quantity * ot.unit_price AS 'Total Sales'
	FROM products p
	JOIN order_items ot
		ON p.id = ot.prod_id
	WHERE `name` = product;
END