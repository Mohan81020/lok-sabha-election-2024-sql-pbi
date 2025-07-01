# 🗳️ Lok Sabha Election 2024 Results Analysis | SQL & Power BI

This project presents a comprehensive analysis of the **2024 Lok Sabha (Indian General) Election** using **SQL** and **Power BI**. By transforming raw voting data into meaningful insights, we aim to uncover patterns in vote shares, party performance, and constituency-level results across India.

---

## 📌 Project Overview

The **Lok Sabha Election 2024 Results Analysis** project leverages SQL queries and Power BI to understand India's democratic outcomes. The dataset contains detailed information on state-wise constituencies, political parties, vote counts (EVM and postal), winning margins, and candidates.

The key focus areas include:
- Party-wise seat distribution
- Vote share analysis
- Constituency-level comparisons
- Margin of victory and competition
- EVM vs postal vote trends

---

## 🛠️ Tools Used

- **SQL Server** — For querying, aggregation, and KPI extraction  
  👉 [SQL Code](./Election_Result_2024_Analysis.sql)
- **Power BI** — For data visualization and dashboarding  
  👉 [Dashboard Screenshot](./election_Result_2024_Analysis.png)
- **Excel / CSV** — Raw dataset in spreadsheet format  
  👉 [Dataset File](./Dataset/election_result_2024.xlsx)

---

## 📂 Dataset Description

The dataset contains row-level data of each candidate contesting in every constituency for the 2024 Indian general elections. Key columns include:

| Column Name         | Description                                               |
|---------------------|-----------------------------------------------------------|
| `election_year`     | Year of the election (2024)                               |
| `state_name`        | Name of the state                                         |
| `constituency_name` | Name of the constituency                                  |
| `constituency_type` | General or Reserved (e.g., ST, SC)                        |
| `party_name`        | Name of the political party                               |
| `candidate_name`    | Name of the contesting candidate                          |
| `EVM_votes`         | Votes received through Electronic Voting Machines         |
| `postal_votes`      | Votes received via postal ballots                         |
| `total_votes`       | Combined total votes (EVM + postal)                       |
| `rank`              | Rank based on total votes in the constituency             |
| `units`             | Indicates absolute vote counts                            |

---

## ❓ Questions Answered

1. Which party secured the highest number of seats?
2. What is the distribution of votes by party and state?
3. Which candidates had the highest winning margins?
4. How many total votes were cast through EVM and postal ballots?
5. Which constituencies had the closest races?
6. What percentage of seats were won by top political parties?
7. How many independent candidates contested, and how did they perform?

---

## 🔍 Key Insights

- **Bharatiya Janata Party (BJP)** secured the majority with **239 seats**.
- **Indian National Congress (INC)** followed with **99 seats**.
- **645 million total votes** were recorded, with **99.42% through EVMs**.
- Close contests were observed in several constituencies, with margins under 1,000 votes.
- Multiple constituencies had **10+ candidates**, indicating strong electoral competition.
- NOTA (None of the Above) received **6 million+ votes**, signifying voter awareness.

---

## 📊 Power BI Dashboard Features

- **Top 5 Parties by Seats & Vote Share**
- **State-wise Constituency Votes (Map)**
- **EVM vs Postal Votes Overview**
- **Victory Margins by Candidate**
- **Interactive Filters by State & Constituency**
- **Party-wise Constituency Table**

> 📍 *See Power BI dashboard screenshots [here](./election_Result_2024_Analysis.png).*

---

## ✅ Conclusion

This project highlights how structured query language (SQL) combined with Power BI can help decode complex election data into clear visual narratives. From identifying top-performing parties to analyzing vote shares and margins, this analysis provides valuable insights into the **2024 Indian General Elections**.

The approach can be scaled to analyze elections across years and regions, making it a powerful framework for political and public data analytics.

---

---

## 📬 Contact

**Author**: Mohan Kumar  
**Mail**: mohan122000kumar@gmail.com

---

⭐ *Feel free to fork or star this repo if you found it useful!*


