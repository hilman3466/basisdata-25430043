-- =====================================================================
-- p05_ddl_25430043.sql
-- Praktikum Basis Data - Modul 5: Milestone Proyek 5 (DDL Proyek)
-- Nama  : Hilman Ahmad Rosyad | NIM : 25430043 | Kelas B
-- Tema  : Toko Daring - Toko Sempurna Hemat
-- Basis data : tokodaring_043 (utf8mb4_unicode_ci)
-- Acuan : ERD p04_erd_update_25430043 dan kebutuhan data P02 (AB-01..AB-17)
-- Parameter P = (43 mod 9) + 1 = 8  ->  batas item per transaksi P + 2 = 10
-- Skrip dapat dijalankan ulang dari basis data kosong.
-- =====================================================================

USE tokodaring_043;

-- ---------------------------------------------------------------------
-- 0. Hapus tabel lama: urutan ANAK -> INDUK
--    (termasuk tabel lama Modul 1 yang namanya sama)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS klaim_hadiah;
DROP TABLE IF EXISTS program_hadiah_barang;
DROP TABLE IF EXISTS pembayaran_tagihan;
DROP TABLE IF EXISTS tagihan_pemasok;
DROP TABLE IF EXISTS detail_penerimaan;
DROP TABLE IF EXISTS penerimaan_barang;
DROP TABLE IF EXISTS detail_pesanan_pembelian;
DROP TABLE IF EXISTS pesanan_pembelian;
DROP TABLE IF EXISTS detail_penjualan;
DROP TABLE IF EXISTS penjualan;
DROP TABLE IF EXISTS riwayat_perubahan_pesanan;
DROP TABLE IF EXISTS detail_pesanan;
DROP TABLE IF EXISTS pesanan;
DROP TABLE IF EXISTS program_hadiah;
DROP TABLE IF EXISTS pemasok;
DROP TABLE IF EXISTS barang;
DROP TABLE IF EXISTS petugas;
DROP TABLE IF EXISTS pelanggan;

-- ---------------------------------------------------------------------
-- 1. Tabel master (tanpa kunci tamu)
-- ---------------------------------------------------------------------
CREATE TABLE pelanggan (
  id_pelanggan   INT          NOT NULL AUTO_INCREMENT,
  nama_pelanggan VARCHAR(100) NOT NULL,
  no_whatsapp    VARCHAR(20)  NULL,                -- DATA PRIBADI (UU PDP), hanya untuk keperluan pesanan
  PRIMARY KEY (id_pelanggan)
) ENGINE=InnoDB;

CREATE TABLE petugas (
  id_petugas    INT          NOT NULL AUTO_INCREMENT,
  nama_petugas  VARCHAR(100) NOT NULL,
  peran_petugas VARCHAR(50)  NOT NULL,
  PRIMARY KEY (id_petugas)
) ENGINE=InnoDB;

CREATE TABLE barang (
  id_barang    INT           NOT NULL AUTO_INCREMENT,
  kode_barang  VARCHAR(30)   NOT NULL,             -- kode internal toko, wajib ada (AB-01, AB-02)
  nama_barang  VARCHAR(120)  NOT NULL,
  kategori     VARCHAR(60)   NULL,
  harga_jual   DECIMAL(12,2) NOT NULL,
  stok         INT           NOT NULL DEFAULT 0,
  stok_minimum INT           NOT NULL DEFAULT 0,  -- dasar KI-04
  barcode      VARCHAR(50)   NULL,                 -- boleh kosong untuk barang tanpa barcode (AB-02)
  PRIMARY KEY (id_barang),
  UNIQUE KEY uq_barang_kode (kode_barang),         -- AB-01
  UNIQUE KEY uq_barang_barcode (barcode),          -- AB-02 / KI-07 (NULL boleh lebih dari satu)
  CONSTRAINT ck_barang_harga  CHECK (harga_jual >= 0),   -- kamus data P02
  CONSTRAINT ck_barang_stok   CHECK (stok >= 0),         -- AB-04
  CONSTRAINT ck_barang_stokmin CHECK (stok_minimum >= 0) -- kamus data P02
) ENGINE=InnoDB;

CREATE TABLE pemasok (
  id_pemasok   INT          NOT NULL AUTO_INCREMENT,
  nama_pemasok VARCHAR(120) NOT NULL,
  no_telepon   VARCHAR(20)  NULL,
  alamat       VARCHAR(200) NULL,
  PRIMARY KEY (id_pemasok)
) ENGINE=InnoDB;

CREATE TABLE program_hadiah (
  id_program   INT          NOT NULL AUTO_INCREMENT,
  nama_program VARCHAR(100) NOT NULL,
  keterangan   TEXT         NULL,
  periode      VARCHAR(100) NULL,
  PRIMARY KEY (id_program)
) ENGINE=InnoDB;                                   -- AB-16

-- ---------------------------------------------------------------------
-- 2. Pesanan pelanggan (diambil di toko, tanpa pengiriman - AB-06)
-- ---------------------------------------------------------------------
CREATE TABLE pesanan (
  id_pesanan            INT           NOT NULL AUTO_INCREMENT,
  no_pesanan            VARCHAR(30)   NOT NULL,
  id_pelanggan          INT           NOT NULL,
  tanggal_pesanan       DATETIME      NOT NULL,
  sumber_pesanan        ENUM('whatsapp','aplikasi') NOT NULL,       -- AB-06
  status_pesanan        ENUM('baru','diproses','disiapkan','siap_diambil','diambil','dibatalkan')
                        NOT NULL DEFAULT 'baru',                    -- AB-07
  potongan              DECIMAL(12,2) NOT NULL DEFAULT 0,
  id_petugas_penyiap    INT           NULL,
  id_petugas_pemeriksa  INT           NULL,
  waktu_siap_diambil    DATETIME      NULL,
  waktu_diambil         DATETIME      NULL,
  PRIMARY KEY (id_pesanan),
  UNIQUE KEY uq_pesanan_no (no_pesanan),                            -- AB-05
  CONSTRAINT fk_pesanan_pelanggan FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan),
  CONSTRAINT fk_pesanan_penyiap   FOREIGN KEY (id_petugas_penyiap)   REFERENCES petugas (id_petugas),
  CONSTRAINT fk_pesanan_pemeriksa FOREIGN KEY (id_petugas_pemeriksa) REFERENCES petugas (id_petugas),
  CONSTRAINT ck_pesanan_potongan CHECK (potongan >= 0),
  CONSTRAINT ck_pesanan_waktu CHECK (waktu_diambil IS NULL OR waktu_siap_diambil IS NULL
                                     OR waktu_diambil >= waktu_siap_diambil)
  -- AB-05 "minimal satu barang" melibatkan banyak baris -> tidak bisa CHECK (Modul 14)
) ENGINE=InnoDB;

CREATE TABLE detail_pesanan (
  id_detail_pesanan INT           NOT NULL AUTO_INCREMENT,
  id_pesanan        INT           NOT NULL,
  id_barang         INT           NOT NULL,
  qty               INT           NOT NULL,
  harga_satuan      DECIMAL(12,2) NOT NULL,         -- harga saat barang dimasukkan ke pesanan
  status_barang     ENUM('aktif','dibatalkan') NOT NULL DEFAULT 'aktif', -- AB-09 batal per barang
  PRIMARY KEY (id_detail_pesanan),
  -- FK tanpa CASCADE: riwayat pesanan tidak boleh ikut terhapus (AB-17)
  CONSTRAINT fk_dpesanan_pesanan FOREIGN KEY (id_pesanan) REFERENCES pesanan (id_pesanan),
  CONSTRAINT fk_dpesanan_barang  FOREIGN KEY (id_barang)  REFERENCES barang (id_barang),
  -- P + 2 = 10: satu baris tidak boleh melebihi batas item per transaksi
  CONSTRAINT ck_dpesanan_qty   CHECK (qty > 0 AND qty <= 10),
  CONSTRAINT ck_dpesanan_harga CHECK (harga_satuan >= 0)
  -- Total item per pesanan <= 10 melibatkan banyak baris -> tidak bisa CHECK (Modul 14)
) ENGINE=InnoDB;

CREATE TABLE riwayat_perubahan_pesanan (
  id_perubahan_pesanan    INT         NOT NULL AUTO_INCREMENT,
  id_pesanan              INT         NOT NULL,
  id_detail_pesanan       INT         NULL,           -- opsional: perubahan pada satu baris barang
  id_petugas              INT         NOT NULL,
  waktu_perubahan_pesanan DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  jenis_perubahan_pesanan VARCHAR(40) NOT NULL,       -- mis. tambah barang / batal barang (AB-08, AB-09)
  keterangan_perubahan    TEXT        NULL,
  PRIMARY KEY (id_perubahan_pesanan),
  CONSTRAINT fk_riwayat_pesanan FOREIGN KEY (id_pesanan)        REFERENCES pesanan (id_pesanan),
  CONSTRAINT fk_riwayat_detail  FOREIGN KEY (id_detail_pesanan) REFERENCES detail_pesanan (id_detail_pesanan),
  CONSTRAINT fk_riwayat_petugas FOREIGN KEY (id_petugas)        REFERENCES petugas (id_petugas)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 3. Penjualan (pembelian langsung dan pengambilan pesanan)
-- ---------------------------------------------------------------------
CREATE TABLE penjualan (
  id_penjualan      INT         NOT NULL AUTO_INCREMENT,
  no_nota           VARCHAR(30) NOT NULL,
  tanggal_penjualan DATETIME    NOT NULL,
  id_petugas        INT         NOT NULL,
  metode_pembayaran VARCHAR(40) NOT NULL,
  PRIMARY KEY (id_penjualan),
  UNIQUE KEY uq_penjualan_nota (no_nota),
  CONSTRAINT fk_penjualan_petugas FOREIGN KEY (id_petugas) REFERENCES petugas (id_petugas)
) ENGINE=InnoDB;

CREATE TABLE detail_penjualan (
  id_penjualan INT           NOT NULL,
  id_barang    INT           NOT NULL,
  qty          INT           NOT NULL,
  harga_satuan DECIMAL(12,2) NOT NULL,              -- harga saat transaksi (AB-10)
  PRIMARY KEY (id_penjualan, id_barang),
  CONSTRAINT fk_djual_penjualan FOREIGN KEY (id_penjualan) REFERENCES penjualan (id_penjualan), -- AB-17
  CONSTRAINT fk_djual_barang    FOREIGN KEY (id_barang)    REFERENCES barang (id_barang),
  CONSTRAINT ck_djual_qty   CHECK (qty > 0 AND qty <= 10),   -- P + 2 per baris
  CONSTRAINT ck_djual_harga CHECK (harga_satuan >= 0)
  -- Total item per nota <= 10 melibatkan banyak baris -> tidak bisa CHECK (Modul 14)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 4. Pengadaan dari pemasok
-- ---------------------------------------------------------------------
CREATE TABLE pesanan_pembelian (
  id_pesanan_pembelian INT         NOT NULL AUTO_INCREMENT,
  no_pesanan_pembelian VARCHAR(30) NOT NULL,
  tanggal_pemesanan    DATE        NOT NULL,           -- AB-11
  id_pemasok           INT         NOT NULL,           -- AB-11
  status               VARCHAR(30) NOT NULL DEFAULT 'dipesan',
  PRIMARY KEY (id_pesanan_pembelian),
  UNIQUE KEY uq_ppembelian_no (no_pesanan_pembelian),
  CONSTRAINT fk_ppembelian_pemasok FOREIGN KEY (id_pemasok) REFERENCES pemasok (id_pemasok)
) ENGINE=InnoDB;

CREATE TABLE detail_pesanan_pembelian (
  id_pesanan_pembelian INT           NOT NULL,
  id_barang            INT           NOT NULL,
  qty_pesan            INT           NOT NULL,         -- AB-11
  harga_beli           DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (id_pesanan_pembelian, id_barang),
  CONSTRAINT fk_dppembelian_pp     FOREIGN KEY (id_pesanan_pembelian) REFERENCES pesanan_pembelian (id_pesanan_pembelian),
  CONSTRAINT fk_dppembelian_barang FOREIGN KEY (id_barang)            REFERENCES barang (id_barang),
  CONSTRAINT ck_dppembelian_qty   CHECK (qty_pesan > 0),
  CONSTRAINT ck_dppembelian_harga CHECK (harga_beli >= 0)
) ENGINE=InnoDB;

CREATE TABLE penerimaan_barang (
  id_penerimaan         INT         NOT NULL AUTO_INCREMENT,
  no_penerimaan         VARCHAR(30) NOT NULL,
  tanggal_penerimaan    DATE        NOT NULL,
  id_pesanan_pembelian  INT         NOT NULL,          -- pemasok ditelusuri lewat pesanan pembelian
  id_petugas_pemeriksa  INT         NOT NULL,          -- AB-13: pemeriksa wajib tercatat
  no_dokumen            VARCHAR(50) NULL,
  status_penerimaan     VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_penerimaan),
  UNIQUE KEY uq_penerimaan_no (no_penerimaan),
  CONSTRAINT fk_penerimaan_pp        FOREIGN KEY (id_pesanan_pembelian) REFERENCES pesanan_pembelian (id_pesanan_pembelian),
  CONSTRAINT fk_penerimaan_pemeriksa FOREIGN KEY (id_petugas_pemeriksa) REFERENCES petugas (id_petugas)
) ENGINE=InnoDB;

CREATE TABLE detail_penerimaan (
  id_penerimaan INT NOT NULL,
  id_barang     INT NOT NULL,
  qty_terima    INT NOT NULL,                          -- dicatat terpisah dari qty_pesan (AB-12)
  selisih       INT NOT NULL DEFAULT 0,                -- qty_terima - qty_pesan, boleh negatif (AB-12)
  PRIMARY KEY (id_penerimaan, id_barang),
  CONSTRAINT fk_dpenerimaan_penerimaan FOREIGN KEY (id_penerimaan) REFERENCES penerimaan_barang (id_penerimaan),
  CONSTRAINT fk_dpenerimaan_barang     FOREIGN KEY (id_barang)     REFERENCES barang (id_barang),
  CONSTRAINT ck_dpenerimaan_qty CHECK (qty_terima >= 0)
) ENGINE=InnoDB;

CREATE TABLE tagihan_pemasok (
  id_tagihan        INT           NOT NULL AUTO_INCREMENT,
  no_tagihan        VARCHAR(30)   NOT NULL,
  id_pemasok        INT           NOT NULL,
  no_faktur         VARCHAR(50)   NOT NULL,             -- AB-14
  tanggal_tagihan   DATE          NOT NULL,             -- AB-14
  jatuh_tempo       DATE          NOT NULL,             -- AB-14
  jumlah_tagihan    DECIMAL(12,2) NOT NULL,             -- AB-14
  status_pembayaran VARCHAR(30)   NOT NULL DEFAULT 'belum dibayar', -- AB-15
  PRIMARY KEY (id_tagihan),
  UNIQUE KEY uq_tagihan_no (no_tagihan),
  CONSTRAINT fk_tagihan_pemasok FOREIGN KEY (id_pemasok) REFERENCES pemasok (id_pemasok),
  CONSTRAINT ck_tagihan_jumlah CHECK (jumlah_tagihan > 0),
  CONSTRAINT ck_tagihan_tempo  CHECK (jatuh_tempo >= tanggal_tagihan) -- AB-14 / KI-06
) ENGINE=InnoDB;

CREATE TABLE pembayaran_tagihan (
  id_pembayaran_tagihan INT           NOT NULL AUTO_INCREMENT,
  id_tagihan            INT           NOT NULL,
  tanggal_pembayaran    DATE          NOT NULL,
  jumlah_bayar          DECIMAL(12,2) NOT NULL,
  metode_pembayaran     VARCHAR(40)   NULL,
  PRIMARY KEY (id_pembayaran_tagihan),
  CONSTRAINT fk_pembayaran_tagihan FOREIGN KEY (id_tagihan) REFERENCES tagihan_pemasok (id_tagihan), -- AB-15
  CONSTRAINT ck_pembayaran_jumlah CHECK (jumlah_bayar > 0)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 5. Program hadiah (pencatatan internal - AB-16)
-- ---------------------------------------------------------------------
CREATE TABLE program_hadiah_barang (
  id_program INT NOT NULL,
  id_barang  INT NOT NULL,
  PRIMARY KEY (id_program, id_barang),
  CONSTRAINT fk_phb_program FOREIGN KEY (id_program) REFERENCES program_hadiah (id_program),
  CONSTRAINT fk_phb_barang  FOREIGN KEY (id_barang)  REFERENCES barang (id_barang)
) ENGINE=InnoDB;

CREATE TABLE klaim_hadiah (
  id_klaim      INT         NOT NULL AUTO_INCREMENT,
  id_program    INT         NOT NULL,
  id_pelanggan  INT         NOT NULL,
  tanggal_klaim DATE        NOT NULL,
  status_klaim  VARCHAR(30) NOT NULL DEFAULT 'diajukan',   -- KI-08
  PRIMARY KEY (id_klaim),
  CONSTRAINT fk_klaim_program   FOREIGN KEY (id_program)   REFERENCES program_hadiah (id_program),
  CONSTRAINT fk_klaim_pelanggan FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 6. Pemeriksaan
-- ---------------------------------------------------------------------
SHOW TABLES;
