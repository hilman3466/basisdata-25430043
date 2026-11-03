USE kopma_043;

INSERT INTO petugas (kode_petugas, nama_petugas, peran_petugas) VALUES
  ('K01','Dimas','kasir'), ('K02','Sari','kasir'), ('K03','Rina','kasir'),
  ('G01','Joko','gudang'), ('P01','Ketua Kopma','ketua');

INSERT INTO barang (kode_barang, nama_barang, kategori_barang,
                    harga_jual_barang, stok_barang, stok_min_barang) VALUES
  ('ATK-001','Pulpen Gel 0.5','ATK',4000,120,20),
  ('ATK-002','Buku Tulis 58','ATK',6500,80,20),
  ('MNM-001','Air Mineral 600','minuman',4000,48,24),
  ('MKN-001','Roti Cokelat','makanan',5000,6,10);

INSERT INTO anggota (no_anggota, nim_anggota, nama_anggota, prodi_anggota,
                     no_hp_anggota, status_anggota, tgl_daftar_anggota) VALUES
  ('A-0101', '2541007712', 'Fadhil Ramadhan',  'Ilmu Komputer',          '081278341105', 'aktif',    '2026-02-12'),
  ('A-0102', '2542011389', 'Nadia Putri Utami', 'Pendidikan Matematika', '085769203418', 'aktif',    '2025-08-27'),
  ('A-0103', '2343005621', 'Rizky Aditya',      'Agribisnis',            NULL,           'nonaktif', '2024-03-05'),
  ('A-0104', '2244009157', 'Salsabila Khairunnisa', 'Manajemen',         '082183670592', 'nonaktif', '2023-09-18');

INSERT INTO pemasok (kode_pemasok, nama_pemasok, telepon_pemasok, alamat_pemasok) VALUES
  ('SUP-01', 'CV Sumber Rezeki Metro', '0725412873',   'Jl. Jend. Sudirman No. 88, Metro Pusat'),
  ('SUP-02', 'UD Tunas Grosir Lampung', '081379042256', 'Jl. Ki Hajar Dewantara No. 21, Metro Timur');

INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas,
                       id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0142', '2026-09-24 10:15:00', 3, 1, 30000);

INSERT INTO detail_penjualan (id_penjualan, id_barang,
       qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT 1, id_barang, 3, harga_jual_barang FROM barang WHERE kode_barang = 'ATK-001';

INSERT INTO detail_penjualan (id_penjualan, id_barang,
       qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT 1, id_barang, 2, harga_jual_barang FROM barang WHERE kode_barang = 'ATK-002';

INSERT INTO detail_penjualan (id_penjualan, id_barang,
       qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT 1, id_barang, 1, harga_jual_barang FROM barang WHERE kode_barang = 'MNM-001';

UPDATE barang SET stok_barang = stok_barang - 3 WHERE id_barang = 1;
UPDATE barang SET stok_barang = stok_barang - 2 WHERE id_barang = 2;
UPDATE barang SET stok_barang = stok_barang - 1 WHERE id_barang = 3;