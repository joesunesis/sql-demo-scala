DROP DATABASE IF EXISTS `online_store`;
CREATE DATABASE `online_store`; 
USE `online_store`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;


CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `date_created` datetime DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `user`(`username`, `password`) VALUES ('Vinte','passcode');
SELECT @user1 := LAST_INSERT_ID();
INSERT INTO `user`(`username`, `password`) VALUES ('Myworks','password');
SELECT @user2 := LAST_INSERT_ID();


CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `f_name` varchar(50) NOT NULL,
  `l_name` varchar(50) NOT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `user_id` int NOT NULL,
  `date_created` datetime DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `customers`(`f_name`, `l_name`, `dob`, `phone`, `email`, `user_id`) VALUES ('joe','mar','1986-03-28','12345','email@mail.com',@user1);
SELECT @cus1 := LAST_INSERT_ID();
INSERT INTO `customers`(`f_name`, `l_name`, `dob`, `phone`, `email`, `user_id`) VALUES ('josh','sun','1986-04-13','78945','email@mail.com',@user2);
SELECT @cus2 := LAST_INSERT_ID();


CREATE TABLE `invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cus_id` int(11) NOT NULL,
  `number` varchar(50) NOT NULL,
  `invoice_total` decimal(9,2) NOT NULL,
  `payment_total` decimal(9,2) NOT NULL DEFAULT '0.00',
  `invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_invoice_customer` FOREIGN KEY (`cus_id`) REFERENCES `customers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `invoices`(`cus_id`, `number`, `invoice_total`, `payment_total`, `invoice_date`, `due_date`, `payment_date`) VALUES (@cus1, '953-3396', 101.79, 0.00, '2021-03-09', '2021-03-29', NULL);
SELECT @invoice1 := LAST_INSERT_ID();
INSERT INTO `invoices`(`cus_id`, `number`, `invoice_total`, `payment_total`, `invoice_date`, `due_date`, `payment_date`) VALUES (@cus2, '898-6735', 175.32, 8.18, '2021-06-11', '2021-07-01', '2021-02-12');
SELECT @invoice2 := LAST_INSERT_ID();


CREATE TABLE `payment_methods` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `payment_methods`(`name`) VALUES ('Credit Card');
SELECT @paym1 := LAST_INSERT_ID();
INSERT INTO `payment_methods`(`name`) VALUES ('Cash');
SELECT @paym2 := LAST_INSERT_ID();


CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cus_id` int NOT NULL,
  `invoice_id` int NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `payment_method` tinyint NOT NULL,
  `date` datetime DEFAULT current_timestamp NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_payment_customer` FOREIGN KEY (`cus_id`) REFERENCES `customers` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_payment_method` FOREIGN KEY (`payment_method`) REFERENCES `payment_methods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `payments`(`cus_id`, `invoice_id`, `amount`, `payment_method`) VALUES (@cus1, @invoice1, 8.18, @paym1);
INSERT INTO `payments`(`cus_id`, `invoice_id`, `amount`, `payment_method`) VALUES (@cus2, @invoice2, 74.55, @paym1);


CREATE TABLE `supplier` (
  `id` int Not null auto_increment,
    `sup_name` varchar(50) not null,
    `com_name` varchar(50) not null,
    `address` varchar(100) not null,
    `item` varchar(100) not null,
    `quantity` int not null,
    `date_created` DATETIME DEFAULT current_timestamp,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `supplier`(`sup_name`, `com_name`, `address`, `item`, `quantity`) VALUES ('Hettinger', 'LLC', 'Accra', 'Table', 49);
SELECT @sup1 := LAST_INSERT_ID();
INSERT INTO `supplier`(`sup_name`, `com_name`, `address`, `item`, `quantity`) VALUES ('Schinner', 'Predovic', 'Accra', 'Chair', 70);
SELECT @sup2 := LAST_INSERT_ID();


CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sup_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `quantity_in_stock` int DEFAULT 0 NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_product_supplier` FOREIGN KEY (`sup_id`) REFERENCES `supplier` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `products`(`sup_id`, `name`, `quantity_in_stock`, `unit_price`) VALUES (@sup1, 'Chair', 70, 1.21);
SELECT @prod1 := LAST_INSERT_ID();
INSERT INTO `products`(`sup_id`, `name`, `quantity_in_stock`, `unit_price`) VALUES (@sup2, 'Table', 49, 4.65);
SELECT @prod2 := LAST_INSERT_ID();


CREATE TABLE `order_statuses` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `order_statuses`(`name`) VALUES ('Processed');
SELECT @sta1 := LAST_INSERT_ID();
INSERT INTO `order_statuses`(`name`) VALUES ('Shipped');
SELECT @sta2 := LAST_INSERT_ID();
INSERT INTO `order_statuses`(`name`) VALUES ('Delivered');
SELECT @sta3 := LAST_INSERT_ID();


CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cus_id` int NOT NULL,
  `prod_id` int DEFAULT NULL,
  `sup_id` int DEFAULT NULL,
  `order_date` date NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `comments` varchar(2000) DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`cus_id`) REFERENCES `customers` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_order_statuses` FOREIGN KEY (`status`) REFERENCES `order_statuses` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_product` FOREIGN KEY (`prod_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_supplier` FOREIGN KEY (`sup_id`) REFERENCES `supplier` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `orders`(`cus_id`, `prod_id`, `sup_id`, `order_date`, `status`, `comments`, `shipped_date`) VALUES (@cus1, @prod1, @sup1,'2021-01-30', @sta1, NULL, NULL);
SELECT @order1 := LAST_INSERT_ID();
INSERT INTO `orders`(`cus_id`, `prod_id`, `sup_id`, `order_date`, `status`, `comments`, `shipped_date`) VALUES (@cus2, @prod2, @sup2,'2021-08-02', @sta2, NULL, '2021-08-03');
SELECT @order2 := LAST_INSERT_ID();


CREATE TABLE `order_items` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `prod_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`order_id`,`prod_id`),
  CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products` FOREIGN KEY (`prod_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `order_items` VALUES (@order1, @prod1, 4, 3.74);
INSERT INTO `order_items` VALUES (@order2, @prod2, 2, 9.10);