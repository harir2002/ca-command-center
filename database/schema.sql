-- ================================================
-- CA COMMAND CENTER — DATABASE SCHEMA
-- AlloyDB (PostgreSQL Compatible)
-- Gen AI Academy APAC Edition Hackathon
-- ================================================

-- Drop tables if exist (clean slate)
DROP TABLE IF EXISTS alerts CASCADE;
DROP TABLE IF EXISTS documents CASCADE;
DROP TABLE IF EXISTS tasks CASCADE;
DROP TABLE IF EXISTS deadlines CASCADE;
DROP TABLE IF EXISTS clients CASCADE;

-- Drop views if exist
DROP VIEW IF EXISTS vw_upcoming_deadlines CASCADE;
DROP VIEW IF EXISTS vw_overdue_filings CASCADE;
DROP VIEW IF EXISTS vw_open_tasks CASCADE;
DROP VIEW IF EXISTS vw_pending_document_clients CASCADE;

-- Drop function if exists
DROP FUNCTION IF EXISTS update_updated_at_column CASCADE;

-- ================================================
-- TABLE 1: CLIENTS
-- ================================================
CREATE TABLE clients (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL,
    pan_number  TEXT UNIQUE,
    gst_number  TEXT UNIQUE,
    contact     TEXT,
    category    TEXT CHECK (category IN ('individual', 'business', 'trust', 'ngo')),
    email       TEXT,
    city        TEXT,
    state       TEXT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ================================================
-- TABLE 2: DEADLINES
-- ================================================
CREATE TABLE deadlines (
    id            SERIAL PRIMARY KEY,
    client_id     INT NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    filing_type   TEXT NOT NULL,
    due_date      DATE NOT NULL,
    status        TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'filed', 'overdue', 'waived')),
    assigned_to   TEXT DEFAULT 'Hari',
    filing_period TEXT,
    remarks       TEXT,
    filed_date    DATE,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ================================================
-- TABLE 3: TASKS
-- ================================================
CREATE TABLE tasks (
    id          SERIAL PRIMARY KEY,
    client_id   INT NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    priority    TEXT DEFAULT 'medium' CHECK (priority IN ('high', 'medium', 'low')),
    due_date    DATE,
    status      TEXT DEFAULT 'open' CHECK (status IN ('open', 'in_progress', 'done', 'cancelled')),
    assigned_to TEXT DEFAULT 'Hari',
    notes       TEXT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ================================================
-- TABLE 4: DOCUMENTS
-- ================================================
CREATE TABLE documents (
    id            SERIAL PRIMARY KEY,
    client_id     INT NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    doc_type      TEXT NOT NULL,
    received_date DATE NOT NULL,
    filing_year   TEXT,
    notes         TEXT,
    received_by   TEXT DEFAULT 'Hari',
    is_verified   BOOLEAN DEFAULT FALSE,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ================================================
-- TABLE 5: ALERTS
-- ================================================
CREATE TABLE alerts (
    id          SERIAL PRIMARY KEY,
    deadline_id INT NOT NULL REFERENCES deadlines(id) ON DELETE CASCADE,
    alert_date  DATE NOT NULL,
    alert_type  TEXT DEFAULT 'reminder' CHECK (alert_type IN ('reminder', 'critical', 'overdue')),
    message     TEXT NOT NULL,
    sent        BOOLEAN DEFAULT FALSE,
    sent_at     TIMESTAMP,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ================================================
-- INDEXES
-- ================================================
CREATE INDEX idx_deadlines_due_date     ON deadlines(due_date);
CREATE INDEX idx_deadlines_status       ON deadlines(status);
CREATE INDEX idx_deadlines_client_id    ON deadlines(client_id);
CREATE INDEX idx_tasks_client_id        ON tasks(client_id);
CREATE INDEX idx_tasks_status           ON tasks(status);
CREATE INDEX idx_tasks_priority         ON tasks(priority);
CREATE INDEX idx_documents_client_id    ON documents(client_id);
CREATE INDEX idx_documents_received     ON documents(received_date);
CREATE INDEX idx_alerts_deadline_id     ON alerts(deadline_id);
CREATE INDEX idx_alerts_sent            ON alerts(sent);
CREATE INDEX idx_clients_category       ON clients(category);

-- ================================================
-- AUTO TIMESTAMP FUNCTION + TRIGGERS
-- ================================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_clients_updated_at
    BEFORE UPDATE ON clients
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_deadlines_updated_at
    BEFORE UPDATE ON deadlines
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_tasks_updated_at
    BEFORE UPDATE ON tasks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ================================================
-- VIEWS
-- ================================================
CREATE OR REPLACE VIEW vw_upcoming_deadlines AS
SELECT
    c.name                          AS client_name,
    c.contact,
    d.filing_type,
    TO_CHAR(d.due_date,'DD-MM-YYYY') AS due_date,
    d.status,
    d.assigned_to,
    (d.due_date - CURRENT_DATE)     AS days_remaining
FROM deadlines d
JOIN clients c ON d.client_id = c.id
WHERE d.due_date >= CURRENT_DATE
  AND d.status = 'pending'
ORDER BY d.due_date ASC;

CREATE OR REPLACE VIEW vw_overdue_filings AS
SELECT
    c.name                          AS client_name,
    c.contact,
    d.filing_type,
    TO_CHAR(d.due_date,'DD-MM-YYYY') AS due_date,
    (CURRENT_DATE - d.due_date)     AS days_overdue,
    d.assigned_to
FROM deadlines d
JOIN clients c ON d.client_id = c.id
WHERE d.due_date < CURRENT_DATE
  AND d.status = 'pending'
ORDER BY d.due_date ASC;

CREATE OR REPLACE VIEW vw_open_tasks AS
SELECT
    c.name                          AS client_name,
    t.description,
    t.priority,
    TO_CHAR(t.due_date,'DD-MM-YYYY') AS due_date,
    t.status,
    t.assigned_to,
    (t.due_date - CURRENT_DATE)     AS days_remaining
FROM tasks t
JOIN clients c ON t.client_id = c.id
WHERE t.status IN ('open','in_progress')
ORDER BY
    CASE t.priority
        WHEN 'high'   THEN 1
        WHEN 'medium' THEN 2
        WHEN 'low'    THEN 3
    END,
    t.due_date ASC;

CREATE OR REPLACE VIEW vw_pending_document_clients AS
SELECT
    c.id,
    c.name      AS client_name,
    c.contact,
    c.email,
    c.category
FROM clients c
WHERE c.id NOT IN (
    SELECT DISTINCT client_id
    FROM documents
    WHERE received_date >= DATE_TRUNC('month', CURRENT_DATE)
)
ORDER BY c.name;

-- ================================================
-- SCHEMA COMPLETE ✅
-- Run seed_data.sql next
-- ================================================