-- p01_lingkungan_25430043.sql
-- NIM: 25430043
-- Tema: Toko Daring
-- Database proyek: tokodaring_043
-- User proyek: dev_043
-- Password sengaja diganti placeholder.
-- JANGAN commit password asli.

-- 1. Database latihan

CREATE DATABASE IF NOT EXISTS kopma_043
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'mhs_043'@'localhost'
  IDENTIFIED BY '<password_kerja>';

GRANT ALL PRIVILEGES ON kopma_043.* TO 'mhs_043'@'localhost';

-- 2. Database proyek

CREATE DATABASE IF NOT EXISTS tokodaring_043
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'dev_043'@'localhost'
  IDENTIFIED BY '<password_kerja>';

GRANT ALL PRIVILEGES ON tokodaring_043.* TO 'dev_043'@'localhost';
