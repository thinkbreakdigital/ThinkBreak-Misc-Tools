# **Salary ↔ Hourly Calculator**

## **Overview Document**

### **Section 1: Page Definitions for Salary to Hourly and Hourly to Salary**

## **Tool structure**

This tool includes three flip-through views inside a single HTML file:

1. Salary to Hourly  
2. Hourly to Salary  
3. Salary vs Hourly

This document covers only the first two views.

The first two pages should feel closely related, with matching structure and similar visual hierarchy, while allowing each page to focus on the compensation questions that are most natural for that direction of comparison.

---

# **Page 1: Salary to Hourly**

## **Purpose**

This page helps a user estimate what a salaried job is effectively worth on an hourly basis after factoring in:

* average hours worked per week  
* paid vacation time  
* overtime-weighted comparison for hours over 40

The page should answer this question clearly:

“What is this salary really worth per hour based on how much I work?”

---

## **User inputs**

This page should allow the user to enter:

* annual salary  
* average hours worked per week  
* vacation amount  
* vacation unit as days or weeks

This page should not ask for an overtime toggle. Overtime comparison should be treated as part of the page logic whenever weekly hours exceed 40\.

---

## **Main result**

The primary result on this page is:

* Estimated Hourly Rate

This number should represent the salary translated into an hourly comparison using the page’s assumptions and adjustments.

This result is the main reason the page exists and should be the most visually prominent output.

---

## **Supporting breakdown section**

A second section should explain the estimated hourly result by showing the major factors that shape it.

This section should include:

* Base Hourly Rate  
   The salary translated to an hourly number without vacation adjustment and without overtime weighting

* Value of Paid Vacation  
   Shown in red to indicate that paid vacation reduces the amount of actual time worked and affects the comparison

* Value of Overtime When Hourly  
   The additional value that would exist in an hourly model when weekly hours exceed 40  
   This should display as `0` when weekly hours are 40 or under

This section exists to make the page feel explainable rather than opaque.

---

## **Pay breakdown section**

A third section should let the user view the compensation in one of three pay periods:

* Yearly  
* Monthly  
* Weekly

This section should include a three-way toggle to switch between those views.

For the selected period, the section should show:

* total pay for that period  
* overtime value for that period  
* numbers that update to match the selected pay period

This section is meant to help users compare compensation in a timeframe that feels intuitive to them.

---

## **Graph section**

Below the pay breakdown, this page should include a simple bar graph.

### **Graph structure**

* Y axis: annual money earned  
* X axis: Salary and Hourly

### **Graph meaning**

* Salary bar shows annual salary total  
* The top highlighted portion of the Salary bar represents the portion attributable to paid vacation value  
* Hourly bar shows the annualized hourly comparison total  
* The top highlighted portion of the Hourly bar represents the portion attributable to overtime pay

The graph is meant to visually reinforce the difference between:

* fixed salaried compensation with paid time off  
* hourly-style compensation that can gain additional value through overtime

---

## **Page goal**

This page should feel like a conversion page with explanation built in.

A user should leave this page understanding:

* what their salary roughly equals per hour  
* how vacation affects that comparison  
* how overtime changes the hourly-side comparison  
* what their pay looks like across common timeframes

---

# **Page 2: Hourly to Salary**

## **Purpose**

This page helps a user estimate what an hourly job annualizes to as a salary equivalent after factoring in:

* hourly rate  
* average hours worked per week  
* overtime treatment for hours over 40 when enabled

The page should answer this question clearly:

“What does this hourly pay work out to as a salary?”

---

## **User inputs**

This page should allow the user to enter:

* hourly rate  
* average hours worked per week  
* overtime toggle

This page should not include vacation input.

That keeps the hourly-side conversion simpler and avoids introducing a second concept that makes the page harder to read.

---

## **Main result**

The primary result on this page is:

* Estimated Salary Equivalent

This number should represent what the hourly pay annualizes to under the entered weekly hours and overtime setting.

This should be the most prominent result on the page.

---

## **Supporting breakdown section**

A second section should explain how the salary equivalent is formed.

This section should include:

* Base Salary Equivalent  
   Straight annualized pay without overtime added

* Overtime Value  
   The additional annual earnings created by hours above 40 when overtime is enabled  
   This should display as `0` when weekly hours are 40 or under or when overtime is turned off

* Effective Salary Equivalent  
   The final annualized earnings after overtime is included

This section gives the user a clear view of how much of their annualized earnings comes from straight time versus overtime.

---

## **Pay breakdown section**

A third section should provide the same three-way pay period toggle used on the first page:

* Yearly  
* Monthly  
* Weekly

For the selected period, the section should show:

* total pay  
* overtime portion  
* base pay portion

This keeps the page consistent with Salary to Hourly while matching the logic of hourly earnings.

---

## **Graph section**

Below the pay breakdown, this page should include a simple bar graph.

### **Graph structure**

* Y axis: annual money earned  
* X axis: Salary and Hourly

### **Graph meaning**

* Salary bar shows the estimated salary equivalent total  
* No top highlighted portion of the Salary bar   
* Hourly bar shows the annual hourly total  
* The top highlighted portion of the Hourly bar also represents the overtime-derived portion

On this page, the graph is less about vacation and more about showing how overtime contributes to annualized compensation.

---

## **Page goal**

This page should feel like the inverse of Salary to Hourly, but not a duplicate.

A user should leave this page understanding:

* what their hourly pay roughly equals as a yearly salary  
* how much overtime contributes to that annualized number  
* what their pay looks like across common timeframes

---

# **Shared design intent for both pages**

These first two pages should feel like a matched pair.

Each page should include:

* one main input/result section  
* one explanatory breakdown section  
* one timeframe breakdown section  
* one visual comparison graph

The structure should stay familiar from one page to the next so the user can switch views without relearning the tool.

The difference between the pages should come from the compensation logic, not from major layout changes.

---

# **Scope boundary for these two pages**

These pages should remain simple utility views.

They should not introduce:

* saved history  
* advanced scenario modeling  
* employer deductions  
* tax calculations  
* benefits modeling  
* multi-step workflows  
* modal-heavy explanation flows

They should remain focused on a single job compensation comparison at a time, with immediate results and plain-language outputs.