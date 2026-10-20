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
## D.4 Mencocokkan dengan Skema Kanonik

Setelah tahap normalisasi selesai, hasilnya dicocokkan dengan skema kanonik pada buku praktikum. Pada skema akhir, beberapa tabel menggunakan `id_*` sebagai primary key (PK), sedangkan kode alami seperti nomor nota tetap dipertahankan sebagai nilai unik.

Bagian D.3 sebelumnya menjelaskan pemisahan data pada proses penjualan. Untuk melengkapi skema Kopma, tabel pemasok dan pembelian juga dicantumkan karena proses pemesanan barang kepada pemasok termasuk dalam kegiatan operasional koperasi.

| Tabel | Kunci Primer (PK) | Kunci Unik | Kunci Tamu (FK) |
|---|---|---|---|
| `PETUGAS` | `id_petugas` | `kode_petugas` | — |
| `ANGGOTA` | `id_anggota` | `no_anggota`, `nim_anggota` | — |
| `BARANG` | `id_barang` | `kode_barang` | — |
| `PEMASOK` | `id_pemasok` | `kode_pemasok` | — |
| `PENJUALAN` | `id_penjualan` | `no_nota_penjualan` | `id_petugas`, `id_anggota` (boleh NULL) |
| `DETAIL_PENJUALAN` | (`id_penjualan`, `id_barang`) | — | `id_penjualan`, `id_barang` |
| `PEMBELIAN` | `id_pembelian` | `no_faktur_pembelian` | `id_pemasok` |
| `PEMBELIAN` | `id_pembelian` | `no_faktur_pembelian` | `id_pemasok`, `id_petugas_penerima` (opsional) |

Kunci utama pada tabel detail menggunakan gabungan dua atribut karena satu baris menunjukkan satu barang pada satu transaksi. Sementara itu, `no_nota_penjualan` dan `no_faktur_pembelian` dipertahankan sebagai nilai unik agar setiap transaksi bisa dicari melalui nomor dokumennya. Aturan unik kode pemasok juga mengikuti kamus data P02 Kopma.

Catatan: `RIWAYAT_POIN` tercantum pada P02 dan ERD P03 sebagai bagian latihan poin loyalitas. Entitas ini merupakan tambahan dari latihan Modul 2, sehingga tidak termasuk dalam daftar skema kanonik utama pada Tabel 4.2 buku praktikum. Jika digunakan dalam skema akhir, relasi dan dependensi fungsionalnya perlu diperiksa secara terpisah.

### Pemeriksaan Bentuk Normal Boyce-Codd (BCNF)

Pemeriksaan BCNF dilakukan dengan melihat apakah setiap atribut penentu pada dependensi fungsional merupakan kunci kandidat. Hasil berikut didasarkan pada kunci dan aturan keunikan yang digunakan dalam skema.

| Tabel | Penentu yang diperiksa | Hasil pemeriksaan | Alasan |
|---|---|---|---|
| `PETUGAS` | `id_petugas`, `kode_petugas` | Memenuhi BCNF | Keduanya merupakan kunci kandidat. |
| `ANGGOTA` | `id_anggota`, `no_anggota`, `nim_anggota` | Memenuhi BCNF | Setiap penentu merupakan kunci kandidat. |
| `BARANG` | `id_barang`, `kode_barang` | Memenuhi BCNF | Identitas barang ditentukan oleh PK atau kode uniknya. |
| `PEMASOK` | `id_pemasok`, `kode_pemasok` | Memenuhi BCNF | Kode pemasok diperlakukan sebagai nilai unik sesuai kamus data P02. |
| `PENJUALAN` | `id_penjualan`, `no_nota_penjualan` | Memenuhi BCNF | ID penjualan dan nomor nota merupakan kunci kandidat. |
| `DETAIL_PENJUALAN` | (`id_penjualan`, `id_barang`) | Memenuhi BCNF berdasarkan FD yang dicatat | Gabungan kunci mengidentifikasi satu barang dalam satu penjualan, dengan asumsi barang yang sama hanya dicatat sekali per nota. |
| `PEMBELIAN` | `id_pembelian`, `no_faktur_pembelian` | Memenuhi BCNF | ID pembelian dan nomor faktur merupakan kunci kandidat berdasarkan aturan unik. |
| `DETAIL_PEMBELIAN` | (`id_pembelian`, `id_barang`) | Memenuhi BCNF berdasarkan FD yang dicatat | Gabungan kunci mengidentifikasi satu barang dalam satu pembelian. |

Pemeriksaan tersebut menggunakan dependensi fungsional yang sudah dicatat. Kesimpulan pada tabel detail berlaku selama asumsi satu barang hanya dicatat sekali dalam satu transaksi tetap digunakan. Jika aturan bisnis mengizinkan barang yang sama muncul pada beberapa baris, kunci pada tabel detail perlu diperiksa kembali.

## E. Latihan dan Modifikasi

### E.1 Mencatat Beberapa Nomor Telepon Pemasok

Jika satu pemasok mempunyai beberapa nomor telepon, semua nomor tersebut tidak sebaiknya digabungkan dalam satu kolom. Setiap nomor telepon perlu dicatat sebagai nilai tersendiri agar mudah dicari dan diperbarui.

Struktur relasinya dapat dibuat seperti berikut:

```text
PEMASOK (
    id_pemasok PK,
    kode_pemasok UNIQUE,
    nama_pemasok,
    alamat_pemasok
)

TELEPON_PEMASOK (
    id_pemasok FK,
    telepon_pemasok,
    PK (id_pemasok, telepon_pemasok)
)
```

Dengan tabel `TELEPON_PEMASOK`, satu pemasok bisa memiliki beberapa nomor telepon tanpa menambah kolom telepon berulang kali. Gabungan `id_pemasok` dan `telepon_pemasok` digunakan sebagai PK agar satu nomor yang sama tidak tercatat dua kali untuk pemasok yang sama.

### E.2 Anomali Ubah pada Nama Anggota

Jika `nama_anggota` disimpan langsung di tabel `PENJUALAN`, nama anggota akan berulang pada setiap nota yang dibuat anggota tersebut. Ketika nama berubah, setiap baris penjualan yang berkaitan perlu diperbarui. Jika ada baris yang terlewat, data nama anggota menjadi tidak konsisten.

Contoh data sebelum perubahan:

| no_nota_penjualan | no_anggota | nama_anggota |
|---|---|---|
| PJ-2609-0142 | A-0457 | melani saraswati|
| PJ-2609-0150 | A-0457 | sarah wartani |

Anggap nama yang benar untuk nomor anggota `A-0457` adalah `Melani Saraswati`. Pada data awal, nota kedua masih mencatat nama `Sarah Wartani`, padahal nomor anggotanya sama. Untuk memperbaikinya, gunakan kueri berikut:

```sql
UPDATE penjualan_lama
SET nama_anggota = 'Melani Saraswati'
WHERE no_nota_penjualan = 'PJ-2609-0150';
```

Hasil setelah perubahan:

| no_nota_penjualan | no_anggota | nama_anggota |
|---|---|---|
| PJ-2609-0142 | A-0457 | Melani Saraswati |
| PJ-2609-0150 | A-0457 | Melani Saraswati |

Sebelum diperbaiki, kedua baris memiliki nomor anggota yang sama tetapi nama berbeda. Setelah pembaruan dilakukan, nama pada kedua nota menjadi konsisten, sehingga contoh anomali ubah ini dapat dipahami.

Untuk mengurangi masalah tersebut, `nama_anggota` disimpan pada tabel `ANGGOTA`, sedangkan tabel `PENJUALAN` cukup menyimpan referensi ke anggota. Dengan begitu, perubahan nama cukup dilakukan pada satu baris data anggota.
