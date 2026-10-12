-- Create database --
CREATE DATABASE db_perpustakaan;
use db_perpustakaan;

-- Create table --
CREATE TABLE pengguna (
    id_pengguna INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE,
    peran ENUM('anggota','pustakawan','admin') NOT NULL DEFAULT 'anggota',
    password VARCHAR(255) NOT NULL,
    foto VARCHAR(255) NULL,
    status ENUM('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
    dibuat_pada DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE kategori (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(75) NOT NULL UNIQUE);

CREATE TABLE buku (
    id_buku INT AUTO_INCREMENT PRIMARY KEY,
    file_buku VARCHAR(255) NOT NULL UNIQUE,
    judul VARCHAR(200) NOT NULL,
    penulis VARCHAR(100) NOT NULL,
    penerbit VARCHAR(100) NOT NULL,
    tahun_terbit YEAR NULL,
    sampul VARCHAR(255) NULL,
    deskripsi TEXT NOT NULL,
    rating DECIMAL(2,1) NOT NULL DEFAULT 0.0,
    stok_buku INT NOT NULL DEFAULT 1 CHECK (stok_buku >= 0),
    dibuat_pada DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_kategori INT NOT NULL,
    FOREIGN KEY (id_kategori) REFERENCES kategori (id_kategori),
    index idx_judul (judul),
    index idx_penulis (penulis));
    
CREATE TABLE peminjaman (
    id_peminjaman INT AUTO_INCREMENT PRIMARY KEY,
    tgl_peminjaman DATE NOT NULL DEFAULT CURRENT_DATE,
    tgl_pengembalian DATE NULL,
    tgl_jatuh_tempo DATE NOT NULL,
    status ENUM('dipinjam','dikembalikan','terlambat') NOT NULL DEFAULT 'dipinjam',
    denda INT NOT NULL DEFAULT 0,
    id_pengguna INT NOT NULL,
    id_buku INT NOT NULL,
    FOREIGN KEY (id_pengguna) REFERENCES pengguna (id_pengguna) ON DELETE CASCADE,
    FOREIGN KEY (id_buku) REFERENCES buku (id_buku),
    INDEX idx_status (status));
    
CREATE TABLE favorite (
    id_pengguna INT NOT NULL,
    id_buku INT NOT NULL,
    dibuat_pada DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_pengguna, id_buku),
    FOREIGN KEY (id_pengguna) REFERENCES pengguna (id_pengguna) ON DELETE CASCADE,
    FOREIGN KEY (id_buku) REFERENCES buku (id_buku) ON DELETE CASCADE);

CREATE TABLE notifikasi(
    id_notifikasi INT AUTO_INCREMENT PRIMARY KEY,
    jenis ENUM('jatuh_tempo','buku_baru','peminjaman') NOT NULL,
    pesan VARCHAR(255) NOT NULL,
    sudah_dibaca BOOLEAN NOT NULL DEFAULT FALSE,
    dibuat_pada DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_pengguna INT NOT NULL,
    FOREIGN KEY (id_pengguna) REFERENCES pengguna (id_pengguna) ON DELETE CASCADE);