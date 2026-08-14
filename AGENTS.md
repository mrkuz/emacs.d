# AGENTS.md

## Coding conventions

- **Naming:** `my//` for internal variables and functions, `my/` for commands.
- **One-line docstring** on every function, internal helpers included.
- **Comment settings with *why*,** unless self-evident. Keep comments short: they
  are read by an experienced Emacs user, so don't explain standard Emacs behavior,
  and leave out examples the explanation already covers.
- **`use-package` is for external packages only.** Configure built-ins with plain
  `setq`/`defun`/hooks.
- **Prefer `:custom` over `:config` over `:init`.**
- **`setq` for settings, `setopt` only when the option has a `:set` setter**, which
  `setq` skips — check with `(get 'var 'custom-set)`. The setter has to be known at
  that point, so `setopt` still needs the library loaded.
- **Prefer `:hook` over `add-hook`**, with two caveats: it defers the package, so
  add `:demand t` when it must load at startup; and it only works for variables
  ending in `-hook`, since use-package appends that suffix — abnormal hooks like
  `gptel-post-response-functions` silently become `…-functions-hook` and never fire.
- **Override faces with `custom-set-faces`.** It sets the user spec, which outranks
  themes; `set-face-attribute` and `:custom-face` both lose to them. Use
  `set-face-attribute` plus `enable-theme-functions` only for values computed from
  the live theme, like the mode-line box reading the current background.
