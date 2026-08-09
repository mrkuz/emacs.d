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
