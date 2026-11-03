-- =====================================================================
-- p06_latihan_kopma_25430043.sql
-- Praktikum Basis Data - Modul 6: Latihan dan Modifikasi (E.1, E.2)
-- Nama : Hilman Ahmad Rosyad | NIM : 25430043 | Kelas B
-- Jalankan SETELAH p05_ddl_kopma_25430043.sql dan p06_data_kopma_25430043.sql.
-- =====================================================================

USE kopma_043;

-- ---------- E.1: arsip anggota nonaktif yang mendaftar sebelum 2025 ----------
-- beri anggota A-0104 (Salsabila, nonaktif, daftar 2023) satu nota lama,
-- supaya terbukti anggota yang masih punya penjualan tidak ikut dipindah
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2310-0007', '2023-10-05 08:45:00', 1, 4, 15000);

DROP TABLE IF EXISTS anggota_arsip;
CREATE TABLE anggota_arsip LIKE anggota;

INSERT INTO anggota_arsip
SELECT * FROM anggota
WHERE status_anggota = 'nonaktif'
  AND tgl_daftar_anggota < '2025-01-01'
  AND id_anggota NOT IN (SELECT id_anggota FROM penjualan WHERE id_anggota IS NOT NULL);

DELETE FROM anggota
WHERE status_anggota = 'nonaktif'
  AND tgl_daftar_anggota < '2025-01-01'
  AND id_anggota NOT IN (SELECT id_anggota FROM penjualan WHERE id_anggota IS NOT NULL);

-- hasil: arsip berisi Rizky Aditya; Salsabila tetap di tabel anggota
SELECT no_anggota, nama_anggota, status_anggota FROM anggota_arsip;
SELECT no_anggota, nama_anggota, status_anggota FROM anggota;

-- ---------- E.2: harga makanan naik 5%, dibulatkan ke ratusan ----------
UPDATE barang
SET harga_jual_barang = ROUND(harga_jual_barang * 1.05, -2)
WHERE kategori_barang = 'makanan';

-- hasil: Roti Cokelat 5000 -> 5250 -> 5300
SELECT kode_barang, nama_barang, harga_jual_barang FROM barang;

-- ---------- Setelah selesai ----------
-- DROP TABLE IF EXISTS anggota_arsip; lalu bangun ulang dari DDL + data.
