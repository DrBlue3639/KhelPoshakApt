-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 11, 2026 at 04:32 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `khelposhak`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `description`) VALUES
(5, 'Country', 'Popular football countries known for their rich football history, legendary players, passionate fans, and successful international teams such as Brazil, Argentina, Germany, France, Spain, and England.'),
(6, 'Club', 'Popular football clubs recognized worldwide for their achievements, iconic players, massive fan base, and success in leagues and tournaments such as Real Madrid, FC Barcelona, Manchester United, Liverpool, Bayern Munich, and Paris Saint-Germain.');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `order_number` varchar(50) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `order_status` enum('PENDING','SHIPPED','DELIVERED','CANCELLED') DEFAULT 'PENDING',
  `payment_method` varchar(20) DEFAULT 'COD',
  `shipping_address` text NOT NULL,
  `phone` varchar(15) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `order_number`, `user_id`, `total_amount`, `order_status`, `payment_method`, `shipping_address`, `phone`, `order_date`) VALUES
(1, 'ORD-1777905732163', 26, 132.00, 'PENDING', 'Cash on Delivery', 'ok', '9989999', '2026-05-04 14:42:12'),
(2, 'ORD-1777905835637', 26, 366.00, 'PENDING', 'Credit Card', 'okkk', '99999', '2026-05-04 14:43:55'),
(3, 'ORD-1777906554309', 26, 2331.00, 'PENDING', 'Credit Card', 'ok', '98577575', '2026-05-04 14:55:54'),
(4, 'ORD-1777907093655', 26, 533.00, 'PENDING', 'Cash on Delivery', 'ok99', '9999', '2026-05-04 15:04:53'),
(5, 'ORD-1777912824795', 26, 33.00, 'PENDING', 'Credit Card', 'ok', '99', '2026-05-04 16:40:24'),
(6, 'ORD-1777951785933', 26, 33.00, 'PENDING', 'Cash on Delivery', 'ok', '999', '2026-05-05 03:29:45'),
(7, 'ORD-1777961305052', 26, 165.00, 'PENDING', 'Cash on Delivery', 'ok', '9999', '2026-05-05 06:08:25'),
(8, 'ORD-1778049308598', 25, 500.00, 'PENDING', 'Credit Card', 'ok', '999', '2026-05-06 06:35:08'),
(9, 'ORD-1778049349363', 25, 33.00, 'PENDING', 'Esewa', 'ok', '888', '2026-05-06 06:35:49'),
(10, 'ORD-1778058627628', 25, 1000.00, 'PENDING', 'Esewa', 'oak', '999', '2026-05-06 09:10:27');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size` varchar(5) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price_at_time` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `size`, `quantity`, `price_at_time`, `subtotal`) VALUES
(14, 1, 1, 'M', 2, 66.00, 132.00),
(15, 2, 2, 'L', 3, 122.00, 366.00),
(16, 3, 3, 'XL', 7, 333.00, 2331.00),
(17, 4, 4, 'S', 1, 533.00, 533.00),
(18, 5, 5, 'M', 1, 33.00, 33.00),
(19, 6, 5, 'S', 1, 33.00, 33.00),
(21, 1, 1, 'M', 2, 66.00, 132.00),
(22, 2, 1, 'L', 3, 122.00, 366.00),
(23, 3, 2, 'XL', 7, 333.00, 2331.00),
(24, 4, 1, 'S', 1, 533.00, 533.00),
(25, 5, 2, 'M', 1, 33.00, 33.00),
(26, 6, 1, 'S', 1, 33.00, 33.00),
(27, 7, 1, 'L', 1, 165.00, 165.00),
(28, 8, 1, 'XL', 2, 250.00, 500.00),
(29, 9, 2, 'M', 1, 33.00, 33.00),
(30, 10, 1, 'XXL', 2, 500.00, 1000.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `sport` varchar(50) DEFAULT NULL,
  `team` varchar(100) DEFAULT NULL,
  `player_name` varchar(100) DEFAULT NULL,
  `sizes_available` varchar(50) DEFAULT NULL,
  `stock_s` int(11) DEFAULT 0,
  `stock_m` int(11) DEFAULT 0,
  `stock_l` int(11) DEFAULT 0,
  `stock_xl` int(11) DEFAULT 0,
  `stock_xxl` int(11) DEFAULT 0,
  `category_id` int(11) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `sport`, `team`, `player_name`, `sizes_available`, `stock_s`, `stock_m`, `stock_l`, `stock_xl`, `stock_xxl`, `category_id`, `image_url`, `created_at`) VALUES
(1, 'Brazil Home Jersey 2026', 'Official-inspired Brazil national football team jersey with classic yellow design for passionate fans.', 3499.00, 'Football', 'Brazil', 'Neymar Jr', 'S,M,L,XL,XXL', 10, 15, 20, 12, 8, 5, 'no-image.jpg', '2026-05-08 08:11:23'),
(2, 'Argentina Home Jersey 2026', 'Premium Argentina football jersey featuring the iconic sky blue and white stripes.', 3599.00, 'Football', 'Argentina', 'Lionel Messi', 'S,M,L,XL,XXL', 12, 18, 22, 14, 10, 5, 'no-image.jpg', '2026-05-08 08:11:23'),
(3, 'Real Madrid Home Kit 2026', 'Modern Real Madrid football club jersey designed for comfort and performance.', 3999.00, 'Football', 'Real Madrid', 'Jude Bellingham', 'S,M,L,XL,XXL', 8, 14, 18, 10, 6, 6, 'no-image.jpg', '2026-05-08 08:11:23'),
(4, 'FC Barcelona Home Kit 2026', 'Official-inspired FC Barcelona jersey with the iconic blaugrana colors.', 3999.00, 'Football', 'FC Barcelona', 'Pedri', 'S,M,L,XL,XXL', 9, 16, 20, 12, 7, 6, 'no-image.jpg', '2026-05-08 08:11:23'),
(5, 'Liverpool Home Jersey 2026', 'Premium Liverpool football club jersey inspired by the iconic Anfield tradition and passionate supporters.', 3899.00, 'Football', 'Liverpool', 'Mohamed Salah', 'S,M,L,XL,XXL', 11, 17, 19, 13, 9, 6, 'no-image.jpg', '2026-05-08 08:11:23'),
(27, 'Nepal-Home-Jersey', 'Official-inspired Nepal national football team jersey featuring the iconic crimson red and blue design, made for passionate fans who proudly support the Gurkhas on and off the field.', 5000.00, 'football', 'Nepal', 'Akash', 'S,M,L,XL,XXL', 44, 4, 4, 7, 4, 5, 'product-images/20260511_155931_1778494471427.png', '2026-05-11 10:14:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `role` enum('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `phone`, `address`, `role`, `created_at`) VALUES
(24, 'akashadhikari', 'akashad@gmail.com', '$2a$10$OMv2xW6uAK4my/BTVDASWu7j1hJUUjF5gNp9Xa6SKagZsIbKugps.', '9999999999999', 'okkkkkkkk', 'CUSTOMER', '2026-05-01 04:40:51'),
(25, 'AkashAdhikari', 'apt@gmail.com', '$2a$10$A4H9irfKsuKXFAOurkrTqe6LA/3DKbwLMKBToWP2CB/P//Z9Tkbl2', '9861065860', 'pokhara', 'CUSTOMER', '2026-05-01 06:53:21'),
(26, 'Akashad', 'c@gmail.com', '$2a$10$786rKnzXT8Gx.jtQDIfDKuuXYHPwQkvgW0yR3kh3gxlfbCsMznUOa', '987676767676', 'per', 'CUSTOMER', '2026-05-01 06:55:47'),
(28, 'Akashadh', 'admin@gmail.com', '$2a$10$k8VspteVLcVEBiZVJdkVIO8SbgsnM0ywbpQeAuaRFLEbnHo9eLO0K', '9864000000', 'Pokhara', 'ADMIN', '2026-05-03 13:49:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
