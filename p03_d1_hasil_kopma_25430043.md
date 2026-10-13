# Hasil D.1 — Entitas Kandidat Kopma

## 1. Penandaan Kunci dan Atribut Turunan

Setelah melihat data yang dibutuhkan Kopma, setiap entitas perlu memiliki kunci supaya datanya mudah dibedakan. Contohnya, `id_anggota` dipakai sebagai kunci utama anggota, sedangkan nomor anggota dan NIM menjadi kunci alternatif karena nilainya unik. Nomor nota penjualan juga harus berbeda untuk setiap transaksi.

Beberapa entitas yang digunakan antara lain anggota, barang, penjualan, detail penjualan, petugas, pemasok, dan pembelian. Pada `detail_penjualan`, `id_penjualan` dan `id_barang` digunakan sebagai kunci gabungan. Jumlah barang dan harga saat transaksi juga dicatat agar rincian penjualan bisa diketahui dengan jelas.

Nilai seperti subtotal dan total penjualan tidak harus dicatat sebagai data terpisah karena bisa dihitung dari jumlah barang dan harga satuan.

## 2. Pemisahan Entitas Pembelian

Awalnya, data pembelian dan rincian barang masih digabung dalam satu entitas. Supaya lebih mudah dikelola, data tersebut dipisahkan menjadi `pembelian` dan `detail_pembelian`.

Entitas `pembelian` menyimpan informasi umum, seperti nomor faktur, tanggal pembelian, dan pemasok. Sementara itu, `detail_pembelian` mencatat barang yang dibeli beserta jumlah dan harga belinya. Dengan pemisahan ini, satu pembelian bisa berisi beberapa jenis barang tanpa mencampur data transaksi dengan rincian barang.

Pada `detail_pembelian`, `id_pembelian` dan `id_barang` digunakan sebagai kunci gabungan sekaligus penghubung ke entitas pembelian dan barang.

**Keterangan:** PK adalah kunci primer, FK adalah kunci tamu, dan AK adalah kunci alternatif yang nilainya unik.

