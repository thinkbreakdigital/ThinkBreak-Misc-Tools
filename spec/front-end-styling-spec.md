# Front-End Styling Spec

This spec defines the shared front-end shell used by browser-only tools in this repository.

The source of truth for that shell is now:

- `Components/base-tool-template.html`

This spec should describe that template directly rather than older styling patterns that no longer exist.

It covers:

- the global page shell
- light and dark theme tokens
- the striped gradient background
- header placement
- shared card styling
- the compact two-option switch
- the segmented three-option toggle
- the minimal JavaScript that should stay in the base template

It does not define tool-specific calculators, graphs, dashboards, or output layouts.

---

## Goals

- keep every tool visually related without forcing identical internals
- preserve a lightweight single-file-friendly base
- centralize theme and background behavior in one reusable template
- make future tools start from a known shell instead of ad hoc layout work
- keep the base template small enough that tool-specific logic can be added cleanly

---

## Base Template Scope

`Components/base-tool-template.html` should provide only the reusable parts of a tool.

That means the template should include:

- global color tokens
- global layout tokens
- the theme toggle button
- the gradient background shell
- the shared page wrapper
- the title, description, and author header placement
- one example primary card
- one compact two-option toggle example
- one segmented three-option toggle example
- only the JavaScript needed for theme switching, gradient rendering, resize handling, and generic toggle active-state behavior

That means the template should not include:

- tool-specific calculations
- validation logic tied to one tool
- chart logic
- output formatting logic
- tool-specific IDs or copy beyond placeholder/example content
- extra sections that exist only to demonstrate one particular tool

---

## Required HTML Structure

The base template should keep this overall structure:

1. theme button
2. page shell
3. gradient stage
4. centered main wrapper
5. shared tool header
6. one example primary card

The reusable shell should use these core structural pieces:

- `#theme-btn`
- `.page-shell`
- `.gradient-stage`
- `#stripe-background`
- `.wrap`
- `.tool-header`
- `.header-row`
- `.tool-shell`
- `.panel-card`
- `.primary-card`

The example content inside the primary card should stay generic and replaceable.

---

## Global Token System

The base template should define all core theme tokens in `:root` and override only the shared tokens in `body.dark`.

### Required shared tokens

- `--bg`
- `--surface`
- `--surface2`
- `--surface3`
- `--border`
- `--border-hover`
- `--border-strong`
- `--text`
- `--text-mid`
- `--text-dim`
- `--text-strong`
- `--accent`
- `--accent-strong`
- `--accent-dim`
- `--accent-alt`
- `--accent-alt-soft`
- `--success`
- `--success-soft`
- `--danger`
- `--danger-soft`
- `--header-text`
- `--header-row-1`
- `--header-row-2`
- `--header-row-3`
- `--stripe-total-height`
- `--gradient-anchor-1`
- `--gradient-anchor-2`
- `--gradient-anchor-3`
- `--gradient-anchor-4`
- `--gradient-anchor-stop-1`
- `--gradient-anchor-stop-2`
- `--gradient-anchor-stop-3`
- `--gradient-anchor-stop-4`
- `--stripe-count`
- `--stripe-tail-start-height`
- `--stripe-tail-end-height`
- `--theme-color-light`
- `--theme-color-dark`
- `--radius`
- `--shadow-soft`

### Token rules

- Core colors should remain token-driven.
- Tokens should be defined as `rgba(...)` values where the template expects to parse or interpolate them in JavaScript.
- Tool-specific files may add new tokens, but should not remove the base token set without a documented reason.
- Dark mode should be implemented by overriding shared tokens in `body.dark`.
- Avoid repeating the same dark colors in many selectors when the token layer can handle the change once.

---

## Layout Rules

The base layout should remain a centered single-column shell with a full-width visual background layer behind it.

### Default layout values

- Wrapper max width: `760px`
- Wrapper horizontal margin: `0 auto`
- Wrapper desktop padding: `0 20px 80px`
- Wrapper mobile padding: `0 16px 64px`
- Major section gap: `20px`
- Header bottom margin: `36px`
- Header right padding when the theme button is present: `56px`
- Theme button position: `top/right: calc(14px + env(safe-area-inset-*))`
- Theme button size: `44px`

### Layout rules

- The gradient layer should span the viewport width, not the content width.
- The main content should sit above the gradient layer.
- The layout should stay structurally identical in light and dark mode.
- Mobile changes should be limited to spacing and stacked flow, not a different page architecture.

---

## Gradient Background Rules

The striped gradient background is part of the shared base template and should be treated as reusable shell behavior, not tool-specific decoration.

### Purpose

- give tools a recognizable shared identity
- visually anchor the header
- remain passive and non-interactive

### Required behavior

- The gradient should live in `.gradient-stage`.
- The stripe container should be `#stripe-background`.
- Stripe colors should be derived from the four gradient anchor tokens and interpolated in JavaScript.
- Stripe heights should be derived from the shared header row heights plus the shared stripe tail values.
- Stripe nodes should be rendered once and reused.
- Resize should update stripe values rather than recreating full markup unless the stripe count changes.

### Required CSS responsibilities

- `.gradient-stage` handles positioning and clipping.
- `.gradient-stripe` reads `--stripe-height` and `--stripe-color`.
- Visual values should live in CSS variables when practical.

### Required JavaScript responsibilities

- read token values
- calculate stripe heights
- calculate interpolated stripe colors
- create stripe nodes when needed
- update stripe custom properties

---

## Theme Toggle Rules

The theme toggle is part of the base template and should remain available to future tools by default.

### Required behavior

- The page should default to system preference through `prefers-color-scheme`.
- Clicking the theme button should toggle between light and dark mode for the current page session.
- The `meta[name="theme-color"]` value should update when the theme changes.
- The moon and sun icons should be switched through CSS tied to `body.dark`.

### Required styling

- The button stays circular.
- The button uses shared surface, border, text, and shadow tokens.
- Hover and focus-visible use the shared border-hover token.

---

## Header Rules

The shared header exists to place the tool title, one-sentence description, and author/brand in a consistent location relative to the gradient.

### Required header structure

- first row: title
- second row: description
- third row: author or brand label

### Required classes

- `.tool-header`
- `.header-row`
- `.tool-title`
- `.tool-sub`
- `.brand-label`

### Header rules

- The title should be visually prominent.
- The description should stay short and plain-language.
- The author/brand label should be visually smaller and quieter than the title.
- The header rows should be driven by the shared header height tokens so the gradient alignment remains predictable.

---

## Shared Surface Rules

The base template should expose a simple reusable card surface for future tools.

### Required classes

- `.tool-shell`
- `.panel-card`
- `.primary-card`
- `.primary-main`
- `.primary-copy`
- `.section-label`
- `.section-title`
- `.section-sub`

### Surface rules

- Cards should rely on token-driven borders, backgrounds, and shadows.
- Cards should remain visually quiet.
- Spacing should do more work than decoration.
- A single example primary card should be included in the base template to demonstrate placement and rhythm.

---

## Compact Two-Option Toggle Rules

The base template should include a compact inline binary switch identical to the current calculator pattern.

### Purpose

- support tight two-state choices without a full segmented bar
- keep the control visually small
- allow text labels on both sides of the switch

### Required classes

- `.toggle-inline`
- `.toggle-inline-label`
- `.toggle-inline-switch`
- `.toggle-inline-track`
- `.toggle-inline-thumb`

### Required behavior

- The left and right labels should visually reflect the active side.
- The switch should use a checkbox internally.
- The thumb should move with a short transform transition.
- The base template should include one placeholder example using `Option 1` and `Option 2`.

### Required default values

- Track width: `38px`
- Track height: `18px`
- Thumb width: `20px`
- Thumb height: `14px`
- Thumb offset: `2px`
- Thumb travel: `14px`
- Label size: `12px`
- Label weight: `600`

---

## Segmented Three-Option Toggle Rules

The base template should include a reusable segmented control for three-way choices.

### Purpose

- support compact multi-option switches in a generic form
- give future tools a ready-made pattern for period selectors or mode switches

### Required classes

- `.segmented-control`
- `.segmented-control-button`

### Required behavior

- The template should include one placeholder three-option example using `Option 1`, `Option 2`, and `Option 3`.
- One option should start active by default.
- Clicking an option should move the active state to that option.
- The segmented control should work without tool-specific logic.

### Required layout

- The control should support a data-driven option count.
- The current base template must support both `data-option-count="2"` and `data-option-count="3"`.
- The three-option example should remain in the template even if some future tools do not use it.

---

## Typography Rules

- Base family: `sans-serif`
- Title size: `clamp(28px, 5vw, 42px)`
- Title weight: `700`
- Title line height: `1.08`
- Title letter spacing: `-0.03em`
- Description size: `14px`
- Description line height: `1.6`
- Section label size: `10px`
- Section label weight: `700`
- Section label letter spacing: `0.12em`
- Control label size: `12px`
- Control label weight: `600`

Typography should stay direct, readable, and low-friction.

---

## Motion Rules

- Page intro animation: `fadeUp 0.4s ease-out both`
- Theme button transition: `0.2s ease`
- Compact switch transition: `0.18s ease`
- Segmented control transition: `0.15s ease`

Motion should stay subtle and functional.

Avoid decorative looping motion in the shared template.

---

## Responsive Rules

At mobile widths:

- reduce wrapper padding
- remove extra header right padding
- keep the same overall header and card structure
- preserve comfortable touch targets

The base template should not introduce a second mobile-only layout system.

---

## Base JavaScript Scope

Only the JavaScript needed for shared page behavior should live in the base template.

### Functions that belong in the base template

- `clamp`
- `interpolateNumber`
- `parseColor`
- `interpolateColor`
- `formatRgba`
- `getTokenValue`
- `getNumberToken`
- `getStripeCount`
- `getStripeAnchors`
- `getStripeAnchorStops`
- `getHeaderStripeHeights`
- `buildStripeHeights`
- `getStripeColor`
- `ensureStripeNodes`
- `renderStripeBackground`
- `getPreferredTheme`
- `applyTheme`
- `toggleTheme`
- `queueStripeRender`
- `activateSegmentedControl`
- `renderBinaryToggleLabels`
- `bindEvents`
- `getElements`
- `init`

### Functions that do not belong in the base template

- tool-specific validation
- tool-specific calculations
- output formatting tied to one tool
- chart rendering for one tool
- view routing for one tool
- anything that depends on tool-specific IDs beyond the template’s own example controls

---

## Extension Rules For Future Tools

When creating a new tool from the base template:

1. keep the shared theme shell and gradient behavior
2. replace the placeholder title, description, and brand text
3. replace the example primary card content with tool-specific content
4. remove any example toggle that the tool does not use
5. add only the tool-specific CSS and JS that the new tool actually needs

Future tools may rename or remove placeholder example IDs and copy, but the shared shell classes should stay stable when practical.

---

## Copy Rules

- Title: clear, direct, tool-specific
- Description: one sentence
- Brand/author row: short label only
- Example labels in the base template should remain placeholder-oriented
- Do not add policy, privacy, or marketing copy to the template body unless requested

---

## Implementation Notes

- The template must stay compatible with a single-file HTML deliverable.
- Styling should remain token-driven.
- Theme and gradient behavior should not require external libraries.
- Reusable shell classes should be generic rather than tool-branded.
- When a shared token or shell rule changes in `Components/base-tool-template.html`, this spec should be updated to match it.
