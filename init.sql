-- Enable pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Example: Create a table for storing document embeddings
CREATE TABLE IF NOT EXISTS documents (
    langchain_id uuid PRIMARY KEY,
    embedding vector(768),
    content text NOT NULL,
    section text NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create an index for fast vector similarity search
CREATE INDEX ON documents USING ivfflat (embedding vector_cosine_ops)
WITH (lists = 100);