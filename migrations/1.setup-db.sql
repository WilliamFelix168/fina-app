-- =============================================================
-- FILE: 01_setup.sql
-- DESC: Setup pgvector extension + tabel utama transaksi + RLS
-- =============================================================


-- -------------------------------------------------------------
-- 1. EXTENSION
-- Aktifkan pgvector agar PostgreSQL bisa menyimpan tipe VECTOR.
-- Cukup dijalankan sekali per database.
-- -------------------------------------------------------------
CREATE EXTENSION IF NOT EXISTS vector;


-- -------------------------------------------------------------
-- 2. TABLE: transactions
-- Tabel utama yang menyimpan semua data transaksi keuangan.
--
-- Kolom penting:
--   id          : Primary key, auto-generate UUID
--   type        : Hanya boleh 'income' atau 'expense' (CHECK constraint)
--   category    : Kategori bebas, misal 'food', 'salary', 'transport'
--   amount      : Nominal transaksi
--   description : Keterangan transaksi (teks bebas)
--   date        : Tanggal transaksi, default hari ini
--   user_id     : Foreign key ke tabel auth.users (Supabase Auth)
--   embedding   : Vector 768 dimensi untuk fitur semantic search
--   created_at  : Timestamp otomatis saat data diinsert
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.transactions (
    id          UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
    type        TEXT        NOT NULL CHECK (type IN ('income', 'expense')),
    category    TEXT        NOT NULL,
    amount      NUMERIC     NOT NULL,
    description TEXT,
    date        DATE        NOT NULL DEFAULT CURRENT_DATE,
    user_id     UUID        REFERENCES auth.users(id) ON DELETE CASCADE,
    embedding   VECTOR(768),
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);


-- -------------------------------------------------------------
-- 3. ROW LEVEL SECURITY (RLS)
-- RLS mengontrol akses data di level baris (per-row).
-- Wajib diaktifkan sebelum membuat policy.
-- -------------------------------------------------------------
ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;


-- -------------------------------------------------------------
-- 4. POLICY (Development mode — semua user bisa akses semua data)
-- PERINGATAN: Policy ini hanya untuk development/testing.
-- Sebelum deploy ke production, ganti dengan policy di bawah!
-- -------------------------------------------------------------
CREATE POLICY "Permissive rules for all" ON public.transactions
    FOR ALL USING (true);


-- -------------------------------------------------------------
-- 4b. POLICY (Production mode — uncomment kalau auth sudah aktif)
-- Setiap user hanya bisa akses transaksi milik mereka sendiri.
-- -------------------------------------------------------------
-- CREATE POLICY "Users can manage their own transactions" ON public.transactions
--     FOR ALL USING (auth.uid() = user_id);