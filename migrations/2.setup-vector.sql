-- =============================================================
-- FILE: 02_functions.sql
-- DESC: Function untuk semantic search transaksi menggunakan
--       cosine similarity dari pgvector
-- =============================================================


-- -------------------------------------------------------------
-- FUNCTION: match_transactions
--
-- Cara kerja:
--   1. Terima embedding dari query user (dikirim dari aplikasi)
--   2. Bandingkan dengan semua embedding di tabel transactions
--   3. Hitung similarity score pakai cosine similarity
--   4. Filter hasil yang di bawah threshold
--   5. Kembalikan N hasil teratas yang paling relevan
--
-- Contoh penggunaan dari aplikasi:
--   SELECT * FROM match_transactions(
--     query_embedding := '[0.1, 0.2, ...]'::vector,
--     match_threshold := 0.8,
--     match_count     := 5
--   );
-- -------------------------------------------------------------
CREATE OR REPLACE FUNCTION match_transactions (
    -- Vector dari teks yang dicari (dihasilkan oleh model embedding di app)
    query_embedding  VECTOR(768),
    -- Batas minimal similarity score. Contoh: 0.8 = hanya tampilkan yang 80%+ mirip
    match_threshold  FLOAT,
    -- Jumlah maksimal baris yang dikembalikan (seperti LIMIT)
    match_count      INT
)

RETURNS TABLE (
    id          UUID,
    type        TEXT,
    category    TEXT,
    amount      NUMERIC,
    description TEXT,
    date        DATE,
    user_id     UUID,
    similarity  FLOAT
)

-- STABLE: fungsi ini hanya membaca data, tidak mengubah apapun di database
LANGUAGE sql STABLE
AS $$
    SELECT
        transactions.id,
        transactions.type,
        transactions.category,
        transactions.amount,
        transactions.description,
        transactions.date,
        transactions.user_id,

        -- Operator <=> menghitung cosine distance (0 = identik, 2 = berlawanan).
        -- "1 - distance" mengubahnya jadi similarity score (1 = identik, 0 = tidak mirip).
        1 - (transactions.embedding <=> query_embedding) AS similarity

    FROM transactions

    -- Filter: buang hasil yang similarity-nya di bawah threshold
    WHERE 1 - (transactions.embedding <=> query_embedding) > match_threshold

    -- Urutkan dari yang paling mirip (cosine distance terkecil = paling relevan)
    ORDER BY transactions.embedding <=> query_embedding

    LIMIT match_count;
$$;