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

CREATE TABLE buku(
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