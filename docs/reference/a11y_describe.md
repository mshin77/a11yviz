# Generate alt text via a user-supplied LLM backend

Extracts deterministic plot context (chart type, axes, ranges, group
counts) and passes it to the user's `backend` function, which calls any
LLM provider and returns the alt-text string. Result is attached to the
plot via
[`a11y_alt_text()`](https://mshin77.github.io/a11yviz/reference/a11y_alt_text.md)
when `attach = TRUE`.

## Usage

``` r
a11y_describe(p, backend, attach = TRUE)
```

## Arguments

- p:

  A `ggplot` or `plotly` object.

- backend:

  A function `function(context) -> character(1)`. Receives a list with
  fields `chart_type`, `title`, `x`, `y`, `color`, `n_observations`.
  Returns a single string.

- attach:

  If `TRUE` (default), attach via
  [`a11y_alt_text()`](https://mshin77.github.io/a11yviz/reference/a11y_alt_text.md).
  Otherwise return the string.

## Value

The plot with alt text attached, or the string itself.

## Details

The package itself depends on no LLM SDK; the caller supplies the
transport. See examples for OpenAI, Gemini, and Ollama backends.

## Examples

``` r
if (FALSE) { # \dontrun{
  openai_backend <- function(context) {
    prompt <- paste(
      "Write one-sentence WCAG 1.1.1 alt text.",
      "State chart type, axes, and key trend."
    )
    auth <- paste("Bearer", Sys.getenv("OPENAI_API_KEY"))
    res <- httr::POST(
      "https://api.openai.com/v1/chat/completions",
      httr::add_headers(Authorization = auth),
      body = list(
        model = "gpt-4o-mini",
        messages = list(
          list(role = "system", content = prompt),
          list(role = "user",
               content = jsonlite::toJSON(context, auto_unbox = TRUE))
        )
      ),
      encode = "json"
    )
    httr::content(res)$choices[[1]]$message$content
  }
  p |> a11y_describe(backend = openai_backend)
} # }
```
