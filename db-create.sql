-- =============================================
-- Author: Hunter104
-- Create date: 05/04/2025
-- Description: Script for initialization of website-monitor database
-- =============================================

CREATE TABLE Website (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  url TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  last_status TEXT CHECK (last_status IN ('UP', 'DOWN', 'SLOW')),
  last_checked TEXT
);

CREATE TRIGGER Trg_lastChecked
  AFTER UPDATE ON Website
  FOR EACH ROW
  WHEN NEW.last_checked = OLD.last_checked OR OLD.last_checked IS NULL
BEGIN 
  UPDATE Website SET last_checked = CURRENT_TIMESTAMP WHERE id=OLD.id;
END;

INSERT INTO Website (url, name) VALUES
('https://sigaa.unb.br', 'SIGAA'),
('https://aprender3.unb.br', 'Aprender3');
