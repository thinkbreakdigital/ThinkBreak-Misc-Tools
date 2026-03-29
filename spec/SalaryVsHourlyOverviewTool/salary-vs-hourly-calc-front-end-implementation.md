# **Salary vs Hourly Calculator**

## **Front-End Implementation**

This document captures the front-end build rules for version 1 of the tool.

It applies only to:

* Salary to Hourly
* Hourly to Salary

The third `Salary vs Hourly` view should not be built yet, but the structure should leave room for it later.

---

# **V1 layout, fields, and control rules**

This section defines the intended structure, fields, and toggle behavior for the first build of the tool.

---

## **Global toggle rules**

### **Two-option compact toggle rule**

Any two-option selector used in this tool should be extremely compact.

This includes cases such as:

* days vs weeks
* other future two-option view-local selectors if added

The required behavior is:

* no border around the overall toggle element
* option 1 sits immediately to the left of the switch control
* option 2 sits immediately to the right of the switch control
* both labels should sit very tight to the toggle itself
* the toggle control itself should stay visually minimal and compact
* the switch color should not change when clicked
* the selected option label should use `--text`
* the unselected option label should use `--text-dim`

The active state should be communicated through the label color change rather than a dramatic switch-color change.

### **Three-way selector rule**

The three-way selector used for pay periods should be visually different from the compact two-option toggle.

The required behavior is:

* it should be wider than the compact toggle
* it should be taller than the compact toggle
* the option labels should live inside the switch itself
* the three options should be:
  * yearly
  * monthly
  * weekly
* default option text color should be `--text-dim`
* the selected option text color should be `--text`

Interaction behavior:

* whichever option the switch is currently on is the active option
* the control should feel like a segmented selector rather than three separate buttons
* the active state should be communicated primarily through text color and selector position, not loud color changes

This selector should read as one compact control embedded within the pay breakdown section.

---

## **Shared page structure for V1**

Both V1 pages should follow the same section order:

1. primary input and result section
2. supporting breakdown section
3. pay breakdown section
4. graph section

This structure should feel consistent across both views, even though the field set and labels differ.

---

## **Page 1: Salary to Hourly section definition**

### **Primary section**

This section is the top section for the Salary to Hourly page.

It should contain the user inputs on the left and the main output on the right.

#### **Fields**

The left side should include:

* annual salary
* average hours worked per week
* vacation amount
* vacation unit selector as days or weeks

The vacation unit selector should use the compact two-option toggle rule.

#### **Main result placement**

The right side of this section should display:

* Hourly Equivalent

This result should sit in the top-right area of the section and should be visually dominant.

#### **Main result format**

The displayed format should be:

* `$XX.xx/hr`

Formatting requirements:

* the dollar value should be very large
* the cents should be smaller than the rest of the value
* the `/hr` should read clearly but not overpower the amount
* in dark mode, this result should be `#ffffff`
* in light mode, this result should be `#000000`
* this color treatment should apply regardless of the normal body text color tokens

The main result should be the visual anchor of the section.

#### **Primary section behavior**

This section should update live as the user edits values.

It should not require a calculate button.

### **Supporting breakdown section**

This section should appear directly below the primary section.

It should include three rows or stat blocks:

* Base Hourly Rate
* Value of Paid Vacation
* Value of Overtime When Hourly

Behavior rules:

* Value of Paid Vacation should be shown in red
* Value of Overtime When Hourly should show `0` when weekly hours are 40 or below
* this section should clarify how the Hourly Equivalent is formed

### **Pay breakdown section**

This section should appear below the supporting breakdown section.

It should include:

* a three-way selector for Yearly, Monthly, and Weekly
* total pay for the selected period
* overtime value for the selected period

This section should update immediately when either:

* the inputs change
* the selected period changes

### **Graph section**

This section should appear below the pay breakdown section.

It should include a simple two-bar comparison:

* Salary
* Hourly

The graph should show:

* annual salary total for the salary bar
* paid vacation as the highlighted top portion of the salary bar
* annualized hourly comparison total for the hourly bar
* overtime as the highlighted top portion of the hourly bar

---

## **Page 2: Hourly to Salary section definition**

This page should mirror the section structure of the first page while changing the inputs and labels to match the inverse calculation.

### **Primary section**

This section should use the same overall layout pattern as the Salary to Hourly page:

* inputs on the left
* main result on the right

#### **Fields**

The left side should include:

* hourly rate
* average hours worked per week
* overtime toggle

The overtime control should use the compact two-option toggle approach adapted for on/off behavior.

The control should remain visually minimal and should not use loud state changes.

#### **Main result placement**

The right side of this section should display:

* Salary Equivalent

This should occupy the same visual role as Hourly Equivalent on page 1.

#### **Main result format**

The displayed format should be an annual currency amount.

Recommended format:

* `$XX,XXX`
* or `$XX,XXX.xx` if cent precision is kept consistently across the page

Visual rules:

* this result should be very large
* it should sit in the top-right area of the section
* in dark mode, it should be `#ffffff`
* in light mode, it should be `#000000`
* this color treatment should override the standard text token behavior

### **Supporting breakdown section**

This section should include:

* Base Salary Equivalent
* Overtime Value
* Effective Salary Equivalent

Behavior rules:

* Overtime Value should display `0` when overtime is off
* Overtime Value should display `0` when weekly hours are 40 or below
* Effective Salary Equivalent should match the main result

### **Pay breakdown section**

This section should use the same embedded three-way selector pattern as page 1.

For the selected period, it should include:

* total pay
* base pay portion
* overtime portion

### **Graph section**

This section should use the same structural graph pattern as page 1.

The graph should show:

* salary-equivalent annual total for the salary bar
* hourly annual total for the hourly bar
* overtime as the highlighted top portion of the hourly bar

The salary bar on this page should not use a highlighted top segment.

---

## **Shared section and element guidance**

### **Section labels and organization**

Each section should be easy to scan and clearly separated by spacing rather than heavy framing.

The tool should favor:

* compact section labels
* direct field labels
* minimal helper text
* obvious numeric outputs

### **Field behavior**

All numeric fields should:

* use clear labels
* accept direct entry
* update outputs immediately
* handle invalid or empty input gracefully

There should be no multi-step flow and no submit button requirement.

### **Primary result behavior**

The primary result on both pages should:

* be visible without scrolling past the primary section
* update live
* use stronger visual contrast than surrounding text
* remain readable in both light and dark mode

### **Validation behavior**

If the inputs are incomplete or invalid:

* keep the layout intact
* keep the user-entered values visible
* show a short plain-language message
* avoid hiding the whole page structure

### **Graph behavior**

The graph should remain simple.

It should:

* compare Salary and Hourly side by side
* use annual totals as the scale basis
* visually distinguish the highlighted top portion from the main bar body
* support both V1 pages with the same rendering pattern

---

## **Implementation guidance inferred from this structure**

The HTML template should ultimately include:

* a top-level view switcher for the two active V1 pages
* one page container for Salary to Hourly
* one page container for Hourly to Salary
* within each page:
  * one primary section
  * one supporting breakdown section
  * one pay breakdown section
  * one graph section

The JavaScript should treat each page as a view with:

* its own input set
* its own calculation path
* its own result labels
* shared rendering patterns for toggles, period selection, breakdown rows, and graph structure

This should preserve a clean path for adding the future third view without changing the V1 page architecture.
