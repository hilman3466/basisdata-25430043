# Normalisasi Data Kopma - Modul 4

## D.1 Dari UNF ke 1NF

Data awal yang digunakan adalah nota penjualan Kopma. Satu nota bisa berisi beberapa barang, sehingga rincian barang masih berbentuk kelompok yang berulang. Untuk melakukan normalisasi, kelompok tersebut dipisahkan agar setiap baris mewakili satu barang dalam satu nota.

Bentuk UNF dituliskan sebagai berikut:

```text
NOTA_UNF (
    no_nota_penjualan,
    tgl_penjualan,
    kode_petugas,
    nama_petugas,
    no_anggota,
    nama_anggota,
    {
        kode_barang,
        nama_barang,
        qty_detail_penjualan,
        harga_satuan_detail_penjualan,
        subtotal_detail_penjualan
    },
    jumlah_penjualan,
    diskon_penjualan,
    total_penjualan
)
```

Pada bentuk 1NF, kelompok barang yang berulang dihilangkan dengan mencatat setiap barang sebagai satu baris detail.

```text
NOTA_1NF (
    no_nota_penjualan,
    kode_barang,
    tgl_penjualan,
    kode_petugas,
    nama_petugas,
    no_anggota,
    nama_anggota,
    nama_barang,
    qty_detail_penjualan,
    harga_satuan_detail_penjualan,
    subtotal_detail_penjualan,
    jumlah_penjualan,
    diskon_penjualan,
    total_penjualan
)
```

Kunci primer sementara pada tahap 1NF adalah gabungan `no_nota_penjualan` dan `kode_barang`. Kunci ini mengasumsikan bahwa satu barang hanya dicatat satu kali dalam satu nota.

## D.2 Menuliskan Dependensi Fungsional

Dependensi fungsional ditentukan berdasarkan aturan bisnis Kopma pada Modul 2, bukan hanya dari contoh data.

| Kode | Dependensi fungsional | Dasar |
|---|---|---|
| FD1 | `no_nota_penjualan` → `tgl_penjualan`, `kode_petugas`, `no_anggota` | AB-01 |
| FD2 | `kode_petugas` → `nama_petugas` | Identitas petugas |
| FD3 | `no_anggota` → `nama_anggota` | AB-05 |
| FD4 | `kode_barang` → `nama_barang` | Identitas barang |
| FD5 | (`no_nota_penjualan`, `kode_barang`) → `qty_detail_penjualan`, `harga_satuan_detail_penjualan` | AB-04 |
| FD6 | (`qty_detail_penjualan`, `harga_satuan_detail_penjualan`) → `subtotal_detail_penjualan` | Nilai turunan |

## D.3 Menuju 2NF dan 3NF

### 2NF

Pada tahap 2NF, informasi yang hanya bergantung pada sebagian kunci gabungan dipisahkan ke tabel tersendiri. Nama barang, misalnya, bergantung pada kode barang, bukan pada nomor nota. Oleh karena itu, data barang dipisahkan dari rincian penjualan.

Hasil pemisahan pada tahap 2NF dapat ditulis sebagai berikut.

```text
PENJUALAN_2NF (
    no_nota_penjualan,
    tgl_penjualan,
    kode_petugas,
    nama_petugas,
    no_anggota,
    nama_anggota,
    bayar_penjualan
)

BARANG_2NF (
    kode_barang,
    nama_barang,
    kategori_barang,
    harga_jual_barang,
    stok_barang,
    stok_min_barang
)

DETAIL_PENJUALAN_2NF (
    no_nota_penjualan,
    kode_barang,
    qty_detail_penjualan,
    harga_satuan_detail_penjualan
)
```

Pada `DETAIL_PENJUALAN_2NF`, kunci sementara masih berupa gabungan `no_nota_penjualan` dan `kode_barang`. Jumlah serta harga saat transaksi dicatat pada tabel detail karena nilainya berkaitan dengan barang yang dibeli pada nota tersebut.

### 3NF

Pada tahap 3NF, data yang bergantung pada atribut selain kunci utama dipisahkan lagi. Contohnya, kode petugas menentukan nama dan peran petugas, sedangkan nomor anggota menentukan identitas anggota. Jika informasi tersebut dibiarkan berada di tabel penjualan, datanya akan berulang setiap kali petugas atau anggota melakukan transaksi.

Hasil normalisasi dengan kunci alami dapat ditulis sebagai berikut.

```text
PENJUALAN (
    no_nota_penjualan,
    tgl_penjualan,
    kode_petugas,
    no_anggota,
    bayar_penjualan
)

DETAIL_PENJUALAN (
    no_nota_penjualan,
    kode_barang,
    qty_detail_penjualan,
    harga_satuan_detail_penjualan
)

BARANG (
    kode_barang,
    nama_barang,
    kategori_barang,
    harga_jual_barang,
    stok_barang,
    stok_min_barang
)

PETUGAS (
    kode_petugas,
    nama_petugas,
    peran_petugas
)

ANGGOTA (
    no_anggota,
    nim_anggota,
    nama_anggota,
    prodi_anggota,
    no_hp_anggota,
    status_anggota,
    tgl_daftar_anggota
)
```

Pada susunan tersebut, `no_nota_penjualan` menjadi kunci utama sementara untuk `PENJUALAN`, sedangkan gabungan `no_nota_penjualan` dan `kode_barang` menjadi kunci utama sementara untuk `DETAIL_PENJUALAN`. Hubungan antara tabel penjualan, detail penjualan, barang, petugas, dan anggota dapat ditelusuri tanpa harus menyimpan nama petugas serta nama anggota berulang kali pada setiap nota.

Nilai `subtotal_detail_penjualan`, `jumlah_penjualan`, dan `total_penjualan` tidak dimasukkan ke skema operasional karena dapat dihitung dari rincian penjualan dan aturan diskon anggota. Harga satuan tetap dicatat pada `DETAIL_PENJUALAN`, mengikuti AB-04, agar harga transaksi lama tidak berubah ketika harga jual pada tabel `BARANG` diperbarui.
