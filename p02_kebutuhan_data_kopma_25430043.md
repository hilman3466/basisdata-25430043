# Dokumen Kebutuhan Data - Koperasi Mahasiswa Sejahtera

## 1. Latar belakang dan aktivitas organisasi

Koperasi Mahasiswa Sejahtera (Kopma) merupakan koperasi yang menjual alat
tulis, makanan ringan, dan minuman di lingkungan kampus. Pembeli dapat berasal
dari anggota maupun pembeli umum.

Dalam kegiatan sehari-hari, mahasiswa yang ingin menjadi anggota melakukan
pendaftaran dengan mengisi NIM, nama, program studi, dan nomor HP. Setelah
terdaftar, anggota memperoleh nomor anggota. Anggota yang masih aktif 
mendapatkan potongan 5% pada setiap nota.

Penjualan dilakukan oleh kasir. Di sisi lain, petugas gudang memeriksa stok
setiap sore. Jika stok suatu barang sudah berada di bawah batas minimum, petugas
gudang membuat pesanan pembelian kepada pemasok. Ketika barang datang, jumlah
stok diperbarui sesuai barang yang diterima.

Pada awal bulan, ketua koperasi membutuhkan laporan mengenai omzet, barang yang
paling banyak terjual, barang yang stoknya menipis, dan anggota dengan aktivitas
belanja tertinggi.

## 2. Aktor dan proses bisnis

Aktor yang terlibat dalam kegiatan Kopma adalah mahasiswa atau anggota,
kasir, petugas gudang, ketua koperasi, dan pemasok.

| Kode | Proses bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Mendaftarkan anggota | Kasir | Mahasiswa ingin menjadi anggota |
| PB-02 | Mencatat penjualan | Kasir | Pembeli melakukan pembayaran |
| PB-03 | Memesan barang ke pemasok | Petugas Gudang | Stok berada di bawah batas minimum |
| PB-04 | Menerima barang dari pemasok | Petugas Gudang | Barang datang bersama faktur |
| PB-05 | Menyusun laporan bulanan | Ketua Koperasi | Awal bulan |
| PB-06 | Mengelola Data Pemasok | Ketua Koperasi | Ada pemasok baru atau informasi pemasok perlu diperbarui |
| PB-07 | Mencatat poin loyalitas anggota | Kasir | Anggota melakukan pembelian atau menukarkan poin |

## 3. Dokumen sumber yang dianalisis

Dokumen sumber yang dianalisis adalah nota penjualan Kopma. Selain nota,
informasi tentang kegiatan anggota, petugas, dan pemasok juga digunakan untuk
menentukan data yang perlu dicatat.

Pada nota penjualan terdapat informasi seperti nomor nota, tanggal dan waktu,
kasir, anggota jika pembeli merupakan anggota, barang yang dibeli, jumlah
barang, harga saat transaksi, serta jumlah pembayaran.

Data seperti subtotal dan total merupakan nilai yang dapat dihitung dari jumlah
barang, harga, dan potongan yang berlaku sehingga perlu dipertimbangkan kembali
apakah harus disimpan atau cukup dihitung.

## 4. Entitas kandidat dan elemen data

Berdasarkan aktivitas dan dokumen sumber, diperoleh beberapa entitas kandidat.

| Entitas kandidat | Elemen data utama | Sumber |
|---|---|---|
| Anggota | nomor anggota, NIM, nama, program studi, nomor HP, status aktif | Formulir pendaftaran |
| Barang | kode, nama, kategori, harga jual, stok, batas minimum stok | Daftar barang dan faktur |
| Penjualan | nomor nota, tanggal-waktu, kasir, anggota jika ada, pembayaran | Nota penjualan |
| Detail Penjualan | nomor nota, barang, qty, harga saat transaksi | Nota penjualan |
| Petugas | kode petugas, nama, peran | Wawancara |
| Pemasok | kode, nama, telepon, alamat | Faktur pemasok |
| Pembelian | nomor faktur, tanggal, pemasok, barang, jumlah, harga beli | Faktur pemasok |
| Riwayat Poin | id_riwayat_poin, no_anggota, tanggal, jenis transaksi, jumlah poin, keterangan | Catatan transaksi penjualan dan penukaran poin |

## 5. Aturan bisnis

| Kode | Aturan bisnis |
|---|---|
| AB-01 | Setiap nota mempunyai nomor yang unik dan minimal memiliki satu baris barang. |
| AB-02 | Penjualan dapat dilakukan oleh pembeli umum. Jika pembeli merupakan anggota, diskon 5% hanya diberikan kepada anggota yang berstatus aktif. |
| AB-03 | Stok barang tidak boleh bernilai negatif. Penjualan ditolak apabila jumlah yang diminta melebihi stok yang tersedia. |
| AB-04 | Harga yang digunakan pada nota disimpan pada setiap baris detail transaksi dan tidak berubah ketika harga barang pada master kemudian berubah. |
| AB-05 | NIM anggota harus unik. Anggota dapat dicari menggunakan nomor anggota atau NIM. |
| AB-06 | Pesanan pembelian dibuat ketika stok barang berada di bawah batas minimum. |
| AB-07 | Setiap kelipatan Rp10.000 dari belanja anggota menghasilkan 1 poin loyalitas. |
| AB-08 | Sebanyak 50 poin loyalitas dapat ditukar dengan potongan sebesar Rp5.000 pada transaksi. |

## 6. Kebutuhan informasi

| Kode | Kebutuhan informasi | Data yang diperlukan |
|---|---|---|
| KI-01 | Mengetahui omzet dan jumlah nota per hari maupun per bulan | Penjualan dan Detail Penjualan |
| KI-02 | Mengetahui lima barang terlaris setiap bulan berdasarkan jumlah terjual | Detail Penjualan dan Barang |
| KI-03 | Mengetahui barang yang stoknya sudah berada di bawah batas minimum | Barang |
| KI-04 | Mengetahui sepuluh anggota dengan jumlah belanja terbesar setiap bulan | Penjualan, Detail Penjualan, dan Anggota |
| KI-05 | Mengetahui jumlah poin loyalitas yang dimiliki anggota dan riwayat perolehan atau penggunaannya | Anggota, Penjualan, Riwayat Poin |

## 7. Matriks CRUD

Matriks CRUD digunakan untuk melihat data yang dibuat, dibaca, diubah, atau
dihapus oleh setiap proses bisnis.

| Proses | Anggota | Barang | Penjualan | Detail Penjualan | Pemasok | Pembelian | Riwayat Poin |
|---|---|---|---|---|---|---|---|
| PB-01 Mendaftarkan anggota | C | | | | | | |
| PB-02 Mencatat penjualan | R | R/U | C | C | | | |
| PB-03 Memesan barang ke pemasok | | R | | | R | C | |
| PB-04 Menerima barang dari pemasok | | U | | | R | U | |
| PB-05 Menyusun laporan bulanan | R | R | R | R | | R | |
| PB-06 Mengelola Data Pemasok | | | | | C/U | | |
| PB-07 Mencatat poin loyalitas anggota | R | | R | R | | | C |

### Hasil pemeriksaan CRUD

Pada matriks di atas, entitas Pemasok belum memiliki proses `C`. Artinya ada
data pemasok yang digunakan, tetapi belum ada proses yang menjelaskan bagaimana
data tersebut pertama kali dibuat.

Karena itu perlu ditambahkan proses **PB-06 Mengelola Data Pemasok**. Proses
ini digunakan untuk membuat dan memperbarui data pemasok.

Perubahan status aktif anggota juga harus mempunyai proses yang jelas. Jika
status anggota dapat berubah tetapi tidak ada proses `U`, maka proses perubahan
status tersebut perlu ditambahkan ke daftar proses bisnis.

## 8. Kamus data awal

Kamus data ini digunakan untuk menjelaskan arti setiap elemen data, contoh
nilainya, aturan pengisian, dan siapa yang bertanggung jawab mengelolanya.

| Elemen | Arti | Contoh | Aturan | Penanggung jawab |
|---|---|---|---|---|
| no_anggota | Nomor yang digunakan untuk mengenali anggota koperasi | A-0457 | Harus unik dan mengikuti format nomor anggota | Ketua |
| nim_anggota | Nomor induk mahasiswa yang dimiliki anggota | 2301010123 | Harus unik | Ketua |
| nama_anggota | Nama anggota koperasi | Budi Santoso | Wajib diisi | Ketua |
| prodi_anggota | Program studi yang diikuti anggota | Ilmu Komputer | Wajib diisi | Ketua |
| no_hp_anggota | Nomor HP milik anggota | 0812xxxx | Termasuk data pribadi dan aksesnya dibatasi | Ketua |
| status_anggota | Menunjukkan apakah anggota masih aktif atau tidak | aktif | Diisi sesuai kondisi keanggotaan | Ketua |
| kode_barang | Kode untuk membedakan satu barang dengan barang lainnya | ATK-001 | Tidak boleh sama dengan barang lain | Petugas Gudang |
| nama_barang | Nama barang yang dijual oleh koperasi | Pulpen | Wajib diisi | Petugas Gudang |
| kategori_barang | Kelompok atau jenis barang | ATK | Mengikuti kategori yang tersedia | Petugas Gudang |
| harga_jual_barang | Harga jual barang yang sedang berlaku | 4000 | Nilai rupiah dan tidak boleh negatif | Petugas Gudang |
| stok_barang | Jumlah barang yang masih tersedia | 35 | Tidak boleh bernilai negatif | Petugas Gudang |
| stok_min_barang | Batas minimum jumlah stok barang | 10 | Bilangan bulat dan tidak boleh negatif | Petugas Gudang |
| no_nota_penjualan | Nomor yang digunakan untuk membedakan setiap nota penjualan | PJ-2609-0142 | Harus unik | Kasir |
| tgl_penjualan | Tanggal dan waktu saat transaksi penjualan terjadi | 2026-09-24 10:15:00 | Menggunakan format tanggal dan waktu yang valid | Kasir |
| harga_satuan_detail_penjualan | Harga barang yang benar-benar dipakai saat transaksi | 4000 | Nilai rupiah dan tidak boleh negatif | Kasir |
| qty_detail_penjualan | Jumlah barang yang dibeli pada satu rincian transaksi | 3 | Bilangan bulat dan tidak boleh negatif | Kasir |
| kode_petugas | Kode untuk mengenali petugas yang terlibat dalam kegiatan koperasi | KSR-01 | Harus unik | Ketua |
| nama_petugas | Nama petugas koperasi | Andi | Wajib diisi | Ketua |
| peran_petugas | Peran yang dijalankan oleh petugas | Kasir | Mengikuti peran yang tersedia | Ketua |
| kode_pemasok | Kode untuk membedakan setiap pemasok | SUP-01 | Harus unik | Ketua |
| nama_pemasok | Nama pemasok barang | CV Sumber Jaya | Wajib diisi | Ketua |
| telepon_pemasok | Nomor telepon pemasok | 0813xxxx | Menggunakan format nomor telepon yang valid | Ketua |
| alamat_pemasok | Alamat pemasok barang | Jl. Merdeka No. 10 | Diisi sesuai informasi pemasok | Ketua |
| no_faktur_pembelian | Nomor faktur dari pembelian barang | FK-2609-001 | Harus unik | Petugas Gudang |
| tgl_pembelian | Tanggal terjadinya pembelian barang | 2026-09-24 | Menggunakan format tanggal yang valid | Petugas Gudang |
| id_riwayat_poin | Identitas untuk setiap catatan perubahan poin anggota | RP-001 | Harus unik | Kasir |
| no_anggota_poin | Nomor anggota yang memiliki riwayat poin tersebut | A-0457 | Harus sesuai dengan data anggota | Kasir |
| tanggal_poin | Tanggal saat poin diperoleh atau digunakan | 2026-10-06 | Menggunakan format tanggal yang valid | Kasir |
| jenis_transaksi_poin | Menunjukkan apakah poin diperoleh atau digunakan | Perolehan | Nilainya harus sesuai dengan jenis transaksi | Kasir |
| jumlah_poin | Jumlah poin yang bertambah atau digunakan | 5 | Bilangan bulat dan tidak boleh negatif | Kasir |
| keterangan_poin | Catatan tambahan tentang perubahan poin | Poin dari pembelian | Diisi jika ada keterangan yang perlu dicatat | Kasir |

## 9. Kebutuhan non-fungsional data

Perkiraan volume data yang digunakan dalam kasus Kopma adalah sekitar 150 nota
per hari. Data transaksi perlu disimpan minimal selama lima tahun agar masih
dapat digunakan untuk pemeriksaan dan laporan.

Data pribadi seperti nomor HP anggota tidak boleh dilihat oleh semua pengguna.
Akses terhadap data tersebut dibatasi sesuai peran, dan dalam kasus ini ketua
koperasi menjadi pihak yang bertanggung jawab atas data anggota.

Data transaksi juga perlu mempertahankan nilai historisnya. Perubahan harga
barang di kemudian hari tidak boleh mengubah harga yang sudah tercatat pada
transaksi lama.

## 10. Isu kualitas data yang diantisipasi

Beberapa masalah kualitas data yang perlu diperhatikan adalah data anggota
yang tidak lengkap, data barang yang tercatat lebih dari satu kali, stok yang
tidak sesuai dengan kondisi sebenarnya, dan kesalahan pencatatan harga
transaksi.

Data stok juga perlu diperiksa agar tidak menghasilkan jumlah negatif.
Keunikan NIM anggota, nomor anggota, kode barang, dan nomor nota perlu dijaga
agar tidak terjadi data ganda.

Selain itu, data yang berkaitan dengan transaksi lama harus tetap dapat
ditelusuri meskipun terjadi perubahan harga barang atau perubahan status
anggota.

