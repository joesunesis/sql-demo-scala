USE online_store;

-- Creating a user
INSERT INTO `user`(`username`, `password`) VALUES ('joe','passcode');
SELECT @user1 := LAST_INSERT_ID();
INSERT INTO `user`(`username`, `password`) VALUES ('Myworks','password');
SELECT @user2 := LAST_INSERT_ID();


-- Inserting customers 
INSERT INTO `customers`(`f_name`, `l_name`, `dob`, `phone`, `email`, `user_id`) VALUES ('joe','mar','1086-03-28','12345','email@mail.com',@user1);
SELECT @cus1 := LAST_INSERT_ID();
INSERT INTO `customers`(`f_name`, `l_name`, `dob`, `phone`, `email`, `user_id`) VALUES ('josh','sun','1986-04-13','78945','email@mail.com',@user2);
SELECT @cus2 := LAST_INSERT_ID();


-- Inserting invoices
INSERT INTO `invoices`(`cus_id`, `number`, `invoice_total`, `payment_total`, `invoice_date`, `due_date`, `payment_date`) VALUES (@cus1, '953-3396', 101.79, 0.00, '2021-03-09', '2021-03-29', NULL);
SELECT @invoice1 := LAST_INSERT_ID();
INSERT INTO `invoices`(`cus_id`, `number`, `invoice_total`, `payment_total`, `invoice_date`, `due_date`, `payment_date`) VALUES (@cus2, '898-6735', 175.32, 8.18, '2021-06-11', '2021-07-01', '2021-02-12');
SELECT @invoice2 := LAST_INSERT_ID();


-- Inserting payment methods
INSERT INTO `payment_methods`(`name`) VALUES ('Credit Card');
SELECT @paym1 := LAST_INSERT_ID();
INSERT INTO `payment_methods`(`name`) VALUES ('Cash');
SELECT @paym2 := LAST_INSERT_ID();
INSERT INTO `payment_methods`(`name`) VALUES ('Bank');
SELECT @paym3 := LAST_INSERT_ID();


-- Inserting payments
INSERT INTO `payments`(`cus_id`, `invoice_id`, `amount`, `payment_method`) VALUES (@cus1, @invoice1, 8.18, @paym3);
INSERT INTO `payments`(`cus_id`, `invoice_id`, `amount`, `payment_method`) VALUES (@cus2, @invoice2, 74.55, @paym1);


-- Inserting supplier
INSERT INTO `supplier`(`sup_name`, `com_name`, `address`, `item`, `quantity`) VALUES ('Hettinger', 'LLC', 'Accra', 'Table', 49);
SELECT @sup1 := LAST_INSERT_ID();
INSERT INTO `supplier`(`sup_name`, `com_name`, `address`, `item`, `quantity`) VALUES ('Schinner', 'Predovic', 'Accra', 'Chair', 70);
SELECT @sup2 := LAST_INSERT_ID();


-- Inserting products
INSERT INTO `products`(`sup_id`, `name`, `quantity_in_stock`, `unit_price`) VALUES (@sup1, 'Chair', 70, 1.21);
SELECT @prod1 := LAST_INSERT_ID();
INSERT INTO `products`(`sup_id`, `name`, `quantity_in_stock`, `unit_price`) VALUES (@sup2, 'Table', 49, 4.65);
SELECT @prod2 := LAST_INSERT_ID();


-- Inserting order status
INSERT INTO `order_statuses` VALUES (1,'Processed');
SELECT @sta1 := LAST_INSERT_ID();
INSERT INTO `order_statuses` VALUES (2, 'Shipped');
SELECT @sta2 := LAST_INSERT_ID();
INSERT INTO `order_statuses` VALUES (3, 'Delivered');
SELECT @sta3 := LAST_INSERT_ID();


-- Inserting orders
INSERT INTO `orders`(`cus_id`, `prod_id`, `sup_id`, `order_date`, `status`, `comments`, `shipped_date`) VALUES (@cus1, @prod1, @sup1,'2021-01-30', @sta1, NULL, NULL);
SELECT @order1 := LAST_INSERT_ID();
INSERT INTO `orders`(`cus_id`, `prod_id`, `sup_id`, `order_date`, `status`, `comments`, `shipped_date`) VALUES (@cus2, @prod2, @sup2,'2021-08-02', @sta2, NULL, '2021-08-03');
SELECT @order2 := LAST_INSERT_ID();


-- Inserting order items
INSERT INTO `order_items` VALUES (@order1, @prod1, 4, 3.74);
INSERT INTO `order_items` VALUES (@order2, @prod2, 2, 9.10);