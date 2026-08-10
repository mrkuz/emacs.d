# AGENTS.md

## Coding conventions

- **Naming:** private (internal) variables and functions are prefixed `my//`; public
  ones are prefixed `my/`. Example: `my//load-module` and `my//gptel-process-prompt`
  are internal helpers; `my/gptel-chat` and `my/elpaca-update` are commands meant to
  be invoked directly.
- **Every function** carries a one-line docstring describing what it does, e.g.
  `"Open gptel chat"`, `"Update Elpaca packages"`, `"Load module by name"` — internal
  helpers included, not just interactive commands.
- **Explain non-obvious `setq`s:** every variable that is set gets a short comment
  above it saying *why*, unless the intent is self-evident. Skip the comment only
  when the setting speaks for itself.
- **Keep comments short.** They are read by an experienced Emacs user: state the
  intent in one line and don't explain standard Emacs behavior, hooks, or what a
  well-named function already says.
- **`use-package` is for external packages only.** Configure built-in Emacs behavior
  with plain `setq`/`defun`/hooks, not a `use-package` block.
- **Prefer `:custom` over `:config` over `:init`.** Set options via `:custom`; drop to
  `:config` only for setup that must run code after load (hooks, mode activation,
  imperative calls); use `:init` only when something genuinely must run before the
  package loads.
