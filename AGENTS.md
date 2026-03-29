\# AGENTS.md

\#\# Purpose

This repository is for building small, browser-based utility tools that are simple, fast, private, and easy to hand off.

Every tool in this environment should be treated like a lightweight utility, not a full application.

\---

\#\# Core Product Rules

Each tool must follow these rules unless explicitly told otherwise:

\- Browser-only  
\- Client-side only  
\- No backend  
\- No accounts  
\- No login  
\- No saved user data  
\- No tracking  
\- No analytics  
\- No external API dependency  
\- No unnecessary libraries  
\- No build step unless absolutely required  
\- Prefer offline-capable behavior  
\- Prefer a single-file deliverable when practical

These tools should be safe to zip and send as static files.

\---

\#\# Tool Philosophy

Build tools that:  
\- solve one clear problem  
\- require minimal explanation  
\- work immediately  
\- have very low friction  
\- feel useful to a broad audience

Avoid tools that:  
\- depend on user history  
\- require multi-step workflows  
\- behave like dashboards or apps  
\- need complex onboarding  
\- collect or store personal information

The default pattern is:

\*\*input → transform/calculate → output\*\*

\---

\#\# Default Technical Approach

Prefer the simplest possible implementation.

\#\#\# Default stack  
\- \`index.html\`  
\- inline \`\<style\>\`  
\- inline \`\<script\>\`

Do not introduce frameworks, bundlers, or package managers unless specifically requested.

Avoid React, Vue, build pipelines, TypeScript, or npm-based tooling for these utilities unless there is a clear reason and the user asked for it.

\---

\#\# Coding Priorities

Optimize for:  
1\. Simplicity  
2\. Readability  
3\. Reliability  
4\. Portability  
5\. Low dependency count

Every implementation should be understandable by a developer opening the file for the first time.

\---

\#\# UI Rules

Keep the UI minimal.

\#\#\# Preferred layout  
\- single screen  
\- no routing  
\- no multiple pages  
\- no modal-heavy flow  
\- no onboarding  
\- no wizard behavior

\#\#\# Preferred interaction model  
\- paste or enter input  
\- see output immediately  
\- copy result if needed

\#\#\# UI standards  
\- clear label for every input  
\- clear output area  
\- live updates where appropriate  
\- minimal controls  
\- no decorative clutter  
\- accessible contrast  
\- responsive enough for desktop and mobile  
\- keyboard-friendly where reasonable

Use plain language in labels and helper text.

Displayed descriptions and helper text should include only the user-facing explanation requested for that tool.

Do not add extra on-page copy that explains repository rules, privacy posture, implementation details, or feature badges unless explicitly requested.

\---

\#\# State Management Rules

Assume no persistence by default.

Allowed:  
\- in-memory state for the current page session  
\- direct DOM updates  
\- recalculation on input change

Not allowed unless explicitly requested:  
\- localStorage  
\- sessionStorage  
\- cookies  
\- indexedDB  
\- user accounts  
\- remote persistence

If a tool cannot work without remembering data, it likely does not fit this environment.

\---

\#\# Privacy Rules

Treat privacy as a core requirement.

\- All processing should happen locally in the browser  
\- Do not transmit user input anywhere  
\- Do not embed tracking scripts  
\- Do not add telemetry  
\- Do not add analytics  
\- Do not log user input  
\- Do not fingerprint users  
\- Do not call third-party services unless explicitly required and approved

If using a third-party library, prefer local self-contained usage over remote dependencies.

\---

\#\# Dependency Rules

Default to zero dependencies.

A dependency is only acceptable if it is:  
\- clearly necessary  
\- lightweight  
\- stable  
\- easy to remove later

Before adding any dependency, ask:  
\- Can this be done with plain HTML, CSS, and JS?  
\- Does this dependency reduce complexity enough to justify itself?  
\- Will this make handoff harder?

If the answer is uncertain, do not add it.

\---

\#\# File and Project Structure

\#\#\# Preferred for handoff  
Single-file tools are preferred:

\`\`\`html  
index.html

### **Acceptable alternative**

tool-name/  
  index.html  
  styles.css  
  script.js

Keep file structure shallow and obvious.

Do not create large folder hierarchies for simple tools.

---

## **JavaScript Standards**

Write plain, clean JavaScript.

### **Preferred structure**

* small helper functions  
* one pure function for core logic where possible  
* one render/update function  
* direct event listeners  
* explicit naming

### **Recommended pattern**

1. Read inputs  
2. Normalize values  
3. Run a pure transform or calculation  
4. Render output

Keep business logic isolated from DOM manipulation whenever practical.

### **Avoid**

* overengineering  
* class-heavy patterns  
* unnecessary abstractions  
* premature generalization  
* hidden side effects  
* giant monolithic functions

---

## **CSS Standards**

Use lightweight CSS only.

* keep styles readable  
* prefer simple layout systems  
* avoid animation unless it improves clarity  
* avoid visual excess  
* keep components generic and reusable when practical

Prefer:

* system fonts  
* modest spacing  
* clear labels  
* simple cards or sections

Avoid:

* flashy styling  
* theme engines  
* excessive transitions  
* fragile layout tricks

---

## Appearance Mode Standards

All tools must support light and dark mode.

- Use CSS variables for all core colors
- Default to system preference via `prefers-color-scheme`
- Maintain accessible contrast in both modes
- Keep layouts identical across modes
- Do not hard-code text, background, border, or input colors per element unless necessary
- Every tool should be fully readable and usable in both modes with no extra setup

## **Accessibility Standards**

Every tool should meet a reasonable baseline of accessibility.

At minimum:

* labels tied to inputs  
* visible focus states  
* sufficient color contrast  
* semantic HTML  
* buttons use button elements  
* form controls use proper input types  
* output should be readable without relying only on color

---

## **Error Handling Standards**

Handle bad input gracefully.

* validate inputs before calculating  
* show clear, plain-language feedback  
* avoid crashes  
* avoid blank failures  
* guard against divide-by-zero, invalid URLs, empty inputs, and malformed text where relevant

When possible:

* fail softly  
* preserve user input  
* explain what is wrong in one sentence

---

## **Performance Standards**

These tools should feel instant.

* avoid heavy rendering  
* avoid unnecessary reflows  
* avoid large libraries  
* debounce only when needed  
* keep calculations lightweight

Most tools in this repo should work well on low-power devices.

---

## **Content and Copy Standards**

Use concise, plain-language interface copy.

* name the tool clearly  
* describe what it does in one sentence  
* label fields with everyday wording  
* avoid jargon unless the tool specifically requires it

Tool descriptions should explain:

* what goes in  
* what comes out  
* nothing more than necessary

Do not add extra descriptive UI copy such as "local only", "dark mode", "no signup", or similar feature/rule summaries unless the user explicitly asks for those to appear on the page.

---

## **Output Expectations**

When creating a new tool:

* keep it self-contained  
* make it easy to zip and send  
* avoid hidden setup requirements  
* avoid environment assumptions

When asked for deliverables, prefer:

1. complete `index.html`  
2. or complete replacement file contents  
3. or a complete 3-file static bundle

Do not provide partial snippets if the user asked for a full deliverable.

---

## **Template Scaffold Rule**

When the user asks to create a new tool from the template, use the local scaffold script instead of manually recreating the boilerplate.

- Run `powershell -ExecutionPolicy Bypass -File scripts\new-tool.ps1`
- Use the user-provided file name when available
- If the user did not provide a file name, ask only for the file name
- For requests that only ask to create an `.html` file from the template, only run the scaffold script with the provided file name and do not take additional steps
- After running the script, only confirm whether the file was successfully created or clearly state why it did not work
- Apply this same behavior every time the user asks for an `.html` file to be made from the template

---

## **Spec Review Rule**

Before planning, generating, or editing code, review all documents in `/spec` that are relevant to the current tool or request.

- Use the `/spec` folder as the source of truth for program requirements, styling direction, feature scope, and repository conventions beyond this file
- Check for both general specs and tool-specific specs before making implementation decisions
- If a spec conflicts with an older pattern in an existing file, follow the spec unless the user explicitly says otherwise
- When updating a shared pattern, also update the relevant spec document so future work stays aligned

---

## **Decision Filter**

Before building anything, check:

1. Is this a single-purpose tool?  
2. Can it run entirely in the browser?  
3. Can it avoid storing data?  
4. Can it be built with plain HTML/CSS/JS?  
5. Can a user understand it in under a minute?  
6. Can it be handed off as static files?

If not, simplify the scope.

---

## **What to Do When Scope Starts Growing**

If a requested tool starts turning into an app:

* reduce features  
* cut persistence  
* remove accounts  
* collapse multi-step flows  
* return to a single-screen utility model

Prefer a smaller finished tool over a larger fragile one.

---

## **Agent Instructions**

When generating code for this repository:

* default to a single-file static implementation  
* use semantic HTML  
* use simple CSS  
* use plain JavaScript  
* keep logic modular but lightweight  
* avoid unnecessary dependencies  
* avoid backend assumptions  
* keep outputs complete and ready to use  
* prioritize reliability and portability over cleverness

When suggesting features:

* favor broad usefulness  
* favor privacy  
* favor simplicity  
* favor immediate utility

When uncertain:

* choose the simpler implementation  
* choose the more portable structure  
* choose the less stateful design
