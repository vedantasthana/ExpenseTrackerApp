CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE expenses (
    id BIGSERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    date TIMESTAMP NOT NULL,
    payer_id BIGINT REFERENCES users(id),
    category_id BIGINT REFERENCES categories(id),
    version BIGINT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT positive_amount CHECK (amount > 0)
);

CREATE TABLE shared_expenses (
    id BIGSERIAL PRIMARY KEY,
    expense_id BIGINT REFERENCES expenses(id) ON DELETE CASCADE,
    is_settled BOOLEAN DEFAULT FALSE,
    version BIGINT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE expense_splits (
    id BIGSERIAL PRIMARY KEY,
    shared_expense_id BIGINT REFERENCES shared_expenses(id) ON DELETE CASCADE,
    user_id BIGINT REFERENCES users(id),
    amount DECIMAL(10,2) NOT NULL,
    is_paid BOOLEAN DEFAULT FALSE,
    version BIGINT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT positive_split_amount CHECK (amount > 0)
);

CREATE TABLE expense_participants (
    shared_expense_id BIGINT REFERENCES shared_expenses(id) ON DELETE CASCADE,
    user_id BIGINT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (shared_expense_id, user_id)
);

CREATE INDEX idx_expenses_payer ON expenses(payer_id);
CREATE INDEX idx_expenses_category ON expenses(category_id);
CREATE INDEX idx_expenses_date ON expenses(date);
CREATE INDEX idx_shared_expenses_settled ON shared_expenses(is_settled);
CREATE INDEX idx_expense_splits_user ON expense_splits(user_id);

INSERT INTO categories (name, description) VALUES
    ('Food', 'Expenses related to food and dining'),
    ('Transportation', 'Travel and transportation expenses'),
    ('Utilities', 'Monthly utility bills'),
    ('Entertainment', 'Entertainment and leisure activities'),
    ('Shopping', 'General shopping expenses'),
    ('Healthcare', 'Medical and healthcare expenses'),
    ('Other', 'Miscellaneous expenses');
