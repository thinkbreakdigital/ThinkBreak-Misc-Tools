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

---

# **Implementation function plan for V1**

This section defines the JavaScript functions that should exist to support the first two views only:

1. Salary to Hourly  
2. Hourly to Salary

The file should still be structured so a third `Salary vs Hourly` view can be added later without rewriting the overall flow.

The goal of this section is to define function responsibilities before layout sections, fields, and toggles are finalized.

---

## **Shared application functions**

These functions should control the overall tool structure and allow both pages to work through one shared update flow.

### `getElements()`

Collect and return the DOM elements used by the tool.

This should include:

* view switch controls
* all input fields
* all result fields
* pay-period toggle controls
* overtime toggle control
* validation message area
* graph elements

This should act as the central DOM cache so the rest of the file does not repeatedly query the document.

### `getOptions()`

Read the current UI state and return a normalized options object.

This should include:

* the active view
* current numeric inputs
* vacation unit
* overtime enabled state
* selected pay period

This should convert raw form values into a clean shape that calculation functions can use.

### `bindEvents()`

Attach event listeners to all inputs and controls.

This should support:

* live recalculation when values change
* switching between the two views
* switching between yearly, monthly, and weekly breakdown views
* enabling or disabling overtime where applicable

The page should feel immediate, so this function should ensure all relevant user actions flow into one shared update cycle.

### `switchView(viewName)`

Change the active page view between:

* `salary-to-hourly`
* `hourly-to-salary`

This should update active-state UI and trigger re-rendering.

It should be written generically so a third view can be added later without redesigning the view system.

### `renderActiveView(viewName)`

Show the currently selected view and hide the inactive one.

This should only deal with presentation state, not business logic.

### `updateOutput()`

Act as the main controller for the tool.

This function should:

1. read the current options
2. validate them
3. determine which view is active
4. run the matching calculation path
5. render the matching outputs

This should be the central input-to-output workflow for the entire file.

### `validateOptions(options)`

Validate the normalized input values before calculations run.

This should guard against:

* empty required fields
* invalid numeric input
* negative values
* zero where zero would break the comparison

This should return a simple valid or invalid result plus a plain-language message when needed.

### `renderValidationMessage(message)`

Show a short, plain-language error message when the entered values cannot be calculated.

This should preserve the current inputs and avoid clearing the interface abruptly.

### `clearValidationMessage()`

Remove any visible validation message after the inputs become valid again.

### `formatCurrency(value)`

Format money consistently across:

* main results
* supporting breakdown values
* timeframe breakdown values
* graph labels

This should ensure all money outputs are displayed in one consistent style.

### `getSelectedPayPeriod()`

Return the currently selected pay period:

* yearly
* monthly
* weekly

This can either read directly from the DOM or work from the normalized options object, depending on implementation.

### `getPayPeriodDivisor(period)`

Return the value used to convert annual amounts into the selected timeframe.

This function should support annual-to:

* yearly
* monthly
* weekly

This keeps period conversion logic in one place.

---

## **Salary to Hourly functions**

These functions should support the page that converts annual salary into an effective hourly comparison.

### `getSalaryToHourlyInputs(options)`

Return only the inputs needed for the Salary to Hourly path.

This should isolate:

* annual salary
* average hours worked per week
* vacation amount
* vacation unit

This keeps view-specific logic separate from the shared state object.

### `convertVacationToWeeks(vacationAmount, vacationUnit)`

Convert vacation entered as days or weeks into a normalized week value.

This ensures the rest of the calculations use one vacation representation.

### `calculateAnnualWorkingWeeks(vacationWeeks)`

Determine how many weeks are actually worked in the year after paid vacation is removed from worked time.

This value should support the effective hourly comparison.

### `calculateBaseHourlyRateFromSalary(annualSalary, hoursPerWeek)`

Calculate the salary translated into a basic hourly rate without:

* vacation adjustment
* overtime weighting

This should match the spec definition of Base Hourly Rate.

### `calculatePaidVacationValue(annualSalary, vacationWeeks)`

Calculate the annual value attributable to paid vacation.

This should support:

* the supporting breakdown section
* the graph highlight on the salary bar

### `calculateHourlyOvertimeValueFromSalaryComparison(annualSalary, hoursPerWeek, vacationWeeks)`

Calculate the additional value that would exist if the same work pattern were paid hourly and overtime-weighted for hours above 40.

This should return `0` when weekly hours are 40 or below.

This should support:

* the supporting breakdown section
* the pay breakdown section
* the graph highlight on the hourly bar

### `calculateEstimatedHourlyRate(annualSalary, hoursPerWeek, vacationWeeks)`

Calculate the main result for the Salary to Hourly page.

This should represent the effective hourly comparison after the page assumptions are applied.

This is the primary output of the page.

### `buildSalaryToHourlyBreakdown(inputs)`

Return a single calculation object containing all Salary to Hourly outputs needed by the page.

This should include:

* estimated hourly rate
* base hourly rate
* paid vacation value
* hourly overtime value
* annual totals needed for period breakdown
* annual totals needed for graph display

This should act as the page-level calculation bundle for the view.

### `getSalaryToHourlyPayBreakdown(calculation, period)`

Convert the Salary to Hourly calculation bundle into the selected timeframe view.

For the chosen period, this should provide:

* total pay
* overtime value

This section does not need a separate base-pay line unless design decisions later require it.

### `buildSalaryToHourlyGraphData(calculation)`

Return the graph data needed for the Salary to Hourly page.

This should include:

* annual salary total
* salary-side paid vacation highlighted portion
* annualized hourly comparison total
* hourly-side overtime highlighted portion

This should prepare data only, not render the graph.

### `renderSalaryToHourlyResults(calculation)`

Render all Salary to Hourly outputs to the page.

This should update:

* the main result
* the supporting breakdown section
* the pay breakdown section
* the graph

---

## **Hourly to Salary functions**

These functions should support the page that converts hourly pay into a salary-equivalent annual figure.

### `getHourlyToSalaryInputs(options)`

Return only the inputs needed for the Hourly to Salary path.

This should isolate:

* hourly rate
* average hours worked per week
* overtime enabled state

### `calculateBaseSalaryEquivalent(hourlyRate, hoursPerWeek)`

Calculate the straight annualized pay without overtime added.

This should match the spec definition of Base Salary Equivalent.

### `calculateAnnualOvertimeValue(hourlyRate, hoursPerWeek, overtimeEnabled)`

Calculate the annual overtime contribution created by hours above 40 when overtime is enabled.

This should return `0` when:

* weekly hours are 40 or below
* overtime is turned off

### `calculateEffectiveSalaryEquivalent(hourlyRate, hoursPerWeek, overtimeEnabled)`

Calculate the final estimated salary equivalent after overtime is included where applicable.

This is the primary output of the page.

### `buildHourlyToSalaryBreakdown(inputs)`

Return a single calculation object containing all Hourly to Salary outputs needed by the page.

This should include:

* base salary equivalent
* overtime value
* effective salary equivalent
* annual totals needed for period breakdown
* annual totals needed for graph display

This should act as the page-level calculation bundle for the view.

### `getHourlyToSalaryPayBreakdown(calculation, period)`

Convert the Hourly to Salary calculation bundle into the selected timeframe view.

For the chosen period, this should provide:

* total pay
* base pay portion
* overtime portion

### `buildHourlyToSalaryGraphData(calculation)`

Return the graph data needed for the Hourly to Salary page.

This should include:

* salary-equivalent annual total
* hourly annual total
* hourly-side overtime highlighted portion

The salary bar on this page does not need a highlighted top portion.

### `renderHourlyToSalaryResults(calculation)`

Render all Hourly to Salary outputs to the page.

This should update:

* the main result
* the supporting breakdown section
* the pay breakdown section
* the graph

---

## **Shared pay breakdown and graph functions**

These functions should support both views so the tool stays structurally consistent.

### `buildPayBreakdown(annualTotals, period)`

Convert annual values into the selected pay period.

This should keep yearly, monthly, and weekly conversion logic shared rather than duplicated per page.

### `renderPayBreakdown(payBreakdown, viewName)`

Render the timeframe section for the active page using the already computed pay breakdown data.

This should adapt labels and displayed rows to the current page without changing the core layout pattern.

### `renderSupportingBreakdown(breakdown, viewName)`

Render the explanatory breakdown section for the active page.

This should keep the presentation logic shared where practical while allowing the labels and values to differ between the two views.

### `buildGraphScale(graphData)`

Determine the graph scale from the maximum annual value that needs to be displayed.

This should allow both bars to be sized relative to the same annual-money axis.

### `getBarHeight(value, maxValue)`

Translate a graph value into a bar height for rendering.

This should keep visual scaling logic isolated from graph markup updates.

### `renderGraph(graphData, viewName)`

Render the active page graph using prebuilt graph data.

This should update:

* bar heights
* labels
* highlighted portions
* any annual total text shown near the graph

This function should stay generic enough to support the third view later.

---

## **Initialization**

### `init()`

Initialize the shared page behavior and then the tool-specific calculator behavior.

This should:

1. initialize theme and gradient handling already present in `Components/base-tool-template.html`
2. cache or prepare tool DOM references
3. bind tool event listeners
4. render the starting view
5. run the first output update

---

## **V2 readiness for the third view**

Version 1 should only build:

* Salary to Hourly
* Hourly to Salary

However, the shared tool structure should leave room for a future third view without large refactoring.

That means:

* `switchView(viewName)` should not be hard-wired to only one page
* `renderActiveView(viewName)` should use a reusable view pattern
* `updateOutput()` should route by active view
* shared breakdown and graph renderers should remain view-aware rather than page-specific where possible

When the third view is specified later, the likely additional functions will be:

* `getSalaryVsHourlyInputs(options)`
* `buildSalaryVsHourlyBreakdown(inputs)`
* `getSalaryVsHourlyPayBreakdown(calculation, period)`
* `buildSalaryVsHourlyGraphData(calculation)`
* `renderSalaryVsHourlyResults(calculation)`

Those future functions should plug into the same shared update flow rather than creating a separate architecture.
