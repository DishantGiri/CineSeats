# CineSeats - Milestone 2 Testing Document

## 1. Basic Webforms (CRUD Operations)

| Test Case ID | Form Name | Action | Expected Result | Status |
|--------------|-----------|--------|-----------------|--------|
| TC-01 | User Details | Add New | User is saved to `USER_TABLE` and appears in GridView. | Pass |
| TC-02 | User Details | Edit | Existing user details are updated. | Pass |
| TC-03 | User Details | Delete | User is removed from DB. | Pass |
| TC-04 | Theater | Add New | Theater info saved; Validation ensures name is unique. | Pass |
| TC-05 | Showtimes | Add New | Showtime linked to Movie & Hall successfully. | Pass |
| TC-06 | Movie | Search | Filtering by title returns matching records. | Pass |

## 2. Complex Webforms (Reports & Analytics)

### 2.1 User Ticket Report
- **Input:** Select User "Pratibha Gurung".
- **Logic:** Filter `TICKET` and `BOOKING` in the last 6 months.
- **SQL Query:** 
  ```sql
  SELECT t.TICKET_ID, m.TITLE, s.SHOW_DATE
  FROM TICKET t 
  JOIN BOOKING b ON t.BOOKING_ID = b.BOOKING_ID 
  JOIN SHOWTIME s ON b.SHOWTIME_ID = s.SHOWTIME_ID 
  JOIN MOVIE m ON s.MOVIE_ID = m.MOVIE_ID 
  WHERE b.USER_ID = :uid AND b.BOOKING_TIME >= ADD_MONTHS(SYSDATE, -6)
  ```
- **Result:** Displayed list of 5 tickets bought since September 2025.

### 2.2 Theater Movie Schedule
- **Input:** Select Theater "Kumari Cinemas Pokhara".
- **Logic:** Cross-reference Hall and Showtimes.
- **Result:** GridView shows "Avatar: Fire and Ash" for Morning, Day, and Evening slots.

### 2.3 Movie Occupancy Analytics (Top 3)
- **Input:** Select Movie "Avatar: Fire and Ash".
- **Logic:** `(Sold Tickets / Capacity) * 100`. Only `TICKET_STATUS = 'Paid'`.
- **Result:** Top 3 halls displayed with progress bars (e.g., Pokhara Cineplex 95%, Labim Mall 82%, etc.).

## 3. Failure Cases & Corrections

| Failure Scenario | Observation | Correction Measure |
|------------------|-------------|--------------------|
| Database Connection Timeout | App crashes on load. | Implemented try-catch in `DatabaseHelper` with user-friendly alerts. |
| Negative Ticket Price | User could enter -50. | Added validation in code-behind to ensure price > 0. |
| Duplicate Email | Primary key constraint error. | Added logic to check if email exists before insertion. |

## 4. Environment Details
- **Frontend:** ASP.NET Web Forms (C#)
- **Backend:** Oracle Database 19c/21c
- **Driver:** Oracle.ManagedDataAccess (ODP.NET Managed Driver)
