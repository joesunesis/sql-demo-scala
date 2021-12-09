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


CREATE TABLE `payment_methods` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


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


CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sup_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `quantity_in_stock` int DEFAULT 0 NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_product_supplier` FOREIGN KEY (`sup_id`) REFERENCES `supplier` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `order_statuses` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


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


CREATE TABLE `order_items` (
  `order_id` int NOT NULL,
  `prod_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`order_id`,`prod_id`),
  CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products` FOREIGN KEY (`prod_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;