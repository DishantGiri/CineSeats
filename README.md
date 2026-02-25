# CineSeats - Cinema Management System

## Project Overview
CineSeats is a centralized system for Kumari Cinemas to manage ticket bookings, theater capacities, and movie schedules efficiently across Nepal.

## Current Progress
- **Milestone 1**: Complete (Normalization, ERD, Oracle DB Setup)
- **Milestone 2**: Complete (ASP.NET Web Application, Basic & Complex Forms, Dashboard, Testing)
- **Milestone 3**: Pending (Final Submission)

## Features
- **Modern Dashboard**: High-level stats and quick access.
- **Entity Management**: CRUD operations for all core database tables.
- **Advanced Reporting**:
  - 6-Month User Purchase History.
  - Theater-specific showtime schedules.
  - Movie Occupancy Analytics (Top 3 Performance).
- **Premium UI**: Glassmorphic design with dark mode and Bootstrap 5.

## Tech Stack
- **Frontend**: ASP.NET Web Forms
- **Language**: C#
- **Database**: Oracle SQL
- **Styling**: Vanilla CSS + Bootstrap 5
- **Driver**: Oracle.ManagedDataAccess

## How to Run
1. Ensure Oracle DB is running with `HALLMANAGEMENT_DB` user.
2. Update `Web.config` connection string if host differs from `localhost:1521/xe`.
3. Open `CineSeats.sln` in Visual Studio and Run.
