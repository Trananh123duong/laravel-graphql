-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost:3306
-- Thời gian đã tạo: Th3 02, 2023 lúc 10:03 PM
-- Phiên bản máy phục vụ: 10.3.38-MariaDB-cll-lve
-- Phiên bản PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `thangtha_webtruyen`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `binhluan`
--

CREATE TABLE `binhluan` (
  `id` int(11) UNSIGNED NOT NULL,
  `thanhvien_id` int(11) UNSIGNED NOT NULL,
  `truyen_id` int(11) UNSIGNED NOT NULL,
  `noi_dung` text NOT NULL,
  `ngay_dang` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chuong`
--

CREATE TABLE `chuong` (
  `id` int(11) UNSIGNED NOT NULL,
  `truyen_id` int(11) UNSIGNED NOT NULL,
  `so_thu_tu` int(11) NOT NULL,
  `ten_chuong` varchar(255) NOT NULL,
  `noi_dung` text NOT NULL,
  `ngay_cap_nhat` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lichsudoc`
--

CREATE TABLE `lichsudoc` (
  `id` int(11) UNSIGNED NOT NULL,
  `thanhvien_id` int(11) UNSIGNED NOT NULL,
  `truyen_id` int(11) UNSIGNED NOT NULL,
  `chuong_id` int(11) UNSIGNED NOT NULL,
  `vi_tri` int(11) NOT NULL,
  `ngay_cap_nhat` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoidangtruyen`
--

CREATE TABLE `nguoidangtruyen` (
  `id` int(11) NOT NULL,
  `ten` varchar(255) DEFAULT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thanhvien`
--

CREATE TABLE `thanhvien` (
  `id` int(11) UNSIGNED NOT NULL,
  `ten_dang_nhap` varchar(255) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `ten_hien_thi` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `ngay_dang_ky` datetime NOT NULL,
  `loai_tai_khoan` enum('BASIC','VIP') NOT NULL DEFAULT 'BASIC',
  `nguoidangtruyen_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thich`
--

CREATE TABLE `thich` (
  `id` int(11) UNSIGNED NOT NULL,
  `thanhvien_id` int(11) UNSIGNED NOT NULL,
  `truyen_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `truyen`
--

CREATE TABLE `truyen` (
  `id` int(11) UNSIGNED NOT NULL,
  `ten_truyen` varchar(255) NOT NULL,
  `the_loai` varchar(255) DEFAULT NULL,
  `mo_ta` text DEFAULT NULL,
  `anh_bia` varchar(255) DEFAULT NULL,
  `trang_thai` enum('dang_tien_hanh','da_hoan_thanh') NOT NULL,
  `ngay_cap_nhat` datetime NOT NULL,
  `nguoidangtruyen_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `binhluan`
--
ALTER TABLE `binhluan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_binhluan_thanhvien_id` (`thanhvien_id`),
  ADD KEY `idx_binhluan_truyen_id` (`truyen_id`),
  ADD KEY `idx_binhluan_ngay_dang` (`ngay_dang`);

--
-- Chỉ mục cho bảng `chuong`
--
ALTER TABLE `chuong`
  ADD PRIMARY KEY (`id`),
  ADD KEY `truyen_id` (`truyen_id`),
  ADD KEY `idx_chuong_so_thu_tu` (`so_thu_tu`),
  ADD KEY `idx_chuong_ngay_cap_nhat` (`ngay_cap_nhat`);

--
-- Chỉ mục cho bảng `lichsudoc`
--
ALTER TABLE `lichsudoc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_lich_su_doc_thanhvien_id` (`thanhvien_id`),
  ADD KEY `idx_lich_su_doc_truyen_id` (`truyen_id`),
  ADD KEY `idx_lich_su_doc_chuong_id` (`chuong_id`);

--
-- Chỉ mục cho bảng `nguoidangtruyen`
--
ALTER TABLE `nguoidangtruyen`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `thanhvien`
--
ALTER TABLE `thanhvien`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_thanhvien_ngay_dang_ky` (`ngay_dang_ky`);

--
-- Chỉ mục cho bảng `thich`
--
ALTER TABLE `thich`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_thich_thanhvien_id` (`thanhvien_id`),
  ADD KEY `idx_thich_truyen_id` (`truyen_id`);

--
-- Chỉ mục cho bảng `truyen`
--
ALTER TABLE `truyen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_truyen_ten_truyen` (`ten_truyen`),
  ADD KEY `idx_truyen_ngay_cap_nhat` (`ngay_cap_nhat`),
  ADD KEY `fk_tacgia` (`nguoidangtruyen_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `binhluan`
--
ALTER TABLE `binhluan`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `chuong`
--
ALTER TABLE `chuong`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `lichsudoc`
--
ALTER TABLE `lichsudoc`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nguoidangtruyen`
--
ALTER TABLE `nguoidangtruyen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `thanhvien`
--
ALTER TABLE `thanhvien`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `thich`
--
ALTER TABLE `thich`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `truyen`
--
ALTER TABLE `truyen`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `binhluan`
--
ALTER TABLE `binhluan`
  ADD CONSTRAINT `binhluan_ibfk_1` FOREIGN KEY (`thanhvien_id`) REFERENCES `thanhvien` (`id`),
  ADD CONSTRAINT `binhluan_ibfk_2` FOREIGN KEY (`truyen_id`) REFERENCES `truyen` (`id`);

--
-- Các ràng buộc cho bảng `chuong`
--
ALTER TABLE `chuong`
  ADD CONSTRAINT `chuong_ibfk_1` FOREIGN KEY (`truyen_id`) REFERENCES `truyen` (`id`);

--
-- Các ràng buộc cho bảng `lichsudoc`
--
ALTER TABLE `lichsudoc`
  ADD CONSTRAINT `lichsudoc_ibfk_1` FOREIGN KEY (`thanhvien_id`) REFERENCES `thanhvien` (`id`),
  ADD CONSTRAINT `lichsudoc_ibfk_2` FOREIGN KEY (`truyen_id`) REFERENCES `truyen` (`id`),
  ADD CONSTRAINT `lichsudoc_ibfk_3` FOREIGN KEY (`chuong_id`) REFERENCES `chuong` (`id`);

--
-- Các ràng buộc cho bảng `thich`
--
ALTER TABLE `thich`
  ADD CONSTRAINT `thich_ibfk_1` FOREIGN KEY (`thanhvien_id`) REFERENCES `thanhvien` (`id`),
  ADD CONSTRAINT `thich_ibfk_2` FOREIGN KEY (`truyen_id`) REFERENCES `truyen` (`id`);

--
-- Các ràng buộc cho bảng `truyen`
--
ALTER TABLE `truyen`
  ADD CONSTRAINT `fk_tacgia` FOREIGN KEY (`nguoidangtruyen_id`) REFERENCES `nguoidangtruyen` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
