# Dokumen Kebutuhan Data - Toko Sempurna Hemat

- **Disusun oleh:** HILMAN AHMAD ROSYAD
- **NIM:** 25430043
- **Kelas:** B
- **Mata kuliah:** Praktikum Basis Data
- **Milestone:** Proyek 2 (Pertemuan 2)
- **Tema:** Toko Daring (kode tema: `tokodaring`)

## 1. Latar belakang dan aktivitas organisasi

Toko Sempurna Hemat merupakan toko yang menjual berbagai macam kebutuhan
sehari-hari. Barang yang dijual cukup beragam, mulai dari makanan ringan seperti
Chiki dan kerupuk, minuman, susu, sampo, korek, obat-obatan, sembako, sampai
kebutuhan rumah tangga. Toko ini melayani pembeli dari berbagai kalangan. Ada
yang datang langsung ke toko untuk belanja, dan ada juga yang memesan dari jauh
sebelum datang ke toko.

Dalam kegiatan sehari-hari, toko masih menggunakan aplikasi kasir pihak ketiga
yang diunduh melalui Play Store dan belum mempunyai sistem kasir yang dibuat
khusus untuk kebutuhan toko sendiri. Penggunaan aplikasi tersebut masih memiliki
beberapa kendala. Salah satunya adalah pencarian barang dan harga yang terkadang
harus dilakukan secara manual. Selain itu, tidak semua barang mempunyai barcode.
Beberapa barang seperti kerupuk atau jajanan tertentu tidak memiliki barcode,
sehingga proses pencarian barang menjadi lebih lama.

Toko juga ingin mengurangi antrean, terutama untuk pelanggan yang membeli
banyak barang. Karena itu, pelanggan dapat melakukan pemesanan dari jarak jauh
melalui WhatsApp. Saat ini pesanan tersebut biasanya diterima oleh ibu, kemudian
barang disiapkan oleh pihak toko. Setelah semua barang selesai disiapkan,
pelanggan datang sendiri ke toko untuk mengambil pesanannya. Toko tidak
menyediakan pengiriman barang untuk pesanan tersebut.

Dalam pelaksanaannya masih terdapat beberapa kendala. Pelanggan terkadang harus
menghubungi WhatsApp untuk menanyakan apakah pesanannya sudah selesai atau
sudah bisa diambil. Ada juga pelanggan yang setelah datang ke toko masih ingin
menambahkan barang dan akhirnya memesan barang tambahan melalui WhatsApp.
Sebaliknya, ada pelanggan yang membatalkan sebagian barang ketika pesanan sedang
disiapkan. Perubahan seperti ini cukup sulit dicatat jika hanya mengandalkan
percakapan WhatsApp.

Masalah juga terjadi pada saat barang datang dari pemasok. Barang yang datang
tidak selalu sesuai dengan jumlah yang dipesan. Misalnya, toko sudah memesan
empat kardus barang tetapi yang datang ternyata hanya tiga kardus. Proses
pengecekan biasanya dilakukan bersama oleh pihak toko dan sales, tetapi masih
bisa terjadi kekeliruan saat menghitung barang. Barang yang awalnya dianggap
sudah lengkap terkadang baru diketahui kurang setelah diperiksa kembali. Jika
selisih tersebut tidak dicatat dengan baik, toko dapat mengalami kerugian.

Selain itu, terdapat produk tertentu yang mempunyai program hadiah dari
produsen. Ketika pelanggan yang membeli untuk warung ingin menukarkan hadiah,
prosesnya terkadang terkendala karena penukaran harus dilakukan melalui aplikasi
milik produsen. Toko juga memiliki tagihan dari pemasok, seperti Indogrosir,
yang terkadang terlupakan karena belum ada sistem yang memberikan pengingat
mengenai tagihan dan tanggal jatuh tempo.

Dari beberapa kondisi tersebut, toko membutuhkan sistem yang dapat membantu
mengatur data produk, harga, stok, pelanggan, pesanan, pembayaran, penerimaan
barang, selisih barang, informasi hadiah, dan tagihan pemasok. Sistem tersebut
juga diharapkan dapat membantu pelanggan melakukan pemesanan sebelum datang ke
toko, mengurangi waktu antre, memudahkan pihak toko dalam menyiapkan pesanan,
serta membuat riwayat transaksi dan kegiatan toko lebih mudah dicari kembali.

## 2. Aktor dan proses bisnis

Aktor dalam proses bisnis Toko Sempurna Hemat dibedakan berdasarkan perannya
dalam kegiatan toko. Petugas Toko dapat melayani pembeli dan membantu proses
penerimaan maupun penyiapan barang. Admin Pesanan saat ini terutama dilakukan
oleh ibu yang menerima pesanan melalui WhatsApp. Pengelola Toko adalah pihak
yang mengatur kegiatan operasional dan pembelian barang. Pemasok atau sales
berperan dalam proses pemesanan dan pengiriman barang ke toko.

| Kode | Proses bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Menambah dan memperbarui data barang | Pengelola Toko, Petugas Toko | Ada barang baru yang dijual atau informasi barang perlu diperbarui |
| PB-02 | Memperbarui harga barang | Pengelola Toko, Petugas Toko | Harga dari pemasok berubah atau harga jual toko diperbarui |
| PB-03 | Melayani pembelian langsung di toko | Pelanggan, Petugas Toko | Pelanggan datang langsung dan ingin membeli barang |
| PB-04 | Mencari barang dan harga saat transaksi | Petugas Toko | Kasir perlu mengetahui barang, harga, atau stok sebelum transaksi dilakukan |
| PB-05 | Menerima pesanan pelanggan melalui WhatsApp atau aplikasi | Pelanggan, Admin Pesanan | Pelanggan ingin memesan barang sebelum datang ke toko |
| PB-06 | Mengecek ketersediaan barang yang dipesan | Admin Pesanan, Petugas Toko | Pesanan pelanggan sudah diterima dan perlu diperiksa |
| PB-07 | Mencatat dan memproses pesanan pelanggan | Admin Pesanan, Petugas Toko | Barang yang dipesan tersedia dan pesanan mulai diproses |
| PB-08 | Menambah barang ke pesanan yang sudah dibuat | Pelanggan, Admin Pesanan | Pelanggan ingin membeli barang tambahan setelah pesanan sebelumnya dibuat |
| PB-09 | Membatalkan sebagian barang dalam pesanan | Pelanggan, Admin Pesanan, Petugas Toko | Pelanggan tidak jadi mengambil atau membeli sebagian barang yang sudah dipesan |
| PB-10 | Menyiapkan dan memeriksa barang pesanan | Petugas Toko | Pesanan sudah diproses dan barang perlu disiapkan sebelum diambil |
| PB-11 | Mengubah status pesanan | Admin Pesanan, Petugas Toko | Pesanan berpindah dari proses awal sampai selesai disiapkan atau selesai diambil |
| PB-12 | Menyerahkan pesanan kepada pelanggan | Pelanggan, Petugas Toko | Pelanggan datang ke toko untuk mengambil pesanan yang sudah siap |
| PB-13 | Mencatat pembayaran pelanggan | Pelanggan, Petugas Toko | Pelanggan melakukan pembayaran atas barang atau pesanan |
| PB-14 | Memeriksa dan memperbarui stok barang | Petugas Toko, Pengelola Toko | Barang terjual, barang masuk, barang rusak, atau jumlah stok berubah |
| PB-15 | Membuat pesanan barang kepada pemasok | Pengelola Toko | Stok barang perlu ditambah atau toko melakukan pemesanan rutin |
| PB-16 | Menerima dan memeriksa barang dari pemasok | Pengelola Toko, Petugas Toko, Sales/Pemasok | Barang pesanan datang ke toko bersama informasi atau dokumen pembelian |
| PB-17 | Mencatat selisih barang yang dipesan dan yang diterima | Pengelola Toko, Petugas Toko | Jumlah fisik barang yang datang berbeda dengan jumlah yang dipesan |
| PB-18 | Menindaklanjuti kekurangan atau kelebihan barang yang diterima | Pengelola Toko, Pemasok/Sales | Ditemukan perbedaan antara jumlah barang pada pesanan dan jumlah barang yang diterima |
| PB-19 | Mencatat dan memantau tagihan pemasok | Pengelola Toko | Toko menerima tagihan dari pemasok dan perlu mengetahui jumlah serta jatuh temponya |
| PB-20 | Mencatat pembayaran tagihan pemasok | Pengelola Toko | Tagihan pemasok sudah dibayar atau akan diselesaikan |
| PB-21 | Mencatat informasi hadiah atau program promosi produk | Petugas Toko, Pengelola Toko | Pelanggan menanyakan atau ingin menukarkan hadiah dari program produk tertentu |
| PB-22 | Memantau status dan riwayat pesanan pelanggan | Pelanggan, Admin Pesanan, Petugas Toko | Pelanggan atau pihak toko ingin mengetahui perkembangan atau riwayat pesanan |
| PB-23 | Membuat laporan kegiatan toko | Pengelola Toko | Pemilik toko membutuhkan informasi mengenai penjualan, stok, pesanan, atau tagihan |
| PB-24 | Mengelola data petugas | Pengelola Toko | Ada petugas baru, perubahan data petugas, atau data petugas perlu diperbarui |
| PB-25 | Mengelola data pemasok | Pengelola Toko | Ada pemasok baru atau informasi pemasok perlu diperbarui |
| PB-26 | Mencatat klaim hadiah pelanggan | Pelanggan, Petugas Toko | Pelanggan mengajukan atau menyelesaikan klaim hadiah |

## 3. Dokumen sumber yang dianalisis

Untuk menggali kebutuhan data Toko Sempurna Hemat, digunakan beberapa dokumen
sumber fiktif yang dirancang berdasarkan kegiatan operasional toko. Dokumen ini
digunakan untuk melihat data apa saja yang muncul dalam proses bisnis dan data
mana yang perlu disimpan agar dapat digunakan kembali.

Dokumen sumber yang dianalisis terdiri dari:
1. Formulir Pesanan dan Pengambilan Pelanggan
2. Formulir Penerimaan Barang dari Pemasok
3. Catatan Tagihan Pemasok

### 3.1 Formulir Pesanan dan Pengambilan Pelanggan

Dokumen ini digunakan untuk mencatat pesanan pelanggan yang diterima melalui
WhatsApp atau aplikasi. Pesanan disiapkan oleh pihak toko dan pelanggan datang
sendiri ke toko untuk mengambil barang.

```text
==================================================================
                    TOKO SEMPURNA HEMAT
               FORMULIR PESANAN DAN PENGAMBILAN
==================================================================

No. Pesanan        :
Tanggal Pesanan    :
Nama Pelanggan     :
No. WhatsApp       :
Sumber Pesanan     : WhatsApp / Aplikasi

------------------------------------------------------------------
| No | Kode Barang | Nama Barang | Qty | Harga | Status Barang |
|----|-------------|-------------|-----|-------|---------------|
| 1  |             |             |     |       |               |
| 2  |             |             |     |       |               |
| 3  |             |             |     |       |               |
| 4  |             |             |     |       |               |
------------------------------------------------------------------

Subtotal           :
Potongan           :
Total              :

Status Pesanan     :
Catatan Perubahan  :

------------------------------------------------------------------
Disiapkan Oleh     :
Diperiksa Oleh     :
Waktu Siap Diambil :
Waktu Diambil      :
=================================================================


## 4. Entitas kandidat dan elemen data

### 4.1 Daftar entitas kandidat

| Entitas kandidat | Elemen data utama | Sumber |
|---|---|---|
| **Pelanggan** | id_pelanggan, nama_pelanggan, no_whatsapp | Formulir Pesanan dan Pengambilan |
| **Petugas** | id_petugas, nama_petugas, peran_petugas | Proses operasional toko |
| **Barang** | id_barang, kode_barang, nama_barang, kategori, harga_jual, stok, stok_minimum, barcode | Formulir Pesanan dan Pengambilan, penerimaan barang |
| **Pesanan** | id_pesanan, no_pesanan, tanggal_pesanan, sumber_pesanan, status_pesanan | Formulir Pesanan dan Pengambilan |
| **Detail Pesanan** | id_pesanan, id_barang, qty, harga_satuan, status_barang | Formulir Pesanan dan Pengambilan |
| **Penjualan** | id_penjualan, no_nota, tanggal_penjualan, id_petugas, metode_pembayaran | Proses pembelian langsung dan pengambilan pesanan |
| **Detail Penjualan** | id_penjualan, id_barang, qty, harga_satuan | Proses transaksi penjualan |
| **Pemasok** | id_pemasok, nama_pemasok, no_telepon, alamat | Formulir Penerimaan Barang, Catatan Tagihan |
| **Pesanan Pembelian** | id_pesanan_pembelian, no_pesanan_pembelian, tanggal_pemesanan, id_pemasok, status | Proses pemesanan barang ke pemasok |
| **Detail Pesanan Pembelian** | id_pesanan_pembelian, id_barang, qty_pesan, harga_beli | Proses pemesanan barang ke pemasok |
| **Penerimaan Barang** | id_penerimaan, no_penerimaan, tanggal_penerimaan, id_pemasok, no_dokumen, status_penerimaan | Formulir Penerimaan Barang |
| **Detail Penerimaan** | id_penerimaan, id_barang, qty_terima, selisih | Formulir Penerimaan Barang |
| **Tagihan Pemasok** | id_tagihan, no_tagihan, id_pemasok, no_faktur, tanggal_tagihan, jatuh_tempo, jumlah_tagihan, status_pembayaran | Catatan Tagihan Pemasok |
| **Program Hadiah** | id_program, nama_program, keterangan, periode | Proses hadiah/promosi produk |
| **Klaim Hadiah** | id_klaim, id_program, id_pelanggan, tanggal_klaim, status_klaim | Proses klaim hadiah pelanggan |

### 4.2 Keterangan entitas kandidat

**Pelanggan** digunakan untuk menyimpan identitas pelanggan yang melakukan
pemesanan atau transaksi. Nomor WhatsApp diperlukan terutama untuk komunikasi
mengenai pesanan.

**Petugas** digunakan untuk mencatat pihak yang menjalankan kegiatan toko,
seperti menerima pesanan, menyiapkan barang, memeriksa barang, atau mengelola
kegiatan operasional.

**Barang** digunakan untuk menyimpan informasi barang yang dijual serta kondisi
stoknya. Kode barang dapat berasal dari barcode pabrik jika tersedia atau kode
internal toko untuk barang yang tidak memiliki barcode.

**Pesanan** merupakan data utama dari pemesanan pelanggan. Entitas ini
menyimpan informasi umum pesanan dan statusnya sampai pelanggan mengambil
pesanan di toko.

**Detail Pesanan** digunakan untuk mencatat barang yang terdapat dalam setiap
pesanan. Entitas ini diperlukan karena satu pesanan dapat berisi banyak jenis
barang.

**Penjualan** digunakan untuk mencatat transaksi pembelian yang dilakukan
pelanggan, baik pembelian langsung di toko maupun transaksi yang berkaitan
dengan pengambilan pesanan.

**Detail Penjualan** digunakan untuk mencatat barang yang masuk ke dalam
setiap transaksi penjualan, termasuk jumlah dan harga barang pada saat
transaksi.

**Pemasok** digunakan untuk menyimpan data pihak yang memasok barang ke toko,
termasuk informasi kontak yang diperlukan untuk kegiatan pemesanan dan
penyelesaian tagihan.

**Pesanan Pembelian** digunakan untuk mencatat pemesanan barang kepada
pemasok sebelum barang tersebut datang ke toko.

**Detail Pesanan Pembelian** digunakan untuk mencatat barang yang dipesan dari
pemasok beserta jumlah dan harga belinya.

**Penerimaan Barang** digunakan untuk mencatat kedatangan barang dari pemasok
serta dokumen yang berkaitan dengan penerimaan tersebut.

**Detail Penerimaan** digunakan untuk mencatat jumlah barang yang benar-benar
diterima dan membandingkannya dengan jumlah yang dipesan sehingga selisih
barang dapat diketahui.

**Tagihan Pemasok** digunakan untuk mencatat tagihan yang diterima toko dari
pemasok, termasuk jumlah tagihan dan tanggal jatuh tempo agar tagihan dapat
dipantau.

**Program Hadiah** digunakan untuk mencatat informasi program hadiah atau
promosi dari produk tertentu. Data ini bersifat internal dan digunakan untuk
membantu toko menelusuri informasi program.

**Klaim Hadiah** digunakan untuk mencatat pelanggan yang mengajukan atau
melakukan klaim hadiah beserta tanggal dan status klaimnya.

## 5. Aturan bisnis

Aturan bisnis berikut disusun dari kegiatan yang dilakukan di Toko Sempurna
Hemat dan dari masalah yang ditemukan selama proses pengamatan. Aturan ini
digunakan sebagai dasar untuk menentukan data yang perlu dicatat dan bagaimana
data tersebut diperlakukan di dalam sistem.

| Kode | Aturan bisnis |
|---|---|
| AB-01 | Setiap barang yang dijual harus mempunyai kode barang yang tidak sama dengan barang lain. Kode ini digunakan untuk mencari barang ketika barcode tidak tersedia. |
| AB-02 | Barang yang mempunyai barcode dari produsen dapat dicatat menggunakan barcode tersebut, sedangkan barang yang tidak mempunyai barcode, seperti sebagian jajanan atau kerupuk, tetap harus mempunyai kode internal toko. |
| AB-03 | Harga jual dan informasi stok barang dapat diperbarui oleh pihak toko sesuai kondisi barang dan harga yang sedang berlaku. Perubahan tersebut tidak boleh mengubah riwayat transaksi yang sudah terjadi. |
| AB-04 | Jumlah stok tidak boleh menjadi negatif. Barang hanya boleh dikeluarkan dari stok sesuai jumlah yang tersedia dan jumlah yang benar-benar terjual atau diproses. |
| AB-05 | Setiap pesanan pelanggan harus mempunyai nomor pesanan yang berbeda dan sekurang-kurangnya mencatat barang yang ingin dibeli oleh pelanggan. |
| AB-06 | Pesanan yang diterima melalui WhatsApp atau aplikasi disiapkan oleh pihak toko untuk diambil langsung oleh pelanggan di toko. Toko tidak melakukan pengiriman barang kepada pelanggan untuk alur pesanan tersebut. |
| AB-07 | Setiap pesanan harus memiliki status agar pihak toko dapat mengetahui apakah pesanan masih baru, sedang diproses, sedang disiapkan, sudah siap diambil, sudah diambil, atau dibatalkan. |
| AB-08 | Apabila pelanggan menambahkan barang setelah pesanan dibuat, tambahan tersebut harus dicatat sebagai bagian dari perubahan pesanan dan tidak cukup hanya mengandalkan percakapan WhatsApp. |
| AB-09 | Apabila pelanggan membatalkan sebagian barang dari pesanan, pembatalan tersebut dicatat pada barang yang dibatalkan dan riwayat pesanan tetap dipertahankan. |
| AB-10 | Harga barang yang digunakan pada transaksi penjualan harus dicatat sesuai harga yang berlaku ketika transaksi dilakukan, sehingga perubahan harga barang di kemudian hari tidak mengubah harga pada transaksi lama. |
| AB-11 | Setiap pemesanan barang kepada pemasok harus mencatat pemasok, barang yang dipesan, jumlah yang dipesan, dan tanggal pemesanan sehingga dapat dibandingkan dengan barang yang datang. |
| AB-12 | Ketika barang dari pemasok datang, jumlah barang yang diterima harus dicatat terpisah dari jumlah yang dipesan. Selisih antara keduanya harus dapat diketahui dan dicatat untuk ditindaklanjuti. |
| AB-13 | Pemeriksaan barang yang datang dari pemasok harus mencatat siapa yang melakukan pemeriksaan agar ketika terjadi selisih, toko dapat mengetahui pihak yang melakukan pengecekan pada saat penerimaan. |
| AB-14 | Setiap tagihan pemasok harus dicatat bersama nomor tagihan atau faktur, tanggal tagihan, jumlah tagihan, dan tanggal jatuh tempo agar tagihan yang belum diselesaikan tidak mudah terlupakan. |
| AB-15 | Setelah tagihan pemasok dibayar, data pembayaran harus dicatat sehingga status tagihan dan riwayat pembayarannya dapat diketahui kembali. |
| AB-16 | Informasi hadiah atau program promosi dari produk tertentu dapat dicatat secara internal oleh toko untuk membantu mengecek program dan status klaim pelanggan. Pencatatan internal tidak menggantikan aplikasi atau sistem milik produsen. |
| AB-17 | Data pesanan, transaksi penjualan, penerimaan barang, dan tagihan harus tetap menyimpan riwayatnya dan tidak boleh dihapus hanya karena terjadi perubahan atau pembatalan pada proses berjalan. |

## 6. Kebutuhan informasi

Kebutuhan informasi disusun dari hal-hal yang perlu diketahui pihak toko dalam
menjalankan kegiatan sehari-hari. Informasi yang dibutuhkan tidak hanya
berkaitan dengan penjualan, tetapi juga pesanan pelanggan, stok barang,
penerimaan dari pemasok, tagihan, dan program hadiah.

| Kode | Kebutuhan informasi | Data yang diperlukan |
|---|---|---|
| KI-01 | Pihak toko perlu mengetahui pesanan pelanggan mana yang masih diproses dan mana yang sudah siap diambil agar pelanggan tidak perlu terus menanyakan status pesanannya melalui WhatsApp. | Pesanan, Detail Pesanan, Pelanggan, Petugas, Barang |
| KI-02 | Pihak toko perlu melihat perubahan dalam sebuah pesanan, terutama jika ada barang yang ditambahkan atau dibatalkan setelah pesanan dibuat. | Pesanan, Detail Pesanan, Barang, Catatan Perubahan |
| KI-03 | Pihak toko perlu mengetahui jumlah penjualan dan barang yang paling sering terjual dalam periode tertentu untuk membantu melihat barang yang banyak diminati. | Penjualan, Detail Penjualan, Barang |
| KI-04 | Pihak toko perlu mengetahui barang yang stoknya sudah menipis atau berada di bawah batas minimum agar pembelian kepada pemasok dapat dilakukan sebelum barang habis. | Barang, Stok Minimum, Pesanan Pembelian |
| KI-05 | Pihak toko perlu membandingkan jumlah barang yang dipesan dari pemasok dengan jumlah yang benar-benar diterima untuk mengetahui barang mana yang kurang atau lebih. | Pesanan Pembelian, Detail Pesanan Pembelian, Penerimaan Barang, Detail Penerimaan, Pemasok |
| KI-06 | Pihak toko perlu mengetahui tagihan pemasok yang belum dibayar, jumlahnya, dan tagihan yang sudah mendekati atau melewati tanggal jatuh tempo. | Tagihan Pemasok, data pemasok, dan data pembayaran tagihan
| KI-07 | Petugas toko perlu dapat menemukan barang dan harga dengan lebih cepat menggunakan nama, kode barang, atau barcode yang tersedia sehingga proses melayani pembeli tidak terlalu lama. | Barang, Kode Barang, Barcode, Harga Jual |
| KI-08 | Pihak toko perlu mengetahui program hadiah yang sedang dicatat dan status klaim hadiah pelanggan agar riwayat klaim dapat ditelusuri kembali. | Program Hadiah, Klaim Hadiah, Pelanggan |

## 7. Matriks CRUD

Matriks CRUD digunakan untuk melihat hubungan antara proses bisnis dengan
entitas data yang digunakan. Huruf C berarti membuat data (Create), R berarti
membaca atau menggunakan data (Read), U berarti mengubah data (Update), dan
D berarti menghapus data (Delete).

Pada Toko Sempurna Hemat, penghapusan data transaksi tidak digunakan untuk
menjaga riwayat pesanan, penjualan, penerimaan barang, dan tagihan. Jika terjadi
perubahan atau pembatalan, data tetap dipertahankan dan statusnya yang
diperbarui.

| Proses Bisnis | Pelanggan | Petugas | Barang | Pesanan | Detail Pesanan | Penjualan | Detail Penjualan | Pemasok | Pesanan Pembelian | Detail Pesanan Pembelian | Penerimaan Barang | Detail Penerimaan | Tagihan Pemasok | Program Hadiah | Klaim Hadiah |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| PB-01 Menambah dan memperbarui data barang | | | C/U | | | | | | | | | | | | |
| PB-02 Memperbarui harga barang | | | R/U | | | | | | | | | | | | |
| PB-03 Melayani pembelian langsung di toko | R | | R | | | C | C | | | | | | | | |
| PB-04 Mencari barang dan harga saat transaksi | | | R | | | | | | | | | | | | |
| PB-05 Menerima pesanan pelanggan melalui WhatsApp atau aplikasi | C/R | | R | C | C | | | | | | | | | | |
| PB-06 Mengecek ketersediaan barang yang dipesan | R | | R | R | R/U | | | | | | | | | | |
| PB-07 Mencatat dan memproses pesanan pelanggan | R | R | R | R/U | R/U | | | | | | | | | | |
| PB-08 Menambah barang ke pesanan yang sudah dibuat | R | | R | U | C | | | | | | | | | | |
| PB-09 Membatalkan sebagian barang dalam pesanan | R | R | R | U | U | | | | | | | | | | |
| PB-10 Menyiapkan dan memeriksa barang pesanan | | R | R | R/U | R/U | | | | | | | | | | |
| PB-11 Mengubah status pesanan | | R | | U | U | | | | | | | | | | |
| PB-12 Menyerahkan pesanan kepada pelanggan | R | R | | R/U | R | | | | | | | | | | |
| PB-13 Mencatat pembayaran pelanggan | R | R | R | R | R | C | C | | | | | | | | |
| PB-14 Memeriksa dan memperbarui stok barang | | R | R/U | | | | | | | | | | | | |
| PB-15 Membuat pesanan barang kepada pemasok | | | R | | | | | R | C | C | | | | | |
| PB-16 Menerima dan memeriksa barang dari pemasok | | R | R/U | | | | | R | R | R | C | C | | | |
| PB-17 Mencatat selisih barang yang dipesan dan yang diterima | | R | R | | | | | | R | R | R/U | U | | | |
| PB-18 Menindaklanjuti kekurangan atau kelebihan barang yang diterima | | R | R | | | | | R/U | R/U | R/U | R/U | U | | | |
| PB-19 Mencatat dan memantau tagihan pemasok | | R | | | | | | R | R | | R | | C/U | | |
| PB-20 Mencatat pembayaran tagihan pemasok | | R | | | | | | R | | | | | R/U | | |
| PB-21 Mencatat informasi hadiah atau program promosi produk | R | R | R | | | | | | | | | | | C/U | R |
| PB-22 Memantau status dan riwayat pesanan pelanggan | R | R | R | R | R | R | R | | | | | | | | |
| PB-23 Membuat laporan kegiatan toko | R | R | R | R | R | R | R | R | R | R | R | R | R | R | R |
| PB-24 Mengelola data petugas | | C/R/U | | | | | | | | | | | | | |
| PB-25 Mengelola data pemasok | | R | | | | | | C/R/U | | | | | | | |
| PB-26 Mencatat klaim hadiah pelanggan | C/R | R | R | | | | | | | | | | | R/U | C/U |

### 7.1 Hasil pemeriksaan matriks CRUD

Setelah matriks CRUD disusun, setiap entitas diperiksa untuk memastikan ada
proses yang membuat datanya. Dari pemeriksaan tersebut, seluruh entitas sudah
memiliki proses Create, baik melalui kegiatan operasional maupun melalui proses
pengelolaan data master.

Entitas Petugas dibuat melalui PB-24 karena data petugas perlu dikelola sebagai
data master. Entitas Pemasok dibuat melalui PB-25 dengan alasan yang sama.
Klaim Hadiah dibuat melalui PB-26 karena proses klaim berbeda dengan proses
mencatat program hadiah.

Tidak ada proses yang menggunakan huruf D untuk menghapus data transaksi.
Keputusan ini dibuat untuk menjaga riwayat pesanan, transaksi penjualan,
penerimaan barang, tagihan, dan klaim hadiah. Perubahan pada data berjalan lebih
banyak dilakukan dengan memperbarui status atau mencatat perubahan, bukan
menghapus data lama.

Matriks ini juga digunakan untuk memeriksa kesesuaian antara proses bisnis dan
entitas kandidat. Jika pada tahap berikutnya ditemukan proses atau data baru,
matriks akan diperbarui kembali agar tetap konsisten dengan kebutuhan sistem.

## 8. Kamus data awal

Kamus data awal dibuat untuk menjelaskan data yang akan dipakai dalam kegiatan
Toko Sempurna Hemat. Isi kamus ini diambil dari proses bisnis, dokumen sumber,
dan kebutuhan informasi yang sudah dibahas sebelumnya. Penanggung jawab
dicantumkan supaya sejak awal jelas siapa yang mengelola dan memperbarui data
tersebut.

| Elemen data | Arti | Contoh | Aturan | Penanggung jawab |
|---|---|---|---|---|
| `id_pelanggan` | Identitas internal pelanggan | PLG-001 | Harus unik | Admin Pesanan |
| `nama_pelanggan` | Nama pelanggan yang melakukan pemesanan | Andi | Diisi saat identitas pelanggan diperlukan | Admin Pesanan |
| `no_whatsapp` | Nomor WhatsApp yang digunakan untuk komunikasi pesanan | 081234567890 | Data pribadi, hanya digunakan untuk kebutuhan pesanan | Admin Pesanan |
| `id_petugas` | Identitas internal petugas toko | PTG-001 | Harus unik | Pengelola Toko |
| `nama_petugas` | Nama petugas yang menjalankan kegiatan toko | Budi | Tidak boleh kosong | Pengelola Toko |
| `peran_petugas` | Peran petugas dalam kegiatan toko | Petugas Toko | Harus sesuai tugas yang diberikan | Pengelola Toko |
| `id_barang` | Identitas internal barang | BRG-001 | Harus unik | Petugas Toko |
| `kode_barang` | Kode yang dipakai untuk mencari dan mengenali barang | KRPK-001 | Harus unik | Petugas Toko |
| `barcode` | Barcode yang tercantum pada produk | 8991234567890 | Boleh kosong jika produk tidak memiliki barcode | Petugas Toko |
| `nama_barang` | Nama barang yang dijual | Chiki Pedas | Tidak boleh kosong | Petugas Toko |
| `kategori_barang` | Kelompok barang yang dijual | Makanan Ringan | Harus sesuai kategori yang digunakan toko | Petugas Toko |
| `harga_jual` | Harga jual barang yang sedang berlaku | 5000 | Tidak boleh negatif | Pengelola Toko |
| `stok` | Jumlah barang yang tersedia | 25 | Tidak boleh negatif | Petugas Toko |
| `stok_minimum` | Batas stok yang menjadi tanda barang perlu dipesan kembali | 5 | Tidak boleh negatif | Pengelola Toko |
| `id_pesanan` | Identitas internal pesanan pelanggan | PSN-001 | Harus unik | Admin Pesanan |
| `no_pesanan` | Nomor yang digunakan untuk membedakan pesanan | ORD-26001 | Harus unik | Admin Pesanan |
| `tanggal_pesanan` | Tanggal dan waktu saat pesanan dibuat | 2026-10-06 10:15 | Harus mencatat waktu pembuatan pesanan | Admin Pesanan |
| `sumber_pesanan` | Media yang digunakan pelanggan untuk membuat pesanan | WhatsApp | Nilai disesuaikan dengan media yang tersedia | Admin Pesanan |
| `status_pesanan` | Kondisi terakhir dari pesanan | Siap Diambil | Mengikuti tahapan proses pesanan | Admin Pesanan |
| `id_detail_pesanan` | Identitas baris barang dalam suatu pesanan | DTL-001 | Harus unik | Admin Pesanan |
| `qty_pesanan` | Jumlah barang yang dipesan pelanggan | 3 | Harus lebih dari 0 | Admin Pesanan |
| `harga_satuan_pesanan` | Harga satuan barang pada saat dimasukkan ke pesanan | 4500 | Dicatat agar riwayat harga pesanan tetap dapat dilihat | Admin Pesanan |
| `status_barang_pesanan` | Kondisi barang tertentu dalam pesanan | Disiapkan | Digunakan untuk melihat perubahan atau pembatalan item | Admin Pesanan |
| `catatan_perubahan` | Catatan mengenai perubahan isi pesanan | Tambah 2 susu | Diisi jika terjadi perubahan | Admin Pesanan |
| `waktu_siap_diambil` | Waktu ketika pesanan dinyatakan siap | 2026-10-06 12:30 | Diisi setelah pesanan selesai disiapkan | Petugas Toko |
| `waktu_diambil` | Waktu ketika pelanggan mengambil pesanan | 2026-10-06 13:10 | Diisi setelah pesanan benar-benar diambil | Petugas Toko |
| `id_penjualan` | Identitas internal transaksi penjualan | PJL-001 | Harus unik | Petugas Toko |
| `no_nota` | Nomor nota transaksi penjualan | NT-26001 | Harus unik | Petugas Toko |
| `tanggal_penjualan` | Tanggal dan waktu transaksi dilakukan | 2026-10-06 13:15 | Harus mencatat waktu transaksi | Petugas Toko |
| `metode_pembayaran` | Cara pelanggan membayar transaksi | Tunai | Diisi sesuai pembayaran yang dilakukan | Petugas Toko |
| `qty_penjualan` | Jumlah barang yang terjual | 2 | Harus lebih dari 0 | Petugas Toko |
| `harga_satuan_penjualan` | Harga satuan yang dipakai pada saat barang terjual | 5000 | Menyimpan harga saat transaksi terjadi | Petugas Toko |
| `id_pemasok` | Identitas internal pemasok | SUP-001 | Harus unik | Pengelola Toko |
| `nama_pemasok` | Nama pihak yang memasok barang | Indogrosir | Tidak boleh kosong | Pengelola Toko |
| `no_telepon_pemasok` | Nomor telepon pemasok | 081298765432 | Diisi sesuai informasi pemasok | Pengelola Toko |
| `alamat_pemasok` | Alamat pemasok atau perusahaan pemasok | Bandar Lampung | Diisi sesuai informasi yang tersedia | Pengelola Toko |
| `id_pesanan_pembelian` | Identitas internal pemesanan barang kepada pemasok | PPB-001 | Harus unik | Pengelola Toko |
| `no_pesanan_pembelian` | Nomor untuk membedakan pemesanan kepada pemasok | PO-26001 | Harus unik | Pengelola Toko |
| `tanggal_pemesanan` | Tanggal pemesanan barang kepada pemasok | 2026-10-05 | Harus dicatat saat pemesanan dibuat | Pengelola Toko |
| `status_pesanan_pembelian` | Kondisi pemesanan barang kepada pemasok | Dipesan | Mengikuti proses pemesanan sampai diterima | Pengelola Toko |
| `qty_pesan_pembelian` | Jumlah barang yang dipesan kepada pemasok | 4 | Harus lebih dari 0 | Pengelola Toko |
| `harga_beli` | Harga pembelian barang dari pemasok | 35000 | Tidak boleh negatif | Pengelola Toko |
| `id_penerimaan` | Identitas internal penerimaan barang | TER-001 | Harus unik | Petugas Toko |
| `no_penerimaan` | Nomor penerimaan barang | TRM-26001 | Harus unik | Petugas Toko |
| `tanggal_penerimaan` | Tanggal dan waktu barang diterima | 2026-10-06 09:00 | Dicatat saat barang datang | Petugas Toko |
| `no_dokumen_penerimaan` | Nomor faktur atau dokumen dari pemasok | INV-45821 | Dicatat sesuai dokumen pemasok | Pengelola Toko |
| `status_penerimaan` | Kondisi penerimaan barang | Sebagian Diterima | Menunjukkan apakah penerimaan lengkap atau terdapat selisih | Petugas Toko |
| `qty_terima` | Jumlah barang yang benar-benar diterima | 3 | Tidak boleh negatif | Petugas Toko |
| `selisih_penerimaan` | Perbedaan antara jumlah yang dipesan dan jumlah yang diterima | 1 | Dihitung dari jumlah pesan dikurangi jumlah terima | Petugas Toko |
| `diperiksa_oleh` | Petugas yang memeriksa barang yang datang | PTG-002 | Harus mengacu pada petugas yang melakukan pemeriksaan | Petugas Toko |
| `catatan_selisih` | Penjelasan mengenai barang yang kurang atau lebih | Kurang 1 kardus | Diisi jika terjadi selisih | Pengelola Toko |
| `id_tagihan` | Identitas internal tagihan pemasok | TAG-001 | Harus unik | Pengelola Toko |
| `no_tagihan` | Nomor yang digunakan untuk membedakan tagihan | TAG-26001 | Harus unik | Pengelola Toko |
| `no_faktur` | Nomor faktur dari pemasok | INV-45821 | Dicatat sesuai dokumen pemasok | Pengelola Toko |
| `tanggal_tagihan` | Tanggal tagihan diterbitkan | 2026-10-06 | Dicatat sesuai tagihan | Pengelola Toko |
| `jatuh_tempo` | Tanggal terakhir pembayaran tagihan | 2026-10-13 | Tidak boleh lebih awal dari tanggal tagihan | Pengelola Toko |
| `jumlah_tagihan` | Nilai tagihan yang harus dibayar | 850000 | Tidak boleh negatif | Pengelola Toko |
| `status_pembayaran` | Kondisi pembayaran tagihan | Belum Dibayar | Harus sesuai kondisi pembayaran terakhir | Pengelola Toko |
| `id_pembayaran_tagihan` | Identitas pembayaran tagihan | BYR-001 | Harus unik | Pengelola Toko |
| `tanggal_pembayaran` | Tanggal saat tagihan dibayar | 2026-10-10 | Diisi setelah pembayaran dilakukan | Pengelola Toko |
| `jumlah_pembayaran` | Jumlah uang yang dibayarkan untuk tagihan | 850000 | Tidak boleh negatif | Pengelola Toko |
| `id_program` | Identitas internal program hadiah | PRG-001 | Harus unik | Pengelola Toko |
| `nama_program` | Nama program hadiah atau promosi produk | Hadiah Chiki | Tidak boleh kosong | Pengelola Toko |
| `keterangan_program` | Penjelasan mengenai program hadiah | Beli produk tertentu mendapat hadiah | Diisi sesuai informasi program | Pengelola Toko |
| `periode_program` | Waktu berlakunya program hadiah | Oktober 2026 | Harus menunjukkan periode yang berlaku | Pengelola Toko |
| `id_klaim` | Identitas internal klaim hadiah | KLM-001 | Harus unik | Petugas Toko |
| `tanggal_klaim` | Tanggal pelanggan mengajukan atau menyelesaikan klaim | 2026-10-06 | Dicatat saat klaim dilakukan | Petugas Toko |
| `status_klaim` | Kondisi terakhir klaim hadiah | Diproses | Harus mengikuti status klaim | Petugas Toko |

## 9. Kebutuhan non-fungsional data

Bagian ini menjelaskan kebutuhan sistem yang berkaitan dengan jumlah data,
lama penyimpanan, dan pembatasan akses. Selain itu, digunakan parameter P dari
NIM untuk membuat perkiraan awal terhadap jumlah data yang akan ditangani
sistem.

### 9.1 Perhitungan parameter P

Dua digit terakhir NIM adalah 43.

P = (43 mod 9) + 1
P = 7 + 1
P = 8

Dari hasil tersebut diperoleh:
- Maksimal item dalam satu transaksi = P + 2 = 10 item
- Nilai P = 8
- Perkiraan volume transaksi per hari = 40 + (5 × P) = 80 transaksi per hari

Nilai P digunakan sebagai parameter proyek. Nilai tersebut tidak langsung
ditetapkan sebagai kebijakan diskon toko karena kebijakan harga dan potongan
dapat berubah sesuai keputusan pengelola toko.

### 9.2 Kebutuhan non-fungsional data

| Aspek | Kebutuhan |
|---|---|
| Volume data | Sistem dirancang untuk menangani perkiraan sampai 80 transaksi per hari. Data harus tetap dapat disimpan dan dicari ketika jumlah transaksi terus bertambah. |
| Jumlah item transaksi | Satu transaksi dapat mencatat sampai 10 jenis item berdasarkan perhitungan parameter P. |
| Retensi data | Data pesanan, penjualan, penerimaan barang, dan tagihan direncanakan disimpan minimal 5 tahun agar riwayat kegiatan toko masih dapat dilihat kembali ketika diperlukan. |
| Data pribadi | Nama pelanggan dan nomor WhatsApp merupakan data pribadi dan hanya digunakan untuk keperluan pesanan serta komunikasi dengan pelanggan. |
| Akses pelanggan | Pelanggan hanya dapat melihat informasi yang berhubungan dengan pesanannya sendiri dan tidak dapat melihat data pelanggan lain. |
| Akses Admin Pesanan | Admin Pesanan dapat melihat dan memperbarui data pelanggan serta pesanan yang sedang ditangani, termasuk nomor WhatsApp untuk komunikasi pesanan. |
| Akses Petugas Toko | Petugas Toko dapat melihat data barang, stok, pesanan yang perlu disiapkan, transaksi penjualan, dan penerimaan barang sesuai tugasnya. |
| Akses Pengelola Toko | Pengelola Toko dapat mengelola data master, pemasok, pesanan pembelian, tagihan, dan laporan kegiatan toko. |
| Riwayat data | Perubahan atau pembatalan pada pesanan, transaksi, penerimaan barang, dan tagihan tidak boleh menghilangkan riwayat yang masih diperlukan. |

## 10. Isu kualitas data yang diantisipasi

Berdasarkan kegiatan yang dilakukan di Toko Sempurna Hemat, ada beberapa
masalah data yang mungkin muncul ketika pencatatan mulai dilakukan secara
teratur. Masalah tersebut terutama berkaitan dengan data barang, stok, pesanan
pelanggan, penerimaan barang dari pemasok, dan tagihan. Karena itu, sejak awal
perlu ditentukan cara pencatatan yang dapat mengurangi kesalahan dan membuat
data lebih mudah dicek kembali.

| Dimensi | Isu yang mungkin terjadi | Dampak | Antisipasi |
|---|---|---|---|
| Kelengkapan | Tidak semua barang mempunyai barcode dan beberapa data barang bisa saja belum lengkap ketika pertama kali dimasukkan. | Barang sulit dicari atau informasi barang menjadi kurang jelas saat transaksi. | Barcode tidak diwajibkan. Barang tetap harus mempunyai kode internal, nama, kategori, harga jual, dan informasi stok yang diperlukan. |
| Keunikan | Barang yang sama dapat tercatat dua kali dengan kode atau nama yang berbeda. | Stok dan riwayat penjualan barang yang sama bisa terbagi ke beberapa data. | Kode barang dibuat unik dan data barang yang sudah ada diperiksa sebelum menambahkan data baru. |
| Validitas | Qty, harga, stok, atau jumlah tagihan dapat diisi dengan nilai yang tidak masuk akal, misalnya jumlah negatif. | Hasil transaksi dan laporan menjadi salah. | Data angka diberi batas yang jelas, misalnya qty dan stok tidak boleh negatif dan jumlah barang harus sesuai kondisi sebenarnya. |
| Validitas | Tanggal pesanan, penerimaan barang, tagihan, atau pembayaran dapat salah format atau tidak sesuai urutan waktunya. | Riwayat kegiatan toko menjadi sulit ditelusuri dan laporan berdasarkan tanggal dapat keliru. | Tanggal dicatat dengan format yang sama dan hubungan waktunya diperiksa sebelum data disimpan. |
| Akurasi | Stok yang tercatat dapat berbeda dengan jumlah barang yang benar-benar ada di toko. | Sistem dapat menunjukkan stok tersedia padahal barang sudah habis atau sebaliknya. | Perubahan stok dicatat berdasarkan penjualan, penerimaan barang, barang rusak, dan pemeriksaan stok sehingga jumlah dalam sistem dapat dibandingkan dengan kondisi fisik. |
| Konsistensi | Nama barang atau kategori dapat ditulis berbeda oleh orang yang berbeda. | Pencarian barang dan laporan menjadi kurang rapi atau menghasilkan pemisahan data yang seharusnya sama. | Nama dan kategori barang menggunakan penulisan yang disepakati dan diperiksa sebelum disimpan. |
| Akurasi | Jumlah barang yang dipesan kepada pemasok dapat berbeda dengan jumlah barang yang datang. | Kekurangan barang dapat terlewat dan menimbulkan kerugian bagi toko. | Jumlah yang dipesan dan jumlah yang diterima dicatat secara terpisah sehingga selisih dapat dilihat kembali. |
| Kelengkapan | Perubahan pesanan pelanggan, seperti penambahan atau pembatalan sebagian barang, dapat hanya tersimpan di percakapan WhatsApp. | Barang yang disiapkan toko dapat berbeda dengan permintaan terakhir pelanggan. | Setiap perubahan pesanan dicatat pada detail pesanan dan diberi catatan atau status yang sesuai. |
| Kelengkapan | Data tagihan pemasok dapat tidak mencantumkan tanggal jatuh tempo atau status pembayaran dengan lengkap. | Tagihan dapat terlupakan atau sulit diketahui mana yang masih harus dibayar. | Setiap tagihan dicatat bersama nomor faktur, tanggal tagihan, jumlah, jatuh tempo, dan status pembayaran. |
| Ketertelusuran | Data transaksi atau perubahan data dapat diubah tanpa meninggalkan informasi yang cukup tentang perubahan tersebut. | Sulit mengetahui penyebab perbedaan data ketika dilakukan pemeriksaan ulang. | Riwayat pesanan, transaksi, penerimaan barang, dan tagihan dipertahankan sehingga perubahan penting masih dapat ditelusuri. |
