## F. Tugas Mandiri: Milestone Proyek 4

### F.1 Menentukan Dokumen Sumber dan Bentuk UNF

Pada Modul 4 ini, dokumen yang digunakan adalah Formulir Pesanan dan Pengambilan Pelanggan dari Modul 2. Dokumen tersebut dapat dilihat pada `p02_kebutuhan_data_25430043.md`.

Formulir ini mencatat informasi pesanan, seperti nomor dan tanggal pesanan, nama pelanggan, nomor WhatsApp, sumber pesanan, daftar barang, jumlah, harga satuan, serta status setiap barang. Selain itu, ada juga informasi subtotal, potongan, total, status pesanan, catatan perubahan, petugas yang menyiapkan dan memeriksa barang, serta waktu pesanan siap dan diambil.

Dalam satu pesanan, pelanggan bisa membeli lebih dari satu jenis barang. Karena itu, daftar barang pada formulir dapat berulang. Kondisi ini menjadi dasar untuk melakukan normalisasi.

Bentuk data awal atau UNF dapat digambarkan seperti berikut.

```text
PESANAN_UNF (
    no_pesanan,
    tanggal_pesanan,
    nama_pelanggan,
    no_whatsapp,
    sumber_pesanan,
    {
        kode_barang,
        nama_barang,
        qty_pesanan,
        harga_satuan_pesanan,
        status_barang_pesanan
    },
    subtotal,
    potongan,
    total,
    status_pesanan,
    catatan_perubahan,
    disiapkan_oleh,
    diperiksa_oleh,
    waktu_siap_diambil,
    waktu_diambil
)
```

Bagian yang ditulis di antara tanda `{ ... }` adalah rincian barang yang bisa muncul beberapa kali dalam satu pesanan. Data ini kemudian dipisahkan pada tahap normalisasi agar setiap jenis informasi mempunyai tempat penyimpanan yang lebih sesuai.

### F.2 Menentukan Dependensi Fungsional

Setelah menentukan bentuk data awal (UNF), langkah berikutnya adalah melihat hubungan antaratribut pada data pesanan Toko Sempurna Hemat. Dependensi fungsional digunakan untuk mengetahui atribut mana yang bergantung pada atribut lainnya. Hasil pemeriksaan ini menjadi dasar untuk memisahkan data ke dalam tabel yang lebih teratur.

Beberapa dependensi fungsional yang digunakan dalam rancangan ini adalah sebagai berikut.

| Kode | Dependensi Fungsional | Keterangan |
|---|---|---|
| FD1 | `no_pesanan` → `tanggal_pesanan`, `id_pelanggan`, `sumber_pesanan`, `status_pesanan`, `potongan` | Nomor pesanan menunjukkan informasi utama dari suatu pesanan. |
| FD2 | `id_pelanggan` → `nama_pelanggan`, `no_whatsapp` | ID pelanggan menentukan data identitas pelanggan. |
| FD3 | `kode_barang` → `nama_barang`, `kategori`, `harga_jual`, `stok`, `stok_minimum`, `barcode` | Kode barang digunakan untuk mengenali informasi barang, dengan asumsi setiap kode bersifat unik. |
| FD4 | `id_petugas` → `nama_petugas`, `peran_petugas` | ID petugas menentukan informasi petugas yang tercatat. |
| FD5 | (`no_pesanan`, `kode_barang`) → `qty_pesanan`, `harga_satuan_pesanan`, `status_barang_pesanan` | Pasangan nomor pesanan dan kode barang menentukan rincian barang, dengan asumsi satu jenis barang hanya dicatat satu kali dalam satu pesanan. |

Dependensi tersebut disusun berdasarkan struktur data yang digunakan dalam proyek. Beberapa ketergantungan masih perlu diperhatikan saat data dipisahkan ke dalam tabel, terutama informasi pelanggan, barang, dan petugas yang tidak seharusnya terus berulang pada setiap transaksi.

Untuk kunci gabungan pada rincian pesanan, digunakan asumsi bahwa satu jenis barang hanya muncul satu kali dalam satu pesanan. Jika nantinya aturan toko memperbolehkan barang yang sama dicatat pada beberapa baris berbeda, identitas setiap baris detail perlu dibedakan agar datanya tidak tertukar.

### F.3 Tahapan Normalisasi

#### F.3.1 Bentuk Normal Pertama (1NF)

Pada bentuk UNF sebelumnya, informasi barang masih ditulis sebagai kelompok yang dapat berulang dalam satu pesanan. Agar memenuhi bentuk normal pertama (1NF), setiap baris harus mewakili satu rincian barang dan tidak menyimpan daftar barang sebagai satu kelompok berulang.

Bentuk relasi 1NF secara sederhana dapat ditulis sebagai berikut.

\`\`\`text
PESANAN_1NF (
    no_pesanan,
    tanggal_pesanan,
    id_pelanggan,
    nama_pelanggan,
    no_whatsapp,
    sumber_pesanan,
    kode_barang,
    nama_barang,
    qty_pesanan,
    harga_satuan_pesanan,
    status_barang_pesanan,
    subtotal,
    potongan,
    total,
    status_pesanan,
    catatan_perubahan,
    disiapkan_oleh,
    diperiksa_oleh,
    waktu_siap_diambil,
    waktu_diambil
)
\`\`\`

Pada tahap ini, satu baris mencatat satu jenis barang dalam suatu pesanan. Jika satu pesanan berisi beberapa jenis barang, nomor pesanan dan informasi tingkat pesanan dapat muncul pada beberapa baris. Pengulangan tersebut masih dapat terjadi pada 1NF, sehingga tahap berikutnya diperlukan untuk memisahkan atribut sesuai ketergantungannya.

Bentuk 1NF ini menjadi dasar untuk melanjutkan normalisasi ke bentuk normal kedua (2NF) dan bentuk normal ketiga (3NF).
### 3NF

Pada tahap 3NF, atribut yang bergantung pada atribut bukan kunci dipisahkan agar tidak terjadi ketergantungan transitif. Contohnya, `kode_petugas` menentukan nama dan peran petugas, sedangkan `no_anggota` menentukan data anggota. Karena itu, data petugas dan anggota disimpan pada tabel masing-masing.

Hasil relasi 3NF yang mengikuti skema pada buku adalah sebagai berikut.

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

Pada skema tersebut, `DETAIL_PENJUALAN` menggunakan gabungan `no_nota_penjualan` dan `kode_barang` sebagai kunci. Harga satuan disimpan pada detail transaksi agar perubahan harga jual pada tabel `BARANG` tidak mengubah harga transaksi sebelumnya.

Atribut `bayar_penjualan` dipertahankan pada skema relasional hasil normalisasi karena sudah tercantum pada entitas `PENJUALAN` di ERD P03 Kopma. Atribut ini tidak tercantum pada bentuk UNF contoh buku, sehingga penempatannya merupakan penyesuaian saat hasil normalisasi dipetakan ke rancangan Kopma.

Sesuai keputusan dalam buku, `subtotal_detail_penjualan`, `jumlah_penjualan`, dan `total_penjualan` dihitung dari rincian transaksi serta status anggota, sehingga tidak disimpan sebagai atribut dasar pada tabel operasional. `diskon_penjualan` juga tidak disimpan secara terpisah karena besarnya mengikuti aturan diskon anggota aktif pada AB-02. Keputusan ini membantu menghindari ketidaksesuaian antara nilai turunan dan data transaksi.

Atribut master seperti `kategori_barang`, `harga_jual_barang`, `stok_barang`, dan `stok_min_barang` berasal dari kamus data P02 Kopma. Atribut tersebut melengkapi tabel `BARANG` pada saat hasil normalisasi disesuaikan dengan kebutuhan data proyek.

#### F.3.2 Bentuk Normal Kedua (2NF)

Setelah data disusun dalam bentuk 1NF, masih ada atribut yang bergantung pada sebagian kunci gabungan. Sebagai contoh, nama barang bergantung pada kode barang, sedangkan tanggal dan status pesanan bergantung pada nomor pesanan.

Jika semua informasi tersebut disimpan dalam satu relasi, nama barang dan informasi pesanan akan berulang pada setiap baris detail. Karena itu, data dipisahkan menjadi tiga relasi berikut.

| Nama Relasi | Atribut | Kunci |
|---|---|---|
| `PESANAN_2NF` | `no_pesanan`, `tanggal_pesanan`, `id_pelanggan`, `nama_pelanggan`, `no_whatsapp`, `sumber_pesanan`, `status_pesanan`, `potongan`, `catatan_perubahan`, `disiapkan_oleh`, `diperiksa_oleh`, `waktu_siap_diambil`, `waktu_diambil` | PK: `no_pesanan` |
| `BARANG_2NF` | `kode_barang`, `nama_barang` | PK: `kode_barang` |
| `DETAIL_PESANAN_2NF` | `no_pesanan`, `kode_barang`, `qty_pesanan`, `harga_satuan_pesanan`, `status_barang_pesanan` | PK: (`no_pesanan`, `kode_barang`) |

Dengan pembagian ini, `PESANAN_2NF` menyimpan informasi utama pesanan, `BARANG_2NF` menyimpan identitas barang, dan `DETAIL_PESANAN_2NF` mencatat barang yang dipesan beserta jumlah, harga satuan, dan statusnya.

Kunci gabungan pada `DETAIL_PESANAN_2NF` masih mengikuti asumsi satu jenis barang hanya dicatat satu kali dalam satu pesanan. Kunci tersebut digunakan untuk menjelaskan proses normalisasi, sehingga tidak harus sama dengan kunci yang dipilih pada ERD akhir.

Pada tahap ini, `no_pesanan` dan `kode_barang` masih digunakan karena mengikuti formulir sumber. Ketika diterapkan pada ERD, keduanya dipadankan dengan `id_pesanan` dan `id_barang`. Pada diagram P04, identitas setiap baris detail menggunakan `id_detail_pesanan`, sedangkan keunikan pasangan pesanan dan barang dapat diterapkan jika memang diperlukan oleh aturan bisnis toko.

#### F.3.3 Bentuk Normal Ketiga (3NF)

Pada tahap 3NF, data diperiksa kembali untuk melihat apakah ada atribut yang sebaiknya disimpan pada tabel lain. Contohnya, nama dan nomor WhatsApp merupakan informasi milik pelanggan, bukan informasi yang perlu diulang pada setiap pesanan.

Karena itu, data pelanggan dipisahkan dari data pesanan. Data barang dan petugas juga disimpan pada tabel masing-masing. Sementara itu, jumlah, harga satuan, dan status barang tetap dicatat pada detail pesanan.

Hasil rancangan relasinya adalah sebagai berikut.

| Nama Relasi | Atribut | Kunci |
|---|---|---|
| `PELANGGAN` | `id_pelanggan`, `nama_pelanggan`, `no_whatsapp` | PK: `id_pelanggan` |
| `PETUGAS` | `id_petugas`, `nama_petugas`, `peran_petugas` | PK: `id_petugas` |
| `BARANG` | `id_barang`, `kode_barang`, `nama_barang`, `kategori`, `harga_jual`, `stok`, `stok_minimum`, `barcode` | PK: `id_barang`; `kode_barang` unik |
| `PESANAN` | `id_pesanan`, `no_pesanan`, `id_pelanggan`, `tanggal_pesanan`, `sumber_pesanan`, `status_pesanan`, `potongan`, `id_petugas_penyiap`, `id_petugas_pemeriksa`, `waktu_siap_diambil`, `waktu_diambil` | PK: `id_pesanan`; FK: `id_pelanggan`, `id_petugas_penyiap`, `id_petugas_pemeriksa`; `no_pesanan` unik |
| `DETAIL_PESANAN` | `id_detail_pesanan`, `id_pesanan`, `id_barang`, `qty`, `harga_satuan`, `status_barang` | PK: `id_detail_pesanan`; FK: `id_pesanan`, `id_barang` |
| `RIWAYAT_PERUBAHAN_PESANAN` | `id_perubahan_pesanan`, `id_pesanan`, `id_detail_pesanan` (opsional), `id_petugas`, `waktu_perubahan_pesanan`, `jenis_perubahan_pesanan`, `keterangan_perubahan` | PK: `id_perubahan_pesanan`; FK ke pesanan, detail pesanan jika terkait, dan petugas |

Tabel `PESANAN` terhubung dengan `PELANGGAN` serta `PETUGAS` yang menyiapkan dan memeriksa pesanan. Rincian setiap barang disimpan dalam `DETAIL_PESANAN`, sedangkan identitas petugas disimpan dalam `PETUGAS` agar tidak perlu menulis ulang informasi petugas pada banyak pesanan.

Pada formulir sumber P02 terdapat kolom untuk petugas yang menyiapkan dan memeriksa barang. Kedua kolom tersebut dipetakan menjadi FK pada `PESANAN`. Selain itu, kolom catatan perubahan dikembangkan menjadi `RIWAYAT_PERUBAHAN_PESANAN` agar perubahan pesanan bisa dicatat sebagai riwayat tersendiri.

Tabel riwayat ini menyimpan waktu, jenis perubahan, petugas yang mencatat, dan keterangan perubahan. `id_detail_pesanan` dapat diisi apabila perubahan berkaitan dengan satu baris barang tertentu. Jika perubahan hanya berkaitan dengan kondisi pesanan secara umum, detail barang tidak harus dirujuk.

Pada hasil 3NF, `id_detail_pesanan` dipakai sebagai identitas setiap baris detail agar riwayat perubahan dapat menunjuk ke baris yang tepat. Keputusan tersebut sudah diterapkan pada salinan ERD Modul 4, sedangkan file P03 tidak diubah.

Nama atribut pada diagram dibuat lebih ringkas daripada istilah pada kamus data P02. Sebagai contoh, `qty`, `harga_satuan`, dan `status_barang` pada ERD mengacu pada `qty_pesanan`, `harga_satuan_pesanan`, dan `status_barang_pesanan` pada P02. Perbedaan nama ini perlu dijaga konsistensinya ketika rancangan digunakan untuk membuat tabel di MariaDB.

Nilai `subtotal` dan `total` tidak dimasukkan sebagai atribut dasar dalam relasi hasil normalisasi karena keduanya bisa dihitung dari detail pesanan dan nilai potongan. Keputusan tersebut dijelaskan lebih lanjut pada bagian F.4.

#### F.3.4 Pemeriksaan Bentuk Normal Boyce-Codd (BCNF)

Setelah menyusun relasi sampai 3NF, pemeriksaan dilanjutkan untuk melihat apakah atribut penentu pada setiap ketergantungan fungsional merupakan superkey. Pemeriksaan ini dilakukan berdasarkan ketergantungan fungsional yang sudah dicatat, sehingga hasilnya masih berupa pemeriksaan awal.

| Relasi | Ketergantungan yang diperiksa | Hasil awal | Alasan |
|---|---|---|---|
| `PELANGGAN` | `id_pelanggan` → `nama_pelanggan`, `no_whatsapp` | Memenuhi BCNF berdasarkan FD yang dicatat | `id_pelanggan` merupakan PK. |
| `PETUGAS` | `id_petugas` → `nama_petugas`, `peran_petugas` | Memenuhi BCNF berdasarkan FD yang dicatat | `id_petugas` merupakan PK. |
| `BARANG` | `id_barang` → atribut barang lainnya | Memenuhi BCNF berdasarkan FD yang dicatat | `id_barang` merupakan PK. `kode_barang` juga harus unik sesuai AB-01. |
| `PESANAN` | `id_pesanan` → atribut pesanan lainnya | Memenuhi BCNF berdasarkan FD yang dicatat | `id_pesanan` merupakan PK. |
| `DETAIL_PESANAN` | `id_detail_pesanan` → atribut rincian pesanan | Perlu dikonfirmasi berdasarkan aturan keunikan | `id_detail_pesanan` menjadi PK. Namun, jika pasangan `id_pesanan` dan `id_barang` juga menentukan atribut rincian, perlu dipastikan apakah pasangan tersebut merupakan superkey agar kesimpulan BCNF dapat ditetapkan. |

Hasil ini didasarkan pada FD yang sudah dituliskan, sehingga belum dapat dianggap sebagai pembuktian lengkap untuk semua kemungkinan aturan bisnis. Pada tabel `BARANG`, misalnya, `kode_barang` juga menjadi calon kunci jika keunikannya benar-benar diterapkan sebagai constraint.

Pada `DETAIL_PESANAN`, penggunaan `id_detail_pesanan` sebagai PK tidak otomatis berarti pasangan `id_pesanan` dan `id_barang` harus unik. Keputusan tersebut bergantung pada aturan toko. Jika satu jenis barang memang hanya boleh muncul sekali dalam satu pesanan, keunikan pasangan tersebut perlu ditegakkan pada skema fisik.

Dengan demikian, pemeriksaan BCNF ini menjadi dasar awal sebelum rancangan diterapkan ke database. Aturan keunikan dan ketergantungan fungsional perlu tetap diperhatikan saat membuat constraint tabel.

### F.4 Keputusan Penyimpanan Nilai Turunan

Formulir pada P02 mencantumkan subtotal, potongan, dan total pesanan. Ketiga nilai tersebut perlu dipertimbangkan agar data tidak disimpan berulang tanpa kebutuhan.

| Nilai | Cara menghitung | Keputusan | Alasan |
|---|---|---|---|
| Subtotal pesanan | Jumlah seluruh (`qty_pesanan` × `harga_satuan_pesanan`) | Dihitung dari detail pesanan | Subtotal bisa diperoleh dari jumlah dan harga satuan setiap barang. |
| Potongan | Mengikuti nilai potongan yang diberikan pada pesanan | Disimpan | Potongan merupakan nilai yang ditetapkan untuk pesanan dan digunakan untuk menghitung total. |
| Total pesanan | Subtotal pesanan − potongan | Dihitung dari subtotal dan potongan | Total dapat diperoleh dari nilai subtotal dan potongan. |

Harga satuan tetap dicatat pada `DETAIL_PESANAN` karena harga tersebut menggambarkan harga ketika barang dimasukkan ke pesanan. Jika harga jual pada tabel `BARANG` berubah, harga pada pesanan lama tetap bisa diketahui.

Perhitungan subtotal dan total digunakan untuk menampilkan nilai pesanan. Jika terjadi perubahan pada isi pesanan, perubahan tersebut juga harus tercatat pada riwayatnya. Dengan begitu, perubahan atau pembatalan barang tidak menghilangkan informasi mengenai proses pesanan sebelumnya, sesuai aturan AB-08, AB-09, dan AB-17.

### F.5 Perubahan ERD dan Alasannya

Setelah hasil normalisasi dibandingkan dengan ERD P03 dan kebutuhan data P02, ada beberapa bagian yang disesuaikan pada salinan ERD Modul 4. Perubahan ini tidak menggantikan file `p03_erd_25430043.drawio`, karena file tersebut tetap menjadi hasil rancangan pada Modul 3.

| No. | Bagian ERD | Perubahan pada ERD Modul 4 | Alasan |
|---:|---|---|---|
| 1 | `DETAIL_PESANAN` | Menggunakan `id_detail_pesanan` sebagai PK. Atribut `id_pesanan` dan `id_barang` menjadi FK. Kolom jumlah, harga satuan, dan status barang ditulis sebagai `qty`, `harga_satuan`, dan `status_barang`. | Kamus data P02 sudah mencantumkan `id_detail_pesanan`, sedangkan ERD asli P03 menggunakan kunci gabungan. PK tersendiri membuat setiap baris detail dapat dirujuk oleh riwayat perubahan. Keunikan pasangan `id_pesanan` dan `id_barang` perlu diterapkan jika aturan toko mengharuskannya. |
| 2 | `PESANAN` | Memuat atribut `potongan`, FK `id_petugas_penyiap` dan `id_petugas_pemeriksa`, serta `waktu_siap_diambil` dan `waktu_diambil`. | Kolom tersebut mengikuti informasi yang tercantum pada Formulir Pesanan dan Pengambilan di P02. Relasi ke `PETUGAS` memungkinkan pihak yang menyiapkan dan memeriksa pesanan diketahui. |
| 3 | `RIWAYAT_PERUBAHAN_PESANAN` | Menambahkan tabel yang memuat `id_perubahan_pesanan`, `id_pesanan`, `id_detail_pesanan` yang opsional, `id_petugas`, waktu, jenis, dan keterangan perubahan. | AB-08, AB-09, dan AB-17 menyatakan bahwa penambahan atau pembatalan barang harus dicatat dan riwayatnya tetap disimpan. Tabel ini mendukung KI-02 agar perubahan tidak hanya bergantung pada percakapan WhatsApp. |
| 4 | `PENERIMAAN_BARANG` | Menambahkan FK `id_pesanan_pembelian` sebagai penghubung ke `PESANAN_PEMBELIAN`. Atribut `id_pemasok` tidak disimpan lagi pada tabel penerimaan; data pemasok dapat ditelusuri melalui pesanan pembelian. | AB-11 dan KI-05 membutuhkan hubungan yang jelas antara barang yang dipesan dan barang yang diterima. Dengan asumsi satu penerimaan mengacu pada satu pesanan pembelian, data pemasok sudah dapat diketahui melalui pesanan tersebut sehingga tidak perlu disimpan dua kali. |
| 5 | Petugas pemeriksa penerimaan | Menambahkan FK `id_petugas_pemeriksa` pada `PENERIMAAN_BARANG` dan relasi ke `PETUGAS`. | AB-13 meminta agar pihak yang memeriksa barang dapat diketahui ketika terjadi selisih. Kolom `diperiksa_oleh` pada kamus data P02 dipetakan ke referensi petugas tersebut. |
| 6 | Relasi pesanan pembelian dengan penerimaan | Satu `PESANAN_PEMBELIAN` dapat terhubung ke nol atau banyak `PENERIMAAN_BARANG`, sedangkan satu penerimaan mengacu pada satu pesanan pembelian. | Relasi ini memungkinkan barang dari satu pesanan pembelian datang secara bertahap. Hubungan ini juga menjadi dasar untuk membandingkan jumlah yang dipesan dengan jumlah yang diterima sesuai AB-11, AB-12, dan KI-05. |
| 7 | `PROGRAM_HADIAH_BARANG` | Menambahkan tabel penghubung dengan PK gabungan yang sekaligus menjadi FK, yaitu `id_program` dan `id_barang`. Tabel ini menghubungkan `PROGRAM_HADIAH` dengan `BARANG`. | AB-16 menjelaskan bahwa program hadiah atau promosi berlaku untuk produk tertentu. Tabel penghubung memungkinkan satu program mencakup beberapa barang dan satu barang masuk ke beberapa program. Sementara itu, `KLAIM_HADIAH` tetap menghubungkan program dengan pelanggan untuk membantu penelusuran klaim sesuai KI-08. |
| 8 | Subtotal dan total pesanan | Subtotal dihitung dari jumlah setiap barang dikali harga satuannya, lalu total dihitung dari subtotal dikurangi potongan. Nilai `potongan` tetap disimpan di `PESANAN`. | Keputusan ini mengikuti bagian F.4. Subtotal dan total dapat dihitung, sedangkan harga satuan ketika pemesanan tetap disimpan agar harga transaksi lama tidak berubah ketika harga jual barang diperbarui. |
| 9 | Penamaan atribut | Sejumlah nama atribut pada diagram dibuat lebih singkat, seperti `kategori`, `no_telepon`, `no_dokumen`, `status`, `jumlah_bayar`, dan `selisih`. | Nama tersebut mengacu pada elemen data di P02, misalnya `kategori_barang`, `no_telepon_pemasok`, `no_dokumen_penerimaan`, `status_pesanan_pembelian`, `jumlah_pembayaran`, dan `selisih_penerimaan`. Saat dibuat menjadi tabel database, nama atribut harus disesuaikan secara konsisten. |

Ada satu asumsi penting pada relasi penerimaan barang. Diagram saat ini menganggap satu catatan penerimaan mengacu pada satu pesanan pembelian, sedangkan satu pesanan pembelian dapat mempunyai beberapa catatan penerimaan. Asumsi ini cocok untuk kondisi barang yang datang secara bertahap. Namun, jika dalam proses nyata satu dokumen penerimaan bisa mencakup barang dari beberapa pesanan pembelian sekaligus, rancangan perlu dikembangkan dengan tabel penghubung tambahan.

Untuk memenuhi KI-05, jumlah yang diterima juga perlu dibandingkan dengan jumlah yang dipesan. Jika satu pesanan pembelian memiliki beberapa penerimaan, jumlah `qty_terima` untuk barang yang sama harus dijumlahkan terlebih dahulu sebelum dibandingkan dengan `qty_pesan`. Kolom `selisih` pada `DETAIL_PENERIMAAN` mengikuti kebutuhan data P02, tetapi aturan perhitungannya perlu ditetapkan secara jelas ketika database dibuat agar selisih pada satu penerimaan tidak tertukar dengan selisih total pesanan pembelian.

Secara keseluruhan, ERD Modul 4 sudah menambahkan hubungan yang sebelumnya belum tergambar dengan jelas, terutama pada riwayat perubahan pesanan, penerimaan barang dari pemasok, pencatatan petugas pemeriksa, dan hubungan program hadiah dengan barang. File P03 tetap dipertahankan, sedangkan perubahan ini diterapkan pada salinan ERD khusus Modul 4.

![ERD hasil pembaruan Modul 4](laporan/img/p04_erd_update_25430043.drawio.png)
