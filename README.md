# Management Mobile App 📱

A cross-platform **project & team management** mobile application built with **Flutter (Dart)**.  
The app lets you **plan, monitor, and review projects, tasks, and teams**, assign people to projects, and visualize overall progress with basic **statistics and charts**.  
Data is persisted locally using **SQLite (`sqflite`)**, and **Firebase Cloud Messaging** is integrated for optional push notifications.

> The full assignment brief (“Progetto 3 – Gestione progetti”) is included in the repository as:  
> `3-Gestione progetti.pdf`.

---

## 🧭 Overview

- **Projects** have metadata (name, description, release/deadline, status, team, thumbnail) and a list of **tasks** (completed / not completed).  
- **Teams** group employees (each employee can belong to **up to two teams**) with basic info (id, name, surname, role).  
- **Dashboard** highlights **recent/active projects**, quick actions, and **incomplete tasks** you can complete in place.  
- **Filtering & search** let you quickly access a project or team without navigating from scratch.  
- A **Statistics** screen provides at least one summary metric and one chart (as required by the brief).

---

## ✅ Feature Mapping (against the brief)

- **Minimum screens**: Dashboard, Project/Team management, Add/Edit, Statistics.  
- **Dashboard**:  
  - Shows a **summary of recently modified & active projects** (status: *Active*, *Suspended*, *Archived*).  
  - Archived projects can be labeled **Completed** or **Failed**; failure includes a **reason** field.  
  - Displays **only incomplete tasks** per project with a control to mark them **Completed**.  
  - List length **k configurable** (e.g., 5/10/20) via app **Settings** (stored in `Setting` table).  
- **Teams**:  
  - Team has a **name** and **≥2 members**; each **member can belong to at most two teams** (`mainTeam`, `secondaryTeam`).  
  - The list **highlights the top three teams by size** (largest member counts).  
- **Project/Team management screen**:  
  - Full lists with **filter & search**, **detail views**, and **all tasks for a project**.  
- **Add/Edit screen**:  
  - Create new projects/teams and **edit existing ones**, including **editing tasks** for a project.  
- **Statistics**:  
  - At least **one statistic** and **one chart** (implemented with `fl_chart`).  
- **Push notifications**:  
  - **Firebase Cloud Messaging** integrated; can be used to remind about upcoming deadlines (e.g., due in 5 days).  
- **Tech constraints**:  
  - **Flutter** UI, responsive layouts (portrait/landscape), and local persistence with **SQLite** (`sqflite`).

---

## 🏗️ Tech Stack

| Layer | Technology |
|--------|-------------|
| **Framework** | Flutter (Dart) |
| **Local DB** | SQLite via `sqflite` |
| **Cloud Messaging** | Firebase Cloud Messaging |
| **Charts** | fl_chart |
| **IDE** | Android Studio / Visual Studio Code |

---

## 🗄️ Data Model (SQLite)

- **Project**: name, description, creation/expiration dates, lastModified, status (`Active/Suspended/Archived`), `projectFailureReason`, team, thumbnail  
- **Task**: name, completed (0/1), project (FK)  
- **Team**: name, thumbnail  
- **Member**: code (id), name, surname, role, mainTeam, secondaryTeam (≤ 2 teams)  
- **Setting**: name (key), number (value) — used for configurable UI settings (e.g., *k* projects on dashboard)

Sample seed data populate example projects, tasks, teams, and members on first run.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed: [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)  
- Android Studio or VS Code with Flutter/Dart extensions  
- (Optional) Firebase project for Cloud Messaging (use your own `google-services.json` / `GoogleService-Info.plist` via `firebase_options.dart`)

### Setup
```bash
cd Progetto/flutter_application
flutter pub get
flutter run
```
> If you enable FCM: configure your Firebase project and regenerate firebase_options.dart (via FlutterFire CLI).

---

## 🔎 Key Interactions
- **Dashboard**
  - Shows **recent & active projects** (summary only)
  - **Incomplete tasks** visible & completable inline
  - List length **k** configurable in Settings
- **Projects/Teams**
  - Full lists with **search & filters**
  - **Project details** show all tasks (complete/incomplete)
  - **Teams** view shows top 3 by size + team details & members
- **Add/Edit**
  - Create/edit **Project and Team**
  - **Edit project tasks** (add/remove/complete)
  - Archive project as **Completed** or **Failed** (with failure reason)
- **Statistics**
  - One **aggregate metric** (e.g., number of projects/teams/members)
  - One **chart** (project status breakdown, etc.) using `fl_chart`

---

## 🔔 Notifications (optional)
With Firebase Cloud Messaging, you can push reminders (e.g., projects due in 5 days).
Enable FCM in `main.dart` and configure permissions on the device

---

## 📄 Assignment Reference
All functional and UI requirements come from:
`3-Gestione progetti.pdf` (included in this repository).

---

## 👤 Author
Developed by Aldo Buongiorno, Mario Izzo, Giulio Buonanno, Carmine Vardaro.

---

## 🪪 License
No license specified.
All rights reserved unless otherwise stated.
