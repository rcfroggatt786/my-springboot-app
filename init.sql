-- Initial database setup for Spring Boot app
-- This file runs automatically when the postgres container starts for the first time

-- Create a simple table for demo purposes
CREATE TABLE IF NOT EXISTS users (
                                     id SERIAL PRIMARY KEY,
                                     username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- Insert some sample data
INSERT INTO users (username, email) VALUES
                                        ('admin', 'russellfroggatt@gmail.com'),
                                        ('demo_user', 'demo@example.com')
    ON CONFLICT (username) DO NOTHING;

-- Grant permissions (optional, as appuser should already have access)
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO appuser;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO appuser;
