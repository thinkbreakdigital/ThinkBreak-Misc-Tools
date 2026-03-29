# Front-End Styling Spec

This spec captures the reusable front-end styling patterns from the current tool styling and turns them into shared rules for future browser-based utility tools.

It intentionally excludes project-specific copy, tool-specific class names, and one-off content decisions.

## Goals

- keep tools visually clean and lightweight
- support light and dark mode consistently
- make controls easy to scan and use
- keep the styling easy to copy into a single-file project
- preserve enough structure that future tools feel related without feeling templated

## Layout Rules

- Use a centered single-column wrapper for most tools.
- Keep the content width moderate.
- Use vertical spacing between major sections instead of dense borders or nested panels.
- Reserve fixed positioning for small global controls only, such as theme toggles.
- Mobile and desktop should use the same structure, with only spacing and column layout adjusting responsively.

Default layout values:

- Wrapper max width: `760px`
- Wrapper horizontal margin: `0 auto`
- Wrapper desktop padding: `52px 20px 80px`
- Wrapper mobile padding: `44px 16px 64px`
- Major section gap: `20px`
- Internal control gap: `12px`
- Related grouped control gap: `16px`
- Header bottom margin: `36px`
- Header right padding when a fixed theme button is present: `56px`
- Theme button position: `top/right: calc(14px + env(safe-area-inset-*))`
- Theme button size: `44px` by `44px`

## Spacing Rules

- Use modest, even spacing throughout.
- Prefer a small spacing system rather than many custom values.
- Keep section gaps visibly larger than internal control gaps.
- Use generous textarea and section spacing so the tool feels calm rather than cramped.

Default spacing scale:

- `8px` for tight label spacing
- `10px` for section-label bottom spacing
- `12px` for field stack gaps
- `14px` for output card padding in larger text outputs
- `16px` for control card padding and grouped option gaps
- `20px` for major layout gaps
- `36px` for header-to-tool separation
- `52px` top page breathing room on desktop
- `80px` bottom page breathing room on desktop

## Color System

Use CSS variables for the core theme tokens:

- `--bg`
- `--surface`
- `--surface2`
- `--border`
- `--border-hover`
- `--text`
- `--text-mid`
- `--text-dim`
- `--accent`
- `--accent-dim`

Guidelines:

- Backgrounds should stay neutral and quiet.
- Surfaces should be slightly separated from the page background.
- Borders should be subtle, not dominant.
- Accent color should be used sparingly for focus or active states.
- Disabled or secondary labels should use the dim text token.
- In dark mode, override text tokens at the theme level instead of hard-coding text colors per element.

Default light theme values:

- `--bg: #fafaf7`
- `--surface: #ffffff`
- `--surface2: #f3f2ee`
- `--border: #e4e2dc`
- `--border-hover: #cccac2`
- `--text: #1a1a18`
- `--text-mid: #5c5b56` for quieter body text
- `--text-dim: #9c9a94` for labels, placeholders, and disabled-style supporting text
- `--accent: #2d2e5a`
- `--accent-dim: #e8f0eb`

Default dark theme values:

- Page background: `#111110`
- Standard dark control/card surface: `#252522`
- Secondary dark button/theme surface: `#1c1c1a`
- Standard dark border: `#2e2e2b`
- Hover border on dark theme button: `#3d3d39`
- Hover surface for dark buttons: `#30302c`
- Active dark button surface: `#1a1a18`
- Active dark button border: `#232320`
- Disabled dark button surface: `#1c1c1a`
- Disabled dark button border: `#2a2a27`
- Dark text token: `#969696`
- Dark secondary/dim text token: `#7b7b7b`
- Dark disabled button text: `#5f5f5a`
- Dark focus border override for form controls: `#4d4e94`

## Shape Rules

- Prefer soft corners over sharp edges.
- Use one small radius for inputs and one slightly larger radius for cards or grouped sections.
- Use fully rounded shapes only for pills, switches, and circular icon buttons.

Default shape values:

- Small radius: `8px`
- Card/group radius: `12px`
- Circular controls: `50%`
- Toggle track radius: `999px`

## Typography Rules

- Use readable, low-friction type.
- Default to simple sans-serif unless a project explicitly needs a display face.
- Tool titles may use a stronger size or weight, but body copy should remain plain and practical.
- Labels should be compact and easy to scan.
- Helper text should stay smaller and quieter than primary labels.

Default typography values:

- Base family: `sans-serif`
- Title size: `clamp(28px, 6vw, 38px)`
- Title weight: `700`
- Title line height: `1.08`
- Title letter spacing: `-0.03em`
- Body/help/subtext size: `14px`
- Body/help line height: `1.5` to `1.7`
- Section label size: `10px`
- Section label weight: `700`
- Section label letter spacing: `0.12em`
- Toggle/button label weight: `600`
- Helper text size: `12px`

## Motion Rules

- Keep transitions short and subtle.
- Motion should support clarity only.
- Small fade or lift-in transitions are acceptable on initial page load.
- Avoid decorative animation loops.

Default motion values:

- Page intro animation: `fadeUp 0.4s ease-out both`
- Theme button transition: `0.2s ease`
- Inputs/selects/textareas transition: `0.15s ease`
- Toggle transition: `0.18s ease`
- Button pressed scale: `0.985`
- Button transform transition: `0.08s ease`

## Surface Rules

- Use a simple wrapper plus lightweight section cards when grouping controls helps comprehension.
- Cards should rely on spacing, border, and background more than heavy shadow.
- If a shadow is used, it should be very soft.

Default surface values:

- Shared soft shadow: `0 10px 30px rgba(26, 26, 24, 0.04)`
- Control/card border: `1px solid var(--border)`
- Control card padding: `16px`
- Output card padding for large text output: `14px 16px`

## Form Control Rules

- Inputs, selects, and textareas should share a consistent base style.
- Use clear borders, readable padding, and strong focus states.
- Textareas should be vertically resizable when practical.
- Focus styling should come from the accent token rather than browser-default blue unless the user requests otherwise.
- If dark mode needs a different focus border than the light theme accent, define that as an intentional dark-theme override and apply it consistently to all form controls.

Default form control values:

- Minimum height: `44px`
- Padding: `10px 12px`
- Border: `1px solid var(--border)`
- Radius: `var(--radius-sm)` / `8px`
- Background: `var(--surface2)`
- Text color: `var(--text)`
- Focus border color: `var(--accent)`
- Textarea minimum height for large text tools: `240px`
- Textarea resize mode: `vertical`
- Textarea line height: `1.7`
- Placeholder color: `var(--text-dim)`

## Button Rules

- Buttons should share the same base styling across tools when they represent a primary utility action such as copy, clear, or generate.
- Prefer a reusable `.copy-button` pattern unless the tool needs a broader generic button class.
- Match the form control height baseline with a minimum height of `44px`.
- Use `12px 16px` padding, the small shared radius, a subtle border, the surface background, and inherited font styles.
- Buttons should use a medium-strong weight so the label reads clearly without feeling heavy.
- Include short transitions for border color, background, color, transform, and shadow.
- Use the same soft shadow style as cards and theme controls so the button feels related to the rest of the tool.

Default button values:

- Class name: `.copy-button` unless a broader shared button class is introduced
- Minimum height: `44px`
- Padding: `12px 16px`
- Border: `1px solid var(--border)`
- Radius: `var(--radius-sm)` / `8px`
- Background: `var(--surface)`
- Text color: `var(--text)`
- Font weight: `600`
- Shadow: `0 10px 30px rgba(26, 26, 24, 0.04)`

Light mode interaction states:

- Default state should use `var(--surface)` with `var(--border)` and `var(--text)`.
- Hover and focus-visible should shift to a slightly darker quiet surface such as `#f3f2ee` and use `var(--border-hover)`.
- Active should return to a brighter surface, tighten the border slightly, and use a subtle pressed scale like `transform: scale(0.985)`.
- Focus-visible should remove the default outline only if the replacement styling remains clear.

Disabled state:

- Disabled buttons should keep full opacity and signal inactivity through muted background, border, and text colors instead of transparency.
- Disabled buttons should remove transform and shadow feedback and use `cursor: not-allowed`.
- For this shared pattern, use the same disabled palette already established in the current tools so future buttons stay visually aligned.

Default disabled button values:

- Background: `#eceae4`
- Text color: `#9c9a94`
- Border color: `#dad7cf`
- Opacity: `1`

Dark mode button rules:

- Dark mode buttons should use the same dedicated dark surface and border treatment as other controls rather than reusing light values.
- Hover and focus-visible should lighten the dark surface slightly and strengthen the border contrast.
- Active should darken again and preserve the same pressed scale behavior.
- Disabled dark mode buttons should use a dimmer surface, border, and label color while remaining fully readable.

Default dark mode button values:

- Default background: `#252522`
- Default border color: `#2e2e2b`
- Hover/focus background: `#30302c`
- Hover/focus border color: `#4a4a45`
- Active background: `#1a1a18`
- Active border color: `#232320`
- Disabled background: `#1c1c1a`
- Disabled text color: `#5f5f5a`
- Disabled border color: `#2a2a27`

## Toggle Rules

- Toggle rows should use a simple left label and right switch layout.
- The off state should feel quiet and neutral.
- The on state should increase contrast without relying on loud color.
- The label may appear dimmed when the toggle is off and stronger when enabled.
- Toggle size should stay compact so it does not overpower the form.

Default toggle values:

- Row layout: `display: flex`, `align-items: center`, `justify-content: space-between`
- Row gap: `16px`
- Label size: `12px`
- Label weight: `600`
- Switch width: `38px`
- Switch height: `22px`
- Thumb size: `18px`
- Thumb offset: `2px`
- Checked thumb travel: `16px`
- Light track background: `#d9d7cf`
- Light track border: `#cfccc4`
- Checked light track: `#1f211e`
- Dark track background: `#2b2b28`
- Dark track border: `#3a3a35`
- Checked dark track: `#f0efe8`

Use this HTML structure pattern when you want a toggle that matches the current tools:

- Replace the `for=""` value with the specific checkbox id for that toggle.
- Replace the `.toggle-label` text with the user-facing label for that toggle.
- Keep the class names and element order the same so the CSS continues to work exactly.

```html
<label class="toggle-row" for="your-toggle-id">
  <span class="toggle-label">Your toggle label</span>
  <span class="toggle-switch">
    <input id="your-toggle-id" type="checkbox">
    <span class="toggle-track" aria-hidden="true"></span>
    <span class="toggle-thumb" aria-hidden="true"></span>
  </span>
</label>
```

Use this exact CSS when a future tool should match the current toggle switch styling exactly:

```css
.toggle-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
}

.toggle-label {
  font-size: 12px;
  font-weight: 600;
  color: var(--text-dim);
  transition: color 0.18s ease;
}

.toggle-switch {
  position: relative;
  display: inline-flex;
  align-items: center;
  width: 38px;
  height: 18px;
  flex: 0 0 auto;
}

.toggle-switch input {
  position: absolute;
  inset: 0;
  opacity: 0;
  cursor: pointer;
  margin: 0;
}

.toggle-track {
  width: 38px;
  height: 18px;
  border-radius: 999px;
  background: #d9d7cf;
  border: 1px solid #cfccc4;
  transition: background 0.18s ease, border-color 0.18s ease;
}

.toggle-thumb {
  position: absolute;
  top: 2px;
  left: 2px;
  width: 20px;
  height: 14px;
  border-radius: 999px;
  background: #ffffff;
  border: 1px solid rgba(0, 0, 0, 0.08);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.16);
  transition: transform 0.18s ease;
  pointer-events: none;
}

.toggle-switch input:checked + .toggle-track {
  background: #1f211e;
  border-color: #1f211e;
}

.toggle-switch input:checked + .toggle-track + .toggle-thumb {
  transform: translateX(14px);
}

.toggle-switch input:focus-visible + .toggle-track {
  outline: 2px solid var(--accent);
  outline-offset: 2px;
}

body.dark .toggle-label {
  color: var(--text);
}

body.dark .toggle-track {
  background: #2b2b28;
  border-color: #3a3a35;
}

body.dark .toggle-thumb {
  background: #f0efe8;
  border-color: rgba(255, 255, 255, 0.08);
}

body.dark .toggle-switch input:checked + .toggle-track {
  background: #f0efe8;
  border-color: #f0efe8;
}

body.dark .toggle-switch input:checked + .toggle-track + .toggle-thumb {
  background: #111110;
  border-color: rgba(17, 17, 16, 0.16);
}

body.dark .toggle-row:has(input:checked) .toggle-label {
  color: var(--text);
}

.toggle-row:has(input:checked) .toggle-label {
  color: var(--text);
}
```

## Header Rules

- A tool header may include:
  - a small brand or collection label
  - a clear tool title
  - one short sentence explaining what the tool does

Keep the description limited to requested user-facing guidance only.

Do not add extra badges, reassurance copy, or feature summaries unless explicitly requested.

Default header values:

- Brand/collection label bottom margin: `8px`
- Title bottom margin: `8px`
- Supporting description max width: `58ch`

## Output Area Rules

- Output should look clearly separate from input.
- Preserve whitespace when the output is text-based.
- Prefer a simple card or bordered area over decorative presentation.
- Make long output wrap safely.

Default output values:

- Border: `1px solid var(--border)`
- Radius: `var(--radius)` / `12px`
- Background: `var(--surface)`
- Shadow: `0 10px 30px rgba(26, 26, 24, 0.04)`
- Preserve whitespace with `white-space: pre-wrap` for text outputs
- Use `word-break: break-word` for long strings

## Responsive Rules

- Default to a single-column layout on smaller screens.
- Allow side-by-side control groups only when there is enough width.
- Keep touch targets comfortable even when the visual control is compact.

## Dark Mode Rules

- Light and dark mode should share the same layout and spacing.
- Dark mode should invert contrast thoughtfully rather than simply reversing colors.
- Inputs, cards, and controls need their own dark surfaces and border values.
- Secondary text should remain readable in dark mode without becoming too bright.
- Prefer softer gray text in dark mode over bright near-white defaults when the UI should feel quieter and less harsh.
- Set dark-mode text, helper text, and placeholder text through the shared text tokens so titles, labels, and form controls stay in sync.

## Reusable Class Pattern Guidance

Prefer generic structural names that can carry across tools:

- `.wrap`
- `.tool-header`
- `.tool-label`
- `.tool-title`
- `.tool-sub`
- `.field-stack`
- `.controls-row`
- `.control-group`
- `.option-list`
- `.toggle-row`
- `.toggle-label`
- `.output-card`
- `.copy-button`

Avoid tying reusable styling rules to tool-specific names unless branding is intentional for that project.

## Copy Rules For Styled UI

- Labels should say what the control changes.
- Helper text should explain use, not policy.
- On-page copy should not repeat repository-level rules unless the user asks for it.
- Keep descriptions to one sentence unless the tool genuinely needs more.

## Implementation Notes

- Keep the styling compatible with a single-file `index.html`.
- Prefer CSS variables over duplicated hard-coded values.
- Avoid dependencies for layout, theming, or component styling.
- Build reusable primitives first, then layer tool-specific adjustments on top.
