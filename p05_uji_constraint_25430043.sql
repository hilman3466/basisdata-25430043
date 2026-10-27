-- =====================================================================
-- p05_uji_constraint_25430043.sql
-- Modul 5 langkah D.3, D.4 dan Latihan E
-- Jalankan SETELAH p05_ddl_kopma_25430043.sql.
-- Jalankan PER BLOK (satu perintah sekali Kirim) supaya tiap error
-- kelihatan dan bisa di-screenshot.
-- =====================================================================

USE kopma_043;

-- ---------- D.3 langkah 5: data induk secukupnya ----------
INSERT INTO petugas (kode_petugas, nama_petugas, peran_petugas) VALUES
  ('K01', 'Rina Kasir',   'kasir'),
  ('G01', 'Budi Gudang',  'gudang');

INSERT INTO barang (kode_barang, nama_barang, kategori_barang,
                    harga_jual_barang, stok_barang, stok_min_barang) VALUES
  ('ATK-001', 'Pulpen Hitam',  'ATK',     4000, 50, 10),
  ('MNM-001', 'Air Mineral',   'minuman', 3500, 24,  6);

-- ---------- Uji 1: FK petugas tidak ada  -> harus ERROR 1452 ----------
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas,
                       id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0199', NOW(), 99, NULL, 5000);

-- ---------- Uji 2: stok negatif (AB-03)  -> harus ERROR 4025 ----------
UPDATE barang SET stok_barang = -1 WHERE id_barang = 1;

-- ---------- Uji 3: kode barang kembar     -> harus ERROR 1062 ----------
INSERT INTO barang (kode_barang, nama_barang, kategori_barang, harga_jual_barang)
VALUES ('ATK-001', 'Duplikat', 'ATK', 1000);

-- ---------- D.4 langkah 6: ubah struktur tanpa membuat ulang ----------
ALTER TABLE barang ADD COLUMN tgl_kedaluwarsa DATE NULL AFTER stok_min_barang;
DESCRIBE barang;
ALTER TABLE barang DROP COLUMN tgl_kedaluwarsa;   -- dibatalkan setelah dicoba

-- ---------- Latihan E.1: CHECK stok minimum tidak negatif ----------
ALTER TABLE barang
  ADD CONSTRAINT ck_barang_stokmin CHECK (stok_min_barang >= 0);  -- AB-06
-- bukti ditolak -> ERROR 4025
UPDATE barang SET stok_min_barang = -3 WHERE id_barang = 1;

-- ---------- Latihan E.2: ON DELETE SET NULL untuk anggota ----------
ALTER TABLE penjualan DROP FOREIGN KEY fk_penjualan_anggota;
ALTER TABLE penjualan
  ADD CONSTRAINT fk_penjualan_anggota FOREIGN KEY (id_anggota)
  REFERENCES anggota (id_anggota) ON DELETE SET NULL;
SHOW CREATE TABLE penjualan;

-- ---------- Bersihkan data uji (opsional, sebelum Modul 6) ----------
-- Cara paling aman: jalankan ulang p05_ddl_kopma_25430043.sql dari awal.
