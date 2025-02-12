# 📦 Amazon Customer Behavior Analysis

## 📌 **Project Background**
Amazon is in **e-commerce and cloud computing**, offering a wide range of products and services. Understanding customer behavior is **critical** for improving user experience, boosting sales, and reducing cart abandonment rates.

As a **data analyst**, my goal was to analyze survey responses to uncover **customer preferences, pain points, and areas of improvement**. This project provides **data-driven insights** into **customer satisfaction, cart abandonment, and shopping behavior**.

### **Key Areas of Analysis**
1. **Demographics Insights** – Understanding customer distribution by **gender & age group**.
2. **Cart Abandonment** – Identifying key reasons why customers abandon their carts.
3. **Improvement Areas** – Analyzing feedback on where Amazon can enhance its services.
4. **Purchase Frequency & Service Appreciation** – Understanding buying patterns and what customers value most.

---

## 🔧 **Tools & Technologies Used**
| Category       | Tools & Technologies |
|---------------|----------------------|
| **Database & SQL**  | MySQL |
| **Data Cleaning & Transformation** | SQL (JOINs, Aggregations, CASE Statements) |
| **Visualization & BI Tools** | Tableau |
| **File Handling** | CSV, Excel |


---

## 📊 **Data Structure & Initial Checks**
Amazon’s **customer survey database** consists of the following **tables**:

| Table Name       | Description |
|-----------------|-------------|
| `customer_behavior`  | Contains customer demographics and survey responses. |
| `cart_abandonment`  | Details reasons why users abandoned their cart. |
| `improvement_areas`  | Contains feedback on areas Amazon can improve. |
| `purchase_behavior` | Data on purchase frequency and preferred services. |


---

## 📌 **SQL Queries & Data Cleaning**
### 🔹 **Data Cleaning & Transformation**
- The SQL queries used to clean and prepare the data can be found **[here](link-to-your-Customer_Behavior.sql)**.

---

## 📊 ** Tableau Dashboard**

<img width="1000" alt="Screen Shot 2025-02-12 at 3 35 48 PM" src="https://github.com/user-attachments/assets/3dc04966-9180-47de-a7bb-5b522f184db9" />



---

## 📢 **Executive Summary**
### **🔍 Key Findings:**
📌 **Total Survey Responses:** **1,204**  
📌 **Main Customer Demographic:** **Females (60.38%) & Young Adults (55.33%)**  
📌 **Top Cart Abandonment Reason:** **42.36% of customers found a better price elsewhere**  

#### **Top 3 Insights for Stakeholders:**
1. **Most customers are young adults**, indicating that Amazon’s marketing should focus on this age group.
2. **Cart abandonment is primarily driven by price comparisons**, meaning competitive pricing strategies or **price-matching** could help reduce lost sales.
3. **Customer Service and Product Quality were the top requested improvement areas**, suggesting that enhancements in these areas would **increase retention and loyalty**.

---

## 📊 **Insights Deep Dive**
### **🔹 Category 1: Customer Demographics**
✅ **Key Insight 1:** The majority of Amazon's survey respondents are **female (60.38%)** and **young adults (55.33%)**.  
✅ **Key Insight 2:** Middle-aged adults make up **38%**, while seniors represent only **4.83%**.  

<img width="390" alt="Age Group" src="https://github.com/user-attachments/assets/8d74f4d5-fabb-40b9-81cd-dce8005abae7" />

<img width="344" alt="Gender" src="https://github.com/user-attachments/assets/28310b3d-fb31-482c-8a26-ef587df7cb0f" />




---

### **🔹 Category 2: Cart Abandonment**
✅ **Key Insight 1:** **42.36%** of customers abandoned their cart due to finding a **better price elsewhere**.  
✅ **Key Insight 2:** **40.03% changed their mind**, indicating that Amazon could benefit from **retargeting ads & reminder emails**.  
✅ **Key Insight 3:** **High shipping costs (11.63%)** are a significant factor, suggesting that offering **discounted shipping options** might improve conversions.  

<img width="600" alt="Screen Shot 2025-02-12 at 3 24 30 PM" src="https://github.com/user-attachments/assets/b6c0305a-3883-4c29-a935-d66fbb4d05a1" />


---

### **🔹 Category 3: Improvement Areas**
✅ **Key Insight 1:** **Customer Service (434 mentions)** was the most commonly cited area for improvement.  
✅ **Key Insight 2:** **Product Quality (318 mentions)** and **Reducing Waste (266 mentions)** were also top concerns.  
✅ **Key Insight 3:** **Shipping (160 mentions)** had the least complaints, indicating Amazon’s logistics are performing well.  

<img width="600" alt="Screen Shot 2025-02-12 at 3 25 19 PM" src="https://github.com/user-attachments/assets/881b369e-d64d-4b3d-81c0-064be7c85078" />


---

### **🔹 Category 4: Purchase Frequency & Service Appreciation**
✅ **Key Insight 1:** **Most customers shop "a few times a month"**, while **only a small percentage shop multiple times per week**.  
✅ **Key Insight 2:** **Product recommendations and competitive prices were the most appreciated aspects** of Amazon’s service.  
✅ **Key Insight 3:** **A user-friendly website was the least mentioned service appreciation metric**, suggesting that Amazon’s website usability is already optimized.  

<img width="600" alt="Screen Shot 2025-02-12 at 3 31 28 PM" src="https://github.com/user-attachments/assets/7a95bbca-ac87-48e1-aa75-977e752b82fe" />

<img width="600" alt="Screen Shot 2025-02-12 at 3 28 43 PM" src="https://github.com/user-attachments/assets/da7efec1-2be7-4205-b40d-d3ab988ddeff" />


---

## 📢 **Recommendations**
Based on these insights, here are **data-driven recommendations** for Amazon’s business strategy:

1. **Enhance Competitive Pricing Strategies** – Since **price comparison drives cart abandonment**, Amazon should explore **dynamic pricing, price-matching, or exclusive discounts**.
2. **Improve Customer Service & Product Quality** – Addressing these **top concerns** will improve retention and long-term loyalty.
3. **Expand Targeted Marketing for Young Adults** – The majority of customers are **young adults**, so **social media & influencer marketing** may be effective.
4. **Optimize Shipping Costs & Promotions** – Offering **lower-cost or free shipping incentives** could help reduce **cart abandonment** due to high shipping costs.
5. **Enhance Retargeting for Abandoned Carts** – Implementing **email reminders, personalized deals, or urgency tactics** can help recapture lost sales.

---

## **⚠️ Assumptions & Caveats**
1. **Survey responses were self-reported**, meaning customer perceptions may not always reflect actual business performance.
2. **Demographics data is based only on survey respondents**, so it may not fully represent Amazon’s entire customer base.
3. **Cart abandonment reasons do not include additional behavioral data**, such as session tracking or bounce rates.
4. **The analysis focuses only on survey responses**, and **does not include real purchase data or returns**.


---

## 🚀 **Next Steps**
🔹 **Analyze customer lifetime value (CLV) to prioritize high-value users.**  
🔹 **Incorporate real-time purchase data for a more comprehensive view.**  
🔹 **Explore text sentiment analysis on customer reviews for deeper insights.**  

