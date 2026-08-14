---
name: emacs-housekeeping
description: Audit this Emacs configuration for rot — settings that silently do nothing, obsolete or superseded config, dead leftovers, dormant package upstreams, packages superseded by built-ins, keybinding collisions, startup cost and stale pins.
disable-model-invocation: true
---

# Emacs housekeeping

Audit what is already here. Finding things worth *adding* is the job of
`emacs-discovery` — keep the two apart so each report stays short. The dividing
line: whether the config is still doing what it says is housekeeping, whether it
could do something new is discovery.

Report only. Do not change the configuration; the user picks what to act on.

Not everything below will yield findings on a given run. Say so plainly rather than
padding the report — a short honest report keeps the next one worth reading.

## Record

`var/housekeeping.md` holds what previous runs concluded. Read it first. Anything
verified healthy recently can be reported as such without checking again, so each
run costs less than the last and spends its effort on what actually moved.

Update it at the end of every run: the date, what was checked, what was healthy,
what the user acted on, and what was raised but left alone. That last one matters —
without it the same suggestion gets re-pitched every time.

This is the only file the skill writes; the configuration itself stays untouched.
Keep it terse, roughly a line per package or area. A record nobody skims is a
record nobody maintains.

## Broken now

Lead with these. A setting that silently does nothing outranks a dormant upstream,
because the user believes it is working.

**Options whose setter never ran.** Some `defcustom`s do all their work in `:set`,
which plain `setq` skips — the value reads back correctly while nothing happened.

```bash
emacs -Q --batch --eval '(princ (get (quote eldoc-help-at-pt) (quote custom-set)))'
```

Check every option the config sets. A non-nil result means it needs `setopt`, and
that the defining library must already be loaded when it runs.

**Configured but never enabled.** Variables set and hooks excluded for a mode that
is never switched on. Reads as working, does nothing. For each `foo-*` variable the
config sets, check whether `foo-mode` is ever called.

**Hooks that never fire.** `use-package`'s `:hook` appends `-hook`, so an abnormal
hook like `gptel-post-response-functions` silently becomes `…-functions-hook`. Also
check hooks added to variables that no longer exist.

**Load-order dependence.** Anything that reads a file or a path *at enable time*
breaks if it runs before whatever sets that path. `savehist-mode` is the archetype:
it loads its file the moment it is enabled.

**Bindings pointing nowhere.** Every symbol named in a `define-key` or
`global-set-key` should be `fboundp` once its package is loaded.

## Packages

Every `use-package` form under `modules/`:

```bash
grep -h "^(use-package " modules/*.el
```

Not `var/elpaca/builds/` — most of what lives there is transitive dependencies the
user never chose and cannot act on.

**Is upstream dormant?** Judge by last release and whether issues get answers, not
commit count. Many small Emacs packages go quiet because they are *finished*;
calling those abandoned burns trust in the whole report.

**Is there a better-maintained alternative?** Only worth raising when the
replacement is genuinely healthier and covers the same ground.

**Is it superseded by a built-in?** Emacs absorbs packages steadily and the config
may predate that. Beware stubs — Emacs ships a `compat.el` that provides two macros,
not the real library. Read the file before declaring anything redundant, and check
the version floor of whatever still depends on it:

```bash
emacs -Q --batch --eval '(princ (locate-library "transient"))'
grep -m1 "Package-Requires" var/elpaca/sources/<consumer>/<consumer>.el
```

**Is it overkill?** A whole package for one macro or one command is fair to inline.
Users act on this one most readily because it costs them nothing. Measure the real
usage rather than guessing:

```bash
grep -rn "<package-prefix>" modules/ init.el
```

## Configuration

**Formally obsolete.** Mechanical, no false positives — but the properties only
exist for libraries that are loaded, so `require` what the config configures first:

```elisp
(get 'some-var 'byte-obsolete-variable)   ; non-nil → obsolete, names the successor
(get 'some-fn  'byte-obsolete-info)
```

**Superseded in practice.** A knob that still works but a newer one subsumes —
`scroll-step` against `scroll-conservatively`, `defadvice` against `advice-add`.
These are *not* marked obsolete, so this tier is judgment: check the manual for the
variable and see whether it points elsewhere. Flag it as a preference, not a defect.

**Dead leftovers.** Settings for packages no longer installed, hooks for modes no
longer used, helper functions nothing calls, ignore-rules for files no longer
generated. These accumulate silently after every removal.

**Convention drift.** `AGENTS.md` is the spec — check the config still obeys it.
The `lexical-binding` cookie, `my//` versus `my/`, a docstring on every function, a
why-comment on settings that need one, `use-package` reserved for external packages.

## Keybindings

Collect every `global-set-key` and `define-key` and look for the same key bound
twice, or a global binding shadowing a standard Emacs one. Invisible until a key
mysteriously stops working, and trivial to check.

## Startup and upgrades

`(emacs-init-time)`, plus the `:demand t` list — each one is a deliberate startup
cost, and some were added to solve an ordering problem that has since moved.

`packages.lock` pins drift behind upstream silently. Worth asking whether a refresh
is due, separately from whether each upstream is alive.

## Verifying

Never report from memory — package facts age badly, and a wrong "this is abandoned"
poisons the whole report.

Last upstream activity, from the local clone:

```bash
git -C var/elpaca/sources/<pkg> log -1 --format='%ci %s'
```

That date is only a lower bound: it reflects the user's last `elpaca-update`.
Cross-check anything that looks stale against the GitHub API, which also reveals
whether the repo is archived:

```
WebFetch https://api.github.com/repos/<owner>/<repo>
→ archived, pushed_at, open_issues_count
```

## Output

A table, most valuable first, with the finding and the rough effort. Broken things
first, then the rest. Pure deletions are worth calling out — they are the cheapest
wins and usually get taken immediately.

Follow with a short list of deliberate keeps and the reason, so the same packages
are not re-examined from scratch next time.

Respect the settled decisions at the top of the record; re-litigating them wastes
everyone's time.
