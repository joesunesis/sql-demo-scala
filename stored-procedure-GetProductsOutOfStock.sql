CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductsOutOfStock`()
BEGIN
	SELECT *
	FROM products
	WHERE quantity_in_stock = 0;
END