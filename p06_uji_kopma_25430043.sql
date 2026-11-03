-- =====================================================================
-- p06_uji_kopma_25430043.sql
-- Praktikum Basis Data - Modul 6: Skenario uji Kopma (D.3 dan D.4)
-- Nama : Hilman Ahmad Rosyad | NIM : 25430043 | Kelas B
-- Jalankan SETELAH p05_ddl_kopma_25430043.sql dan p06_data_kopma_25430043.sql.
-- Jalankan PER BLOK (satu uji sekali Kirim): uji negatif memang
-- menghasilkan galat, dan phpMyAdmin berhenti di galat pertama.
-- Hasil nyata dicatat di p06_uji_kopma_25430043.md.
-- =====================================================================

USE kopma_043;

-- ---------- D.3 langkah 5: mode aman ----------
-- ditolak (#1175) : UPDATE tanpa syarat kolom kunci
SET SESSION sql_safe_updates = 1;
UPDATE barang SET harga_jual_barang = harga_jual_barang * 1.1;

-- diterima : ada syarat kolom kunci
SET SESSION sql_safe_updates = 1;
UPDATE barang SET harga_jual_barang = harga_jual_barang * 1.1
WHERE kategori_barang = 'ATK' AND id_barang > 0;

-- ---------- D.3 langkah 6: CASCADE dan hapus petugas ----------
-- nota uji kedua (pembeli umum)
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0143', '2026-09-24 11:00:00', 1, NULL, 10000);
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT 2, id_barang, 1, harga_jual_barang FROM barang WHERE kode_barang = 'MKN-001';
SELECT * FROM detail_penjualan;

-- hapus nota -> detail ikut terhapus (ON DELETE CASCADE)
DELETE FROM penjualan WHERE id_penjualan = 2;
SELECT * FROM detail_penjualan;

-- hapus petugas yang pernah melayani nota -> ditolak (#1451)
DELETE FROM petugas WHERE id_petugas = 3;

-- ---------- D.4: skenario uji ----------
-- UJ-01 (positif) nota oleh anggota aktif - AB-02
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0144', '2026-09-25 09:30:00', 1, 2, 20000);

-- UJ-02 (positif) nota pembeli umum, id_anggota NULL - AB-02
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0145', '2026-09-25 13:10:00', 2, NULL, 10000);

-- UJ-03 (negatif, #4025) stok negatif - AB-03
UPDATE barang SET stok_barang = -5 WHERE id_barang = 4;

-- UJ-04 (negatif, #1062) nomor nota kembar - AB-01
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0142', '2026-09-25 14:00:00', 1, NULL, 5000);

-- UJ-05 (negatif, #4025) qty detail 0 - ck_detail_qty
INSERT INTO detail_penjualan VALUES (1, 4, 0, 5000);

-- UJ-06 (negatif, #1062) NIM kembar - AB-05
INSERT INTO anggota (no_anggota, nim_anggota, nama_anggota, prodi_anggota, status_anggota, tgl_daftar_anggota)
VALUES ('A-0105', '2541007712', 'Dian Lestari', 'Ilmu Komputer', 'aktif', '2026-03-01');

-- UJ-07 (negatif, #1452) petugas tidak dikenal - fk_penjualan_petugas
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0146', '2026-09-25 15:00:00', 99, NULL, 5000);

-- UJ-08 (negatif, #1175) UPDATE tanpa WHERE di mode aman - kebijakan lab
SET SESSION sql_safe_updates = 1;
UPDATE anggota SET status_anggota = 'aktif';

-- UJ-09 (diperkirakan GAGAL) jual qty 50 padahal stok 6 - AB-03
-- harapan ditolak, kenyataan diterima: CHECK tidak membandingkan dua tabel (Modul 14)
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 50, b.harga_jual_barang
FROM penjualan p, barang b
WHERE p.no_nota_penjualan = 'PJ-2609-0145' AND b.kode_barang = 'MKN-001';

-- ---------- Setelah selesai ----------
-- Bangun ulang: jalankan p05_ddl_kopma_25430043.sql lalu p06_data_kopma_25430043.sql.
