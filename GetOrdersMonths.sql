CREATE PROCEDURE GetOrdersOver (
	IN numMonth int
)
BEGIN
	SELECT * 
	FROM orders
	WHERE MONTH(order_date) >= MONTH(current_date()) - numMonth;
END
