# 🩺 CareBridge — AI-Powered Health Companion

> **Better care. Stronger you.**  
> CareBridge is an intelligent patient health management web platform that helps individuals track medical conditions, monitor symptoms, organize recovery records, and chat with an AI health companion tailored specifically to their conditions.

---

## 🌐 Live Application

* **Live URL**: **[https://carebridge-blesson-paul-ee45565c12ed.herokuapp.com/](https://carebridge-blesson-paul-ee45565c12ed.herokuapp.com/)**
* **Deployment Stack**: Heroku (Europe `eu`), Ruby 3.3, Rails 8, PostgreSQL, Puma

---

## 🔑 Demo Login Credentials

You can use any of the seeded patient accounts below to test the platform.

### 🌟 Primary Demo Account (Recommended)
| Field | Credential |
|---|---|
| **Email** | `demo@carebridge.test` |
| **Password** | `password123` |
| **Patient** | Alex Morgan |
| **Profile** | Age ~36 (May 1990), Non-binary |
| **Conditions** | Seasonal allergies (*Active*), Migraine (*Active*) + Pre-loaded AI chats |

---

### 👥 Other Available Demo Patients
*All test accounts use password:* `password123`

| Patient Name | Email | Gender | Pre-loaded Conditions |
|---|---|---|---|
| **Jordan Lee** | `jordan.lee@carebridge.test` | Female | Type 2 diabetes, Hypertension |
| **Samir Patel** | `samir.patel@carebridge.test` | Male | Asthma, Eczema |
| **Priya Shah** | `priya.shah@carebridge.test` | Female | Iron deficiency anemia, Anxiety |
| **Marcus Reed** | `marcus.reed@carebridge.test` | Male | Osteoarthritis, High cholesterol |
| **Elena Garcia** | `elena.garcia@carebridge.test` | Female | Hypothyroidism, Vitamin D deficiency |
| **Noah Williams** | `noah.williams@carebridge.test` | Male | Acne (*Active*), Sprained ankle (*Cured*) |
| **Aisha Khan** | `aisha.khan@carebridge.test` | Female | IBS, Lactose intolerance |

---

## ✨ Key Features

1. **Patient Dashboard & Profile Summary**:
   - Dynamic real-time calculation of patient age and profile statistics.
   - Real-time counters for **Active**, **Cured**, and **Archived** conditions.

2. **Condition Management & 1-Click Status Toggles**:
   - **Active vs. Cured**: Toggle condition status instantly with a 1-click status switch on condition cards and detail pages.
   - **Distinct Visual Themes**: Active illnesses display amber accents; cured/recovered illnesses display a fresh mint green celebratory theme with wellness icons.

3. **Multi-Tab Organization & Real-Time Search**:
   - Filter seamlessly between **`All`**, **`Active`** *(Default)*, **`Cured`**, and **`Archived History`**.
   - Instant search bar filters conditions and symptoms in real time without page reloads.

4. **Non-Destructive Archiving**:
   - Move resolved or old conditions to **Archived History** instead of permanent deletion, preserving full medical logs and conversation history.
   - 1-click **Restore to Active** action.

5. **AI Health Chat Companion**:
   - Context-aware AI chat rooms attached to each specific health condition.
   - Full message history and styled conversation bubbles.

---

## 🛠️ Tech Stack & Gems

- **Framework**: Ruby on Rails 8.1
- **Language**: Ruby 3.3
- **Database**: PostgreSQL (pg)
- **Authentication**: Devise
- **Frontend & Styling**: Bootstrap 5, Sass / SCSS, FontAwesome 6, SimpleForm
- **JavaScript & SPA**: Hotwire (Turbo + Stimulus), Importmaps
- **Web Server**: Puma

---

## 💻 Local Development Setup

### Prerequisites
- Ruby 3.3+
- PostgreSQL
- Bundler

### Installation

```bash
# 1. Clone repository
git clone git@github.com:Blesson-Paul/carebridge.git
cd carebridge

# 2. Install dependencies
bundle install

# 3. Setup database and load demo seed data
bin/rails db:create db:migrate db:seed

# 4. Start Rails development server
bin/rails server
```

Open **[http://127.0.0.1:3000](http://127.0.0.1:3000)** in your browser.

---

## 🚀 Deployment to Heroku

```bash
# Deploy latest master branch
git push heroku master

# Run database migrations
heroku run rails db:migrate

# Seed demo data
heroku run rails db:seed
```
