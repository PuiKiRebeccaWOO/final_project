# **Digital Nomads & Co-Working Spaces Analysis**

## **Business Questions**

### **Market Identification & City Selection**
- Where should we establish co-working spaces to attract digital nomads?
- Which countries or cities are most attractive for digital nomads?
- How do quality of life factors (e.g., safety, cost of living, healthcare, climate, internet speed) influence city selection?

### **Competitive Analysis**
- Which cities have low competition but high demand for co-working spaces?
- What are the gaps in existing co-working spaces that we can fill? (WeWork)

### **Digital Nomads Behavior Analysis**
- How long do digital nomads stay in one country on average?
- What are the most common work types among digital nomads?

### **Hypothesis**
- Digital nomads prefer cities with a lower cost of living and fast internet speed.

---

## **Data Sources**
- [Global Cost of Living Dataset](https://www.kaggle.com/datasets/mvieira101/global-cost-of-living): Contains the cost of living indices for various cities, including food, transportation, and rent.
- [Quality of Life by Country](https://www.kaggle.com/datasets/ahmedmohamed2003/quality-of-life-for-each-country): Measures safety, healthcare, climate, and purchasing power.
- [Global Internet Speed 2022](https://www.kaggle.com/datasets/prashant808/global-internet-speed-2022): Lists broadband and mobile internet speeds by country.
- **Web Scrapers**:
  - [NomadList](https://nomads.com/): Extracts city ratings and digital nomad statistics.
  - [WeWork Sitemap](https://www.wework.com/sitemap): Retrieves global WeWork locations.

---

## **Data Cleaning**

### **Cost of Living Data**
- Selected relevant columns (`meal`, `mcdonalds`, `beer`, `coffee`, `monthly_pass`, `monthly_rent`).
- Renamed columns for clarity.
- Converted values from **USD to EUR** using a conversion rate of `0.953124`.

### **Quality of Life Data**
- Standardized column names (lowercase, underscores instead of spaces).
- Removed irrelevant columns (`purchasing_power`, `health_care`, `property_price_to_income`, etc.).

### **Internet Speed Data**
- Loaded broadband and mobile speed data.

### **Nomads & Users Work Data**
- Removed unnecessary columns (`followers`, `following`, `education_raw`).
- Handled missing values and renamed `work_raw` to `work`.
- Transformed `work` column into **binary matrix format** for occupation analysis.

### **User Trips Data**
- Dropped redundant columns (`country_slug`, `place_slug`).
- Converted `date_start` and `date_end` into datetime format.
- Calculated **travel duration (`day_travel`)** for each user trip.
- Normalized `city` and `country` names to remove special characters.

### **WeWork Locations Data**
- Cleaned **address formatting** to fix encoding issues.
- Applied **geolocation functions** to add latitude/longitude for missing locations.
- Standardized country names and **converted incorrect country codes (e.g., `UK` → `GB`)**.

---

## **Database Design & Creation**
The `nomads` schema consists of the following tables in MySQL:

- **`nomads`**: Contains digital nomad user data.
- **`quality_of_life`**: Quality of life metrics per country.
- **`cost_of_living`**: Breakdown of living costs in various cities.
- **`internet_speed`**: Internet speed data by country.
- **`wework_loc`**: Locations of WeWork offices worldwide.
- **`user_trips`**: Records of digital nomads' stays in different countries.
- **`users_work`**: Information on digital nomads' professions and work trends.