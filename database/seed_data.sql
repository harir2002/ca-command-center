-- Clear existing data
TRUNCATE alerts, documents, tasks, deadlines, clients RESTART IDENTITY CASCADE;

-- =====================
-- 20 CLIENTS
-- =====================
INSERT INTO clients (name, pan_number, gst_number, contact, category) VALUES
('Rajesh Enterprises', 'ABCDE1234F', '29ABCDE1234F1Z5', '9876543210', 'business'),
('Meena Iyer', 'FGHIJ5678K', NULL, '9123456789', 'individual'),
('Sundar & Co', 'LMNOP9012Q', '33LMNOP9012Q1Z2', '9012345678', 'business'),
('Kavitha Textiles', 'QRSTU3456V', '32QRSTU3456V1Z3', '8901234567', 'business'),
('Arjun Kumar', 'VWXYZ7890A', NULL, '8012345678', 'individual'),
('Sri Lakshmi Traders', 'BCDEF2345G', '29BCDEF2345G1Z6', '7901234567', 'business'),
('Priya Consultants', 'GHIJK6789L', '27GHIJK6789L1Z7', '7012345678', 'business'),
('Ramesh Constructions', 'MNOPQ0123R', '24MNOPQ0123R1Z8', '6901234567', 'business'),
('Anitha Fashions', 'RSTUV4567W', '33RSTUV4567W1Z9', '6012345678', 'business'),
('Vikram Industries', 'WXYZ89012X', '29WXYZ89012X1Z0', '9811234567', 'business'),
('Deepa Sharma', 'YZABC3456Y', NULL, '9722345678', 'individual'),
('Global Tech Solutions', 'ABCDE7890Z', '07ABCDE7890Z1Z1', '9633456789', 'business'),
('Chennai Metals', 'FGHIJ1234A', '33FGHIJ1234A1Z2', '9544567890', 'business'),
('Bangalore Exports', 'KLMNO5678B', '29KLMNO5678B1Z3', '9455678901', 'business'),
('Suresh Pharma', 'PQRST9012C', '29PQRST9012C1Z4', '9366789012', 'business'),
('Heritage Hotels', 'UVWXY3456D', '32UVWXY3456D1Z5', '9277890123', 'business'),
('Nair Electronics', 'ZABCD7890E', '32ZABCD7890E1Z6', '9188901234', 'business'),
('Patel Agro', 'EFGHI2345F', '24EFGHI2345F1Z7', '9099012345', 'business'),
('Sonia Kapoor', 'JKLMN6789G', NULL, '8910123456', 'individual'),
('Rainbow Logistics', 'OPQRS0123H', '06OPQRS0123H1Z8', '8821234567', 'business');

-- =====================
-- 40 DEADLINES
-- =====================
INSERT INTO deadlines (client_id, filing_type, due_date, status, assigned_to) VALUES
-- Critical (due today/tomorrow)
(1, 'GSTR-3B', CURRENT_DATE, 'pending', 'Hari'),
(3, 'TDS Return Q4', CURRENT_DATE, 'pending', 'Hari'),
(10, 'GSTR-1', CURRENT_DATE + 1, 'pending', 'Hari'),
(12, 'TDS Return Q4', CURRENT_DATE + 1, 'pending', 'Hari'),
-- Due this week
(2, 'ITR-1 FY2025-26', CURRENT_DATE + 2, 'pending', 'Hari'),
(4, 'GSTR-3B', CURRENT_DATE + 2, 'pending', 'Hari'),
(5, 'ITR-2 FY2025-26', CURRENT_DATE + 3, 'pending', 'Hari'),
(6, 'GSTR-1', CURRENT_DATE + 3, 'pending', 'Hari'),
(7, 'ROC Annual Filing', CURRENT_DATE + 4, 'pending', 'Hari'),
(8, 'GSTR-3B', CURRENT_DATE + 4, 'pending', 'Hari'),
(9, 'TDS Return Q4', CURRENT_DATE + 5, 'pending', 'Hari'),
(11, 'ITR-1 FY2025-26', CURRENT_DATE + 5, 'pending', 'Hari'),
(13, 'GSTR-1', CURRENT_DATE + 6, 'pending', 'Hari'),
(14, 'GSTR-3B', CURRENT_DATE + 6, 'pending', 'Hari'),
(15, 'ROC Annual Filing', CURRENT_DATE + 7, 'pending', 'Hari'),
-- Due next 2 weeks
(16, 'GSTR-1', CURRENT_DATE + 8, 'pending', 'Hari'),
(17, 'ITR-3 FY2025-26', CURRENT_DATE + 9, 'pending', 'Hari'),
(18, 'GSTR-3B', CURRENT_DATE + 10, 'pending', 'Hari'),
(19, 'ITR-1 FY2025-26', CURRENT_DATE + 11, 'pending', 'Hari'),
(20, 'TDS Return Q4', CURRENT_DATE + 12, 'pending', 'Hari'),
(1, 'GSTR-1', CURRENT_DATE + 13, 'pending', 'Hari'),
(2, 'Advance Tax Q1', CURRENT_DATE + 14, 'pending', 'Hari'),
(3, 'GSTR-3B', CURRENT_DATE + 15, 'pending', 'Hari'),
(4, 'ROC Annual Filing', CURRENT_DATE + 16, 'pending', 'Hari'),
(5, 'TDS Return Q4', CURRENT_DATE + 17, 'pending', 'Hari'),
-- Already filed
(6, 'GSTR-3B March', CURRENT_DATE - 5, 'filed', 'Hari'),
(7, 'GSTR-1 March', CURRENT_DATE - 8, 'filed', 'Hari'),
(8, 'ITR-1 FY2024-25', CURRENT_DATE - 15, 'filed', 'Hari'),
(9, 'TDS Return Q3', CURRENT_DATE - 20, 'filed', 'Hari'),
(10, 'GSTR-3B Feb', CURRENT_DATE - 25, 'filed', 'Hari'),
-- Overdue
(11, 'GSTR-3B March', CURRENT_DATE - 2, 'pending', 'Hari'),
(12, 'ROC Annual Filing', CURRENT_DATE - 3, 'pending', 'Hari'),
(13, 'TDS Return Q3', CURRENT_DATE - 5, 'pending', 'Hari'),
(14, 'ITR-2 FY2024-25', CURRENT_DATE - 7, 'pending', 'Hari'),
(15, 'GSTR-1 Feb', CURRENT_DATE - 10, 'pending', 'Hari'),
(16, 'Advance Tax Q4', CURRENT_DATE - 12, 'pending', 'Hari'),
(17, 'GSTR-3B Feb', CURRENT_DATE - 14, 'pending', 'Hari'),
(18, 'ROC Annual Filing', CURRENT_DATE - 16, 'pending', 'Hari'),
(19, 'TDS Return Q2', CURRENT_DATE - 20, 'pending', 'Hari'),
(20, 'GSTR-1 Jan', CURRENT_DATE - 25, 'pending', 'Hari');

-- =====================
-- 40 TASKS
-- =====================
INSERT INTO tasks (client_id, description, priority, due_date, status) VALUES
(1, 'Collect Q4 purchase invoices', 'high', CURRENT_DATE + 1, 'open'),
(1, 'Reconcile GSTR-2A vs purchase register', 'high', CURRENT_DATE + 2, 'open'),
(1, 'Verify ITC eligibility for capital goods', 'medium', CURRENT_DATE + 5, 'open'),
(2, 'Collect Form 16 from employer', 'high', CURRENT_DATE + 2, 'open'),
(2, 'Verify TDS deductions in Form 26AS', 'high', CURRENT_DATE + 3, 'open'),
(2, 'Collect bank statements for FY2025-26', 'medium', CURRENT_DATE + 4, 'open'),
(3, 'Reconcile TDS challans with TRACES', 'high', CURRENT_DATE + 1, 'open'),
(3, 'Verify PAN of all deductees', 'medium', CURRENT_DATE + 3, 'open'),
(3, 'Prepare TDS certificates Form 16A', 'high', CURRENT_DATE + 5, 'open'),
(4, 'Collect fabric purchase bills', 'high', CURRENT_DATE + 2, 'open'),
(4, 'Verify HSN codes for textile products', 'medium', CURRENT_DATE + 4, 'open'),
(4, 'Reconcile export invoices with GSTR-1', 'high', CURRENT_DATE + 3, 'open'),
(5, 'Collect salary slips for ITR', 'high', CURRENT_DATE + 3, 'open'),
(5, 'Verify 80C investments - LIC, PPF, ELSS', 'medium', CURRENT_DATE + 5, 'open'),
(5, 'Check HRA exemption documents', 'low', CURRENT_DATE + 6, 'open'),
(6, 'Collect all sales invoices Q4', 'high', CURRENT_DATE + 2, 'open'),
(6, 'Verify e-way bills for interstate sales', 'medium', CURRENT_DATE + 4, 'open'),
(7, 'Prepare ROC filing documents', 'high', CURRENT_DATE + 3, 'open'),
(7, 'Get board resolution signed', 'high', CURRENT_DATE + 2, 'open'),
(7, 'File DIR-3 KYC for all directors', 'medium', CURRENT_DATE + 7, 'open'),
(8, 'Verify contractor payments for TDS', 'high', CURRENT_DATE + 4, 'open'),
(8, 'Collect subcontractor PAN details', 'medium', CURRENT_DATE + 5, 'open'),
(9, 'Check GST registration for new branch', 'high', CURRENT_DATE + 3, 'open'),
(9, 'Collect fashion week sale invoices', 'medium', CURRENT_DATE + 4, 'open'),
(10, 'Verify machinery depreciation calculations', 'medium', CURRENT_DATE + 6, 'open'),
(10, 'Collect import duty receipts', 'high', CURRENT_DATE + 2, 'open'),
(11, 'Collect rent receipts for HRA', 'medium', CURRENT_DATE + 5, 'open'),
(11, 'Verify Section 80D health insurance premium', 'low', CURRENT_DATE + 7, 'open'),
(12, 'Review software export invoices', 'high', CURRENT_DATE + 2, 'open'),
(12, 'Verify SEZ unit compliance', 'high', CURRENT_DATE + 3, 'open'),
(13, 'Collect scrap sale invoices', 'medium', CURRENT_DATE + 4, 'open'),
(13, 'Verify metal import HS codes', 'medium', CURRENT_DATE + 5, 'open'),
(14, 'Collect shipping bills for exports', 'high', CURRENT_DATE + 2, 'open'),
(14, 'Verify IGST refund status', 'high', CURRENT_DATE + 3, 'open'),
(15, 'Check drug license renewal status', 'high', CURRENT_DATE + 1, 'open'),
(15, 'Collect pharma distribution invoices', 'medium', CURRENT_DATE + 4, 'open'),
(16, 'Verify hotel GST rate applicability', 'medium', CURRENT_DATE + 5, 'open'),
(17, 'Collect electronics purchase invoices', 'high', CURRENT_DATE + 2, 'open'),
(18, 'Verify agricultural income exemption', 'medium', CURRENT_DATE + 6, 'open'),
(19, 'Collect house property documents', 'medium', CURRENT_DATE + 5, 'open'),
-- Completed tasks
(1, 'File GSTR-1 for March 2026', 'high', CURRENT_DATE - 5, 'done'),
(2, 'Submit advance tax Q4', 'high', CURRENT_DATE - 10, 'done'),
(3, 'File GSTR-3B February 2026', 'high', CURRENT_DATE - 8, 'done'),
(4, 'Prepare balance sheet FY2024-25', 'high', CURRENT_DATE - 15, 'done'),
(5, 'File ITR for AY2025-26', 'high', CURRENT_DATE - 20, 'done');

-- =====================
-- 30 DOCUMENTS
-- =====================
INSERT INTO documents (client_id, doc_type, received_date, notes) VALUES
(1, 'Purchase Invoices Q4', CURRENT_DATE - 2, 'Received 45 invoices via email'),
(1, 'Bank Statement', CURRENT_DATE - 3, 'HDFC current account March 2026'),
(1, 'GST Certificate', CURRENT_DATE - 30, 'Original copy received'),
(2, 'Form 16', CURRENT_DATE - 1, 'From TCS Limited FY2025-26'),
(2, 'Form 26AS', CURRENT_DATE - 1, 'Downloaded from IT portal'),
(3, 'TDS Challans', CURRENT_DATE - 4, 'Q4 challans BSR code verified'),
(3, 'Salary Register', CURRENT_DATE - 5, 'March 2026 payroll'),
(4, 'Sales Invoices', CURRENT_DATE - 2, 'Textile exports 78 invoices'),
(4, 'E-way Bills', CURRENT_DATE - 3, 'All interstate consignments'),
(5, 'Salary Slips', CURRENT_DATE - 1, 'Apr 2025 to Mar 2026 complete'),
(5, 'LIC Premium Receipt', CURRENT_DATE - 2, 'Section 80C - Rs 1.5L'),
(5, 'PPF Passbook', CURRENT_DATE - 2, 'SBI PPF account statement'),
(6, 'Sales Register', CURRENT_DATE - 3, 'Q4 complete with HSN codes'),
(7, 'MOA & AOA', CURRENT_DATE - 10, 'Certified copies for ROC filing'),
(7, 'Board Resolution', CURRENT_DATE - 2, 'Signed by all directors'),
(8, 'Contractor Bills', CURRENT_DATE - 4, 'Section 194C payments list'),
(9, 'GST Returns', CURRENT_DATE - 5, 'Previous 6 months filings'),
(10, 'Import Documents', CURRENT_DATE - 3, 'Bill of entry customs receipts'),
(10, 'Fixed Asset Register', CURRENT_DATE - 5, 'Updated with new machinery'),
(11, 'Rent Receipts', CURRENT_DATE - 1, 'April 2025 to March 2026'),
(12, 'Export Invoices', CURRENT_DATE - 2, 'USD invoices software exports'),
(12, 'FIRC Certificates', CURRENT_DATE - 3, 'Foreign inward remittance'),
(13, 'Purchase Register', CURRENT_DATE - 4, 'Metal scrap purchases Q4'),
(14, 'Shipping Bills', CURRENT_DATE - 2, 'Port clearance documents'),
(15, 'Drug License', CURRENT_DATE - 7, 'Valid till Dec 2026'),
(16, 'Hotel Revenue Report', CURRENT_DATE - 3, 'Room + F&B breakup March'),
(17, 'Stock Register', CURRENT_DATE - 4, 'Electronics inventory March 31'),
(18, 'Land Records', CURRENT_DATE - 6, 'Agricultural land ownership docs'),
(19, 'Property Tax Receipt', CURRENT_DATE - 2, 'Chennai corporation receipt'),
(20, 'Freight Invoices', CURRENT_DATE - 3, 'Logistics billing Q4');

-- =====================
-- 20 ALERTS
-- =====================
INSERT INTO alerts (deadline_id, alert_date, message, sent) VALUES
(1, CURRENT_DATE, '🔴 CRITICAL: GSTR-3B for Rajesh Enterprises due TODAY!', true),
(2, CURRENT_DATE, '🔴 CRITICAL: TDS Return Q4 for Sundar & Co due TODAY!', true),
(3, CURRENT_DATE, '🟡 WARNING: GSTR-1 for Vikram Industries due TOMORROW', true),
(4, CURRENT_DATE, '🟡 WARNING: TDS Return Q4 for Global Tech Solutions due TOMORROW', true),
(5, CURRENT_DATE, '🟡 WARNING: ITR-1 for Meena Iyer due in 2 days', false),
(6, CURRENT_DATE, '🟡 WARNING: GSTR-3B for Kavitha Textiles due in 2 days', false),
(31, CURRENT_DATE, '🔴 OVERDUE: GSTR-3B March for Deepa Sharma - 2 days overdue!', true),
(32, CURRENT_DATE, '🔴 OVERDUE: ROC Annual Filing for Global Tech Solutions - 3 days overdue!', true),
(33, CURRENT_DATE, '🔴 OVERDUE: TDS Return Q3 for Chennai Metals - 5 days overdue!', true),
(34, CURRENT_DATE, '🔴 OVERDUE: ITR-2 for Bangalore Exports - 7 days overdue!', true),
(35, CURRENT_DATE, '🔴 OVERDUE: GSTR-1 Feb for Suresh Pharma - 10 days overdue!', true),
(36, CURRENT_DATE, '🔴 OVERDUE: Advance Tax Q4 for Heritage Hotels - 12 days overdue!', true),
(7, CURRENT_DATE + 1, '📅 REMINDER: ITR-2 for Arjun Kumar due in 3 days', false),
(8, CURRENT_DATE + 1, '📅 REMINDER: GSTR-1 for Sri Lakshmi Traders due in 3 days', false),
(9, CURRENT_DATE + 2, '📅 REMINDER: ROC Annual Filing for Priya Consultants due in 4 days', false),
(10, CURRENT_DATE + 2, '📅 REMINDER: GSTR-3B for Ramesh Constructions due in 4 days', false),
(11, CURRENT_DATE + 3, '📅 REMINDER: TDS Return Q4 for Anitha Fashions due in 5 days', false),
(12, CURRENT_DATE + 3, '📅 REMINDER: ITR-1 for Deepa Sharma due in 5 days', false),
(13, CURRENT_DATE + 4, '📅 REMINDER: GSTR-1 for Chennai Metals due in 6 days', false),
(14, CURRENT_DATE + 4, '📅 REMINDER: GSTR-3B for Bangalore Exports due in 6 days', false);