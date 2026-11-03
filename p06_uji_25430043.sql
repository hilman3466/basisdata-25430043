-- =====================================================================
-- p06_uji_25430043.sql
-- Praktikum Basis Data - Modul 6: Skenario uji proyek Toko Sempurna Hemat
-- Nama : Hilman Ahmad Rosyad | NIM : 25430043 | Kelas B
-- Basis data : tokodaring_043
-- Jalankan SETELAH p05_ddl_25430043.sql dan p06_data_25430043.sql.
-- Jalankan PER BLOK (satu uji sekali Kirim). Hasil nyata dicatat di
-- p06_uji_25430043.md. P = 8 -> batas item per transaksi P + 2 = 10.
-- =====================================================================

USE tokodaring_043;

-- UJ-P01 (positif) pesanan WA, status otomatis 'baru' - AB-06, AB-07
INSERT INTO pesanan (no_pesanan, id_pelanggan, tanggal_pesanan, sumber_pesanan)
VALUES ('ORD-26016', 1, '2026-11-01 09:15:00', 'whatsapp');
SELECT no_pesanan, sumber_pesanan, status_pesanan FROM pesanan WHERE no_pesanan = 'ORD-26016';

-- UJ-P02 (positif) nota baru, harga satuan disalin dari barang - AB-10
INSERT INTO penjualan (no_nota, tanggal_penjualan, id_petugas, metode_pembayaran)
VALUES ('NT-2611001', '2026-11-01 10:20:00', 2, 'tunai');
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty, harga_satuan)
SELECT p.id_penjualan, b.id_barang, 2, b.harga_jual FROM penjualan p, barang b
WHERE p.no_nota = 'NT-2611001' AND b.kode_barang = 'MIE-001';

-- UJ-P03 (positif) barang tanpa barcode - AB-02
INSERT INTO barang (kode_barang, nama_barang, kategori, harga_jual, stok, stok_minimum, barcode)
VALUES ('JJN-004', 'Kerupuk Ikan Curah 250 g', 'Jajanan', 8000, 20, 5, NULL);

-- UJ-P04 (negatif, #1062) kode barang kembar - AB-01
INSERT INTO barang (kode_barang, nama_barang, kategori, harga_jual)
VALUES ('SMB-001', 'Beras Pandan Wangi 5 kg', 'Sembako', 78000);

-- UJ-P05 (negatif, #4025) stok negatif - AB-04
UPDATE barang SET stok = -1 WHERE id_barang = 11;

-- UJ-P06 (negatif, #1062) nomor pesanan kembar - AB-05
INSERT INTO pesanan (no_pesanan, id_pelanggan, tanggal_pesanan, sumber_pesanan)
VALUES ('ORD-26001', 2, '2026-11-01 11:00:00', 'aplikasi');

-- UJ-P07 (negatif, #1452) pelanggan tidak dikenal - fk_pesanan_pelanggan
INSERT INTO pesanan (no_pesanan, id_pelanggan, tanggal_pesanan, sumber_pesanan)
VALUES ('ORD-26017', 99, '2026-11-01 11:30:00', 'aplikasi');

-- UJ-P08 (negatif, #4025) qty 11 melebihi P + 2 - ck_dpesanan_qty
INSERT INTO detail_pesanan (id_pesanan, id_barang, qty, harga_satuan) VALUES (1, 5, 11, 3500);

-- UJ-P09 (negatif, #1048) penerimaan tanpa pemeriksa - AB-13
INSERT INTO penerimaan_barang (no_penerimaan, tanggal_penerimaan, id_pesanan_pembelian,
                               id_petugas_pemeriksa, status_penerimaan)
VALUES ('TRM-26006', '2026-11-01', 5, NULL, 'lengkap');

-- UJ-P10 (negatif, #4025) jatuh tempo sebelum tanggal tagihan - AB-14
INSERT INTO tagihan_pemasok (no_tagihan, id_pemasok, no_faktur, tanggal_tagihan, jatuh_tempo, jumlah_tagihan)
VALUES ('TGH-26006', 5, 'INV-AJ-3301', '2026-11-01', '2026-10-25', 250000);

-- UJ-P11 (negatif, #1451) hapus nota yang sudah punya detail - AB-17
DELETE FROM penjualan WHERE id_penjualan = 1;

-- UJ-P12 (GAGAL, utang desain Modul 14) total 15 item dalam satu nota
-- harapan ditolak (maks 10), kenyataan diterima: CHECK hanya per baris
INSERT INTO penjualan (no_nota, tanggal_penjualan, id_petugas, metode_pembayaran)
VALUES ('NT-2611002', '2026-11-01 14:05:00', 3, 'QRIS');
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty, harga_satuan)
SELECT p.id_penjualan, b.id_barang, 5, b.harga_jual FROM penjualan p, barang b
WHERE p.no_nota = 'NT-2611002' AND b.kode_barang IN ('MIE-001','MIE-002','MNM-003');
SELECT SUM(d.qty) AS total_item FROM detail_penjualan d
JOIN penjualan p ON p.id_penjualan = d.id_penjualan WHERE p.no_nota = 'NT-2611002';

-- ---------- Setelah selesai ----------
-- Bangun ulang: jalankan p05_ddl_25430043.sql lalu p06_data_25430043.sql.
