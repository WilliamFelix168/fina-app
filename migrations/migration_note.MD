# fina-app — Database (Supabase + pgvector)

Folder ini berisi SQL migration files untuk setup database fina-app di Supabase.
fina-app menggunakan **pgvector** untuk fitur semantic search — user bisa cari transaksi
berdasarkan makna kalimat, bukan hanya keyword.

---

## Struktur File

```
supabase/
├── 01_setup.sql       # Extension, tabel transaksi, RLS & policy
└── 02_functions.sql   # Function semantic search (match_transactions)
```

---

## Tech Stack

| Layer           | Tech                                                          |
| --------------- | ------------------------------------------------------------- |
| Database        | PostgreSQL (via Supabase)                                     |
| Vector search   | pgvector                                                      |
| Auth            | Supabase Auth                                                 |
| Embedding model | _(sesuaikan dengan pilihan kamu, misal: OpenAI, Gemini, dst)_ |

---

## Cara Setup

Jalankan file SQL secara berurutan di **Supabase SQL Editor**:

```sql
-- Step 1: Setup extension, tabel, dan RLS
\i supabase/01_setup.sql

-- Step 2: Buat function semantic search
\i supabase/02_functions.sql
```

---

## Cara Kerja Semantic Search

```
User input teks
      ↓
App konversi teks → vector 768 dimensi (via embedding model)
      ↓
Kirim vector ke function match_transactions(query_embedding, threshold, limit)
      ↓
pgvector hitung cosine similarity semua transaksi di database
      ↓
Return transaksi yang relevan secara makna
```

Contoh: user search _"pengeluaran makan minggu ini"_ → akan menemukan transaksi
dengan description seperti _"lunch di kantor"_, _"beli groceries"_, dll —
meskipun kata-katanya tidak sama persis.

---

## Function: `match_transactions`

```sql
SELECT * FROM match_transactions(
    query_embedding  := '[0.1, 0.2, ...]'::vector,  -- vector dari query user
    match_threshold  := 0.8,                         -- minimal 80% similarity
    match_count      := 5                            -- kembalikan 5 hasil teratas
);
```

| Parameter         | Tipe          | Keterangan                      |
| ----------------- | ------------- | ------------------------------- |
| `query_embedding` | `vector(768)` | Embedding dari teks yang dicari |
| `match_threshold` | `float`       | Batas minimal similarity (0–1)  |
| `match_count`     | `int`         | Jumlah hasil yang dikembalikan  |

---

## Catatan Penting

> ⚠️ **RLS Policy** saat ini menggunakan mode permissive (semua user bisa akses semua data).
> Ini hanya untuk keperluan development/testing.
> Sebelum deploy ke production, aktifkan policy per-user di `01_setup.sql`.
