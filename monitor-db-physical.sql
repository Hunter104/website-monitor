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
