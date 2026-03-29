# Text Cleaner Implementation Roadmap

This file is the implementation roadmap for `text-cleaner.html`.

The goal is to make the existing single-file tool fully functional without changing its overall structure or turning it into a more complex app.

## Product Goal

Build a browser-only text cleaning and formatting tool that:

- accepts pasted text
- optionally trims and normalizes whitespace
- optionally collapses repeated blank lines
- optionally strips punctuation for cleaner standardized output
- applies a selected text transformation
- updates output immediately
- preserves privacy by doing all processing locally

## Current UI Structure

The current file already includes:

- a theme toggle
- an input textarea with id `input-text`
- an option toggle with id `trim-whitespace`
- an option toggle with id `collapse-blank-lines`
- an option toggle with id `strip-punctuation`
- a transformation dropdown with id `case-mode`
- an output container with id `output-text`

The script already contains placeholder functions. The roadmap below explains how to implement them in a clean order.

## Recommended Build Order

Implement in this order:

1. Finish DOM wiring
2. Finish option reading
3. Finish live update flow
4. Finish whitespace cleanup
5. Finish tokenization
6. Finish case transformations
7. Finish transformation routing
8. Finish initial render and polish

## Phase 1: Wire Up The UI

### 1. Expand `getElements()`

Purpose:
- return every DOM element that the tool needs in one object

Add references for:
- `inputText`
- `trimWhitespace`
- `collapseBlankLines`
- `stripPunctuation`
- `caseMode`
- `outputText`
- existing theme elements

Why first:
- every other UI function will depend on this

Expected shape:

```js
{
  body,
  themeButton,
  themeColorMeta,
  sunIcon,
  moonIcon,
  inputText,
  trimWhitespace,
  collapseBlankLines,
  stripPunctuation,
  caseMode,
  outputText
}
```

### 2. Populate the transformation dropdown in HTML

Purpose:
- make sure the UI exposes all agreed transformation modes

Add these options:
- `No change`
- `Sentence case`
- `Title Case`
- `lowercase`
- `UPPERCASE`
- `camelCase`
- `PascalCase`
- `Spongebob case`

Note:
- this is technically HTML work, but it should be completed before the script is wired to read values

### 3. Implement `getOptions()`

Purpose:
- read the current state of all user controls and return one normalized options object

Read:
- raw input text
- whether trim whitespace is enabled
- whether blank-line collapsing is enabled
- whether punctuation stripping is enabled
- selected transformation mode

Recommended output shape:

```js
{
  input: "...",
  trimWhitespace: true,
  collapseBlankLines: false,
  stripPunctuation: false,
  caseMode: "title"
}
```

Important:
- normalize the selected dropdown value into stable internal values
- do not rely on UI label text later if you can avoid it

Suggested stable mode ids:
- `none`
- `sentence`
- `title`
- `lower`
- `upper`
- `camel`
- `pascal`
- `spongebob`

## Phase 2: Live Update Flow

### 4. Implement `bindEvents()`

Purpose:
- connect the UI to the update pipeline

Add listeners for:
- `input` on the textarea
- `change` on each checkbox
- `change` on the dropdown
- existing theme button click

Each text-related control should call:

```js
updateOutput();
```

### 5. Implement `updateOutput()`

Purpose:
- act as the main controller for the text-cleaning workflow

Steps:
1. call `getOptions()`
2. pass `options.input` and `options` into `cleanText()`
3. write the returned string into `outputText`

Rendering guidance:
- use `textContent`, not `innerHTML`
- if the input is empty, render an empty string rather than placeholder logic in JS

### 6. Update `init()`

Purpose:
- ensure the page starts in a correct state

Steps:
1. run `initializeTheme()`
2. run `bindEvents()`
3. run `updateOutput()` once on load

## Phase 3: Build The Core Cleaning Pipeline

### 7. Implement `cleanText(input, options)`

Purpose:
- define the exact order of all processing steps

Recommended order:
1. normalize line breaks
2. conditionally normalize whitespace
3. conditionally collapse blank lines
4. conditionally strip punctuation
5. apply selected transformation
6. return final output

Suggested flow:

```js
let result = normalizeLineBreaks(input);

if (options.trimWhitespace) {
  result = normalizeWhitespace(result);
}

if (options.collapseBlankLines) {
  result = collapseBlankLines(result);
}

if (options.stripPunctuation) {
  result = stripPunctuation(result);
}

result = applyTransformation(result, options);

return result;
```

Important:
- keep this function orchestration-only
- avoid mixing DOM logic into it

### 8. Implement `normalizeLineBreaks(text)`

Purpose:
- make pasted text consistent before any other step

Rules:
- replace `\r\n` with `\n`
- replace lone `\r` with `\n`

This should be a small pure function.

### 9. Implement `normalizeWhitespace(text)`

Purpose:
- make text cleaner without changing its meaning

Recommended rules:
- trim the full input
- trim each line individually
- collapse repeated spaces and tabs inside each line to a single space
- preserve line breaks

Detailed sequence:
1. trim overall text
2. split on `\n`
3. for each line:
   - trim leading whitespace
   - trim trailing whitespace
   - replace repeated spaces/tabs with one space
4. join lines with `\n`

Decision:
- preserve blank lines unless you explicitly decide later to collapse them

### 10. Implement `collapseBlankLines(text)`

Purpose:
- reduce overly spaced text into a more controlled paragraph rhythm

Recommended rule:
- allow at most one empty line between content lines

Behavior example:

```text
Line one



Line two
```

becomes:

```text
Line one

Line two
```

Recommended approach:
1. split into lines
2. scan line by line
3. keep track of whether the previous kept line was blank
4. skip extra blank lines after the first blank

Important:
- this should preserve single intentional paragraph breaks
- do not leave a trailing blank line after the final content line

### 11. Implement `stripPunctuation(text)`

Purpose:
- remove punctuation characters that make standardized output noisy or unsafe,
  especially for identifier-style and filename-style use

Recommended default behavior:
- remove punctuation except separators you intentionally support

Keep:
- spaces
- tabs
- line breaks
- dashes
- underscores
- commas
- letters
- numbers

Remove:
- periods
- slashes
- quotes
- parentheses
- colons
- semicolons
- exclamation marks
- question marks
- ampersands
- other non-alphanumeric punctuation

Important decision:
- because this tool treats dashes, underscores, commas, and line breaks as
  meaningful separators, those should not be removed by this toggle

Recommended approach:
1. scan character by character
2. keep letters and numbers
3. keep approved separator characters
4. remove everything else

Note:
- if you later want a stricter filename mode, that can become a separate toggle

## Phase 4: Tokenization

This phase is important because your transformation rules depend on separators being treated as meaningful boundaries.

### 12. Implement `isSeparator(token)`

Purpose:
- identify whether a token is a separator token

Separators should include:
- spaces
- tabs
- dashes
- underscores
- commas
- line breaks

Practical note:
- if you tokenize into objects instead of strings, this helper may become less necessary
- if you keep string tokens, it becomes useful

### 13. Implement `tokenizeText(text)`

Purpose:
- split text into words and separators while preserving original separators

Why this matters:
- `Title Case` must preserve original separators
- `camelCase` and `PascalCase` must remove them
- `Spongebob case` must ignore them when alternating letters

Recommended token model:

```js
[
  { type: "word", value: "hello" },
  { type: "separator", value: "_" },
  { type: "word", value: "world" }
]
```

Recommended separator pattern:
- spaces
- tabs
- newline
- `-`
- `_`
- `,`

Recommended approach:
1. scan the string from left to right
2. accumulate characters into either:
   - a word token
   - a separator token
3. preserve separator characters exactly as they appear

Alternative approach:
- use regex splitting with capture groups
- if you do this, make sure separators are not lost

## Phase 5: Shared Word Helpers

### 14. Implement `normalizeWord(word)`

Purpose:
- create a predictable baseline for identifier and title transformations

Rule:
- lowercase the whole word

This helper should stay very small.

### 15. Implement `capitalizeWord(word)`

Purpose:
- capitalize a single word consistently

Rule:
- lowercase the whole word first
- uppercase only the first character
- keep the rest lowercase

Examples:
- `hello` -> `Hello`
- `HELLO` -> `Hello`
- `hELLo` -> `Hello`

Question to settle during coding:
- how should this behave for number-leading words like `v2` or `123abc`

Practical recommendation:
- leave number-leading words mostly unchanged except for lowercasing the alphabetic part naturally through the lowercase-first step

## Phase 6: Implement Transformations

### 16. Implement `applyTransformation(text, options)`

Purpose:
- central routing layer for transformation modes

Use a switch or lookup map keyed by `options.caseMode`.

Suggested routing:

```js
switch (options.caseMode) {
  case "sentence":
  case "title":
  case "lower":
  case "upper":
  case "camel":
  case "pascal":
  case "spongebob":
  default:
}
```

Important:
- keep this only as a dispatcher
- do not place transformation logic directly inside the switch

### 17. Implement lowercase and uppercase behavior

Purpose:
- support the simplest transformations first

Implementation options:
- either create dedicated helpers later
- or handle these directly in `applyTransformation()`

Behavior:
- `lower`: `text.toLowerCase()`
- `upper`: `text.toUpperCase()`

### 18. Implement `toTitleCase(text)`

Purpose:
- capitalize each word while preserving original separators

Rules:
- tokenize the text
- for each word token:
  - replace with `capitalizeWord(token.value)`
- for each separator token:
  - keep as-is
- join all token values together

Examples:
- `hello_world-test` -> `Hello_World-Test`
- `customer,first_name` -> `Customer,First_Name`
- `multi line text` -> `Multi Line Text`

### 19. Implement `toCamelCase(text)`

Purpose:
- convert separated text into `camelCase`

Rules:
- tokenize text
- keep only word tokens
- lowercase each word
- first word stays lowercase
- capitalize each following word
- join with no separators

Examples:
- `hello_world-test` -> `helloWorldTest`
- `customer,first_name` -> `customerFirstName`
- `multi line text` -> `multiLineText`

Important:
- line breaks count as separators
- punctuation separators are removed in final output
- process each line independently and preserve line breaks in the final output

Bulk example:
- `first_file-name\nsecond/file.txt` -> `firstFileName\nsecondFileTxt`

### 20. Implement `toPascalCase(text)`

Purpose:
- convert separated text into `PascalCase`

Rules:
- tokenize text
- keep only word tokens
- capitalize every word
- join with no separators

Examples:
- `hello_world-test` -> `HelloWorldTest`
- `multi line text` -> `MultiLineText`

Important:
- process each line independently and preserve line breaks in the final output

Bulk example:
- `first_file-name\nsecond/file.txt` -> `FirstFileName\nSecondFileTxt`

### 21. Implement `toSpongebobCase(text)`

Purpose:
- alternate casing across letters only

Rules:
- preserve all original characters
- alternate only when the current character is a letter
- do not let spaces, punctuation, underscores, dashes, commas, or line breaks advance the alternation pattern
- reset the alternating pattern after each line break so each new line starts from lowercase again

Recommended approach:
1. keep a boolean flag like `shouldUppercase`
2. loop through each character
3. if character is a letter:
   - apply upper/lower based on the flag
   - flip the flag
4. if character is not a letter:
   - append unchanged

Example:
- `hello_world-test` -> `hElLo_wOrLd-TeSt`

Bulk example:
- `first_line\nsecond_line` -> `fIrSt_lInE\nsEcOnD_lInE`

### 22. Implement `toSentenceCase(text)`

Purpose:
- create readable sentence-like text without destroying useful structure

This is the most ambiguous transformation, so define it clearly before coding.

Recommended behavior for this tool:
- lowercase the text first
- capitalize:
  - the first letter of the whole text
  - the first letter after sentence-ending punctuation like `.`, `!`, `?`
  - the first letter after a line break
- preserve separators in place

Recommended implementation approach:
1. lowercase the full string
2. scan left to right
3. track whether the next letter should be capitalized
4. initialize that flag as `true`
5. set it back to `true` after:
   - `.`
   - `!`
   - `?`
   - `\n`

Important:
- do not capitalize after every dash, underscore, or comma
- those are separators for tokenization but not sentence boundaries

## Phase 7: Optional Clipboard Support

### 23. Implement `copyOutput()`

Purpose:
- support output copying if you later add a copy button

Recommended behavior:
- read the current output text
- if empty, do nothing
- otherwise write to `navigator.clipboard.writeText(...)`

This function can remain unused until a copy button is added.

## Phase 8: Final Wiring Checks

### 24. Verify the theme functions still work

Functions involved:
- `getPreferredTheme()`
- `applyTheme(theme)`
- `toggleTheme()`
- `initializeTheme()`

Check:
- icon swap works
- theme color meta updates
- page class changes correctly

### 25. Run manual behavior checks

Test with these inputs:

#### Whitespace cleanup

Input:

```text
  hello   world
  test    line
```

Expected with trim enabled:

```text
hello world
test line
```

#### Title case with preserved separators

Input:

```text
hello_world-test,again
```

Expected:

```text
Hello_World-Test,Again
```

#### camelCase

Input:

```text
hello_world-test
```

Expected:

```text
helloWorldTest
```

#### PascalCase

Input:

```text
hello_world-test
```

Expected:

```text
HelloWorldTest
```

#### Spongebob case

Input:

```text
hello_world-test
```

Expected:

```text
hElLo_wOrLd-TeSt
```

#### Sentence case

Input:

```text
hello world. this is a test
next line here
```

Expected:

```text
Hello world. This is a test
Next line here
```

## Suggested Near-Term HTML Improvements

These are not required for the functions to work, but they will help:

### Add explicit `value` attributes to each `<option>`

Example:

```html
<option value="none">No change</option>
<option value="title">Title Case</option>
```

This makes `getOptions()` simpler and more reliable.

### Keep the current toggle set focused

Recommended v1 toggles:
- trim whitespace
- collapse blank lines
- strip punctuation

Avoid adding more for now unless they materially improve output quality.

## Function Dependency Map

Use this map to keep implementation clean:

- `init()`
  - `initializeTheme()`
  - `bindEvents()`
  - `updateOutput()`

- `bindEvents()`
  - `toggleTheme()`
  - `updateOutput()`

- `updateOutput()`
  - `getOptions()`
  - `cleanText()`

- `cleanText()`
  - `normalizeLineBreaks()`
  - `normalizeWhitespace()`
  - `collapseBlankLines()`
  - `stripPunctuation()`
  - `applyTransformation()`

- `applyTransformation()`
  - `toSentenceCase()`
  - `toTitleCase()`
  - `toCamelCase()`
  - `toPascalCase()`
  - `toSpongebobCase()`

- `toTitleCase()`
  - `tokenizeText()`
  - `capitalizeWord()`

- `toCamelCase()`
  - `tokenizeText()`
  - `normalizeWord()`
  - `capitalizeWord()`

- `toPascalCase()`
  - `tokenizeText()`
  - `capitalizeWord()`

- `tokenizeText()`
  - optional use of `isSeparator()`

## Simplest Good First Milestone

If you want to build this in small passes, use this milestone order:

1. make `No change`, `lowercase`, and `UPPERCASE` work
2. make trim whitespace work
3. make blank-line collapsing work
4. make punctuation stripping work
5. make `Title Case` work with preserved separators
6. make `camelCase` and `PascalCase` work
7. make `Spongebob case` work
8. finish `Sentence case`

This gives you visible progress quickly while still building toward the full tool.
