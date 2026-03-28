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

## Spacing Rules

- Use modest, even spacing throughout.
- Prefer a small spacing system rather than many custom values.
- Keep section gaps visibly larger than internal control gaps.
- Use generous textarea and section spacing so the tool feels calm rather than cramped.

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

## Shape Rules

- Prefer soft corners over sharp edges.
- Use one small radius for inputs and one slightly larger radius for cards or grouped sections.
- Use fully rounded shapes only for pills, switches, and circular icon buttons.

## Typography Rules

- Use readable, low-friction type.
- Default to simple sans-serif unless a project explicitly needs a display face.
- Tool titles may use a stronger size or weight, but body copy should remain plain and practical.
- Labels should be compact and easy to scan.
- Helper text should stay smaller and quieter than primary labels.

## Motion Rules

- Keep transitions short and subtle.
- Motion should support clarity only.
- Small fade or lift-in transitions are acceptable on initial page load.
- Avoid decorative animation loops.

## Surface Rules

- Use a simple wrapper plus lightweight section cards when grouping controls helps comprehension.
- Cards should rely on spacing, border, and background more than heavy shadow.
- If a shadow is used, it should be very soft.

## Form Control Rules

- Inputs, selects, and textareas should share a consistent base style.
- Use clear borders, readable padding, and strong focus states.
- Textareas should be vertically resizable when practical.
- Focus styling should come from the accent token rather than browser-default blue unless the user requests otherwise.

## Toggle Rules

- Toggle rows should use a simple left label and right switch layout.
- The off state should feel quiet and neutral.
- The on state should increase contrast without relying on loud color.
- The label may appear dimmed when the toggle is off and stronger when enabled.
- Toggle size should stay compact so it does not overpower the form.

## Header Rules

- A tool header may include:
  - a small brand or collection label
  - a clear tool title
  - one short sentence explaining what the tool does

Keep the description limited to requested user-facing guidance only.

Do not add extra badges, reassurance copy, or feature summaries unless explicitly requested.

## Output Area Rules

- Output should look clearly separate from input.
- Preserve whitespace when the output is text-based.
- Prefer a simple card or bordered area over decorative presentation.
- Make long output wrap safely.

## Responsive Rules

- Default to a single-column layout on smaller screens.
- Allow side-by-side control groups only when there is enough width.
- Keep touch targets comfortable even when the visual control is compact.

## Dark Mode Rules

- Light and dark mode should share the same layout and spacing.
- Dark mode should invert contrast thoughtfully rather than simply reversing colors.
- Inputs, cards, and controls need their own dark surfaces and border values.
- Secondary text should remain readable in dark mode without becoming too bright.

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
