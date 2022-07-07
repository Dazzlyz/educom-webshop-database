-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 07, 2022 at 06:56 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `menno_webshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(8) NOT NULL,
  `product` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(8) NOT NULL,
  `user` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `product`, `quantity`, `user`) VALUES
(13, 'orange', 1, 'Geert Weggemans'),
(14, 'orange', 1, 'Geert Weggemans'),
(15, '', 5, 'Geert Weggemans'),
(16, 'apple', 1, 'Geert Weggemans'),
(17, 'kiwi', 2, 'Geert Weggemans'),
(18, 'grape', 1, 'Geert Weggemans'),
(19, 'orange', 1, 'Geert Weggemans'),
(20, 'orange', 3, 'coach@man-kind.nl'),
(21, 'orange', 3, 'coach@man-kind.nl'),
(22, 'orange', 3, 'coach@man-kind.nl'),
(23, 'apple', 1, 'coach@man-kind.nl'),
(24, 'apple', 1, 'coach@man-kind.nl'),
(25, 'kiwi', 1, 'coach@man-kind.nl'),
(26, 'apple', 3, 'coach@man-kind.nl'),
(27, 'apple', 1, 'menno.vandenbosch@outlook.com'),
(28, 'banana', 1, 'menno.vandenbosch@outlook.com'),
(29, '0', 1, 'menno.vandenbosch@outlook.com'),
(30, '1', 1, 'menno.vandenbosch@outlook.com'),
(31, 'apple', 1, 'menno.vandenbosch@outlook.com'),
(32, 'banana', 1, 'menno.vandenbosch@outlook.com'),
(33, 'grape', 2, 'menno.vandenbosch@outlook.com');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(8) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `filename`) VALUES
(1, 'apple', 'One red apple', '1', 'apple.jpg'),
(2, 'banana', 'One yellow banana', '2', 'banana.jpg'),
(3, 'grape', 'One purple grape', '0.5', 'grape.jpg'),
(4, 'kiwi', 'One green kiwi', '1.5', 'kiwi.jpg'),
(5, 'orange', 'One orange orange', '3', 'orange.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(8) UNSIGNED NOT NULL,
  `mail` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `mail`, `name`, `password`) VALUES
(12, 'coach@man-kind.nl', 'Geert Weggemans', 'halt!'),
(15, 'Dazzly@man-kind.nl', 'Dazzly', 'Quincy'),
(16, 'menno.vandenbosch@outlook.com', 'Menno van den Bosch', 'Hallo'),
(17, 'Test@gmail.com', 'Test persoon', 'Test'),
(18, 'menno.vandenbosch@outlook.nl', 'Men-no', 'Hallo'),
(19, 'menno.vandenbosch@outlook.uk', 'Menno van den Bosch', 'test'),
(20, 'menno.vandenbosch@outlook.test', 'Menno van den Bosch', 'test'),
(21, 'menno.vandenbosch@outlook.fout', 'Menno van den Bosch', 'test'),
(22, 'coach@man-kind.test', 'Menno', 'halt!'),
(23, 'coach@man-kind.nu', 'Menno', 'halt!'),
(24, 'coach@man-kind.io', 'Menno', 'halt!'),
(25, 'coach@man-kind.oops', 'Menno', 'halt!'),
(26, 'menno.vandenbosch@outlook.tust', 'Menno van den Bosch', 'test'),
(27, 'coach@man-kind.ioppe', 'Menno van den Bosch', 'halt!'),
(28, 'coach@man-kind.nlwegw', 'Menno van den Bosch', 'halt!'),
(29, 'menno.vandenbosch@outlook.testtest', 'Menno van den Bosch', 'test');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
