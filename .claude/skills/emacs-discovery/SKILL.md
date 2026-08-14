---
name: emacs-discovery
description: Find things worth adding to this Emacs configuration, and answer open questions about Emacs — what is new in a release, what is trending, which package solves a given problem, and how something is meant to be done.
disable-model-invocation: true
---

# Emacs discovery

Look outward: what is worth adopting, and what the user wants to know. Auditing what
is already here for rot is the job of `emacs-housekeeping` — the dividing line is
whether the config could do something new, or whether it has stopped doing what it
says.

Report only. Do not change the configuration; the user picks what to act on.

The request usually arrives as one of these, and they want different work:

- *What am I missing?* — sweep the config for gaps
- *What is new / trending?* — release notes and the community
- *What package for X?* — search the package index
- *How do I do Y?* — the manual, then the source

## Answer locally first

Almost everything is already on this machine, and local answers are exact for the
Emacs actually in use rather than for whatever version a blog post assumed. Reach
for the web when the question is about news, taste, or popularity — not before.

Ask Emacs where its own files are, rather than doing path arithmetic from the
binary — this survives a Nix store path or any other unusual install:

```bash
emacs -Q --batch --eval '(princ data-directory)'                                    # NEWS lives here
emacs -Q --batch --eval '(progn (require (quote info)) (info-initialize) (princ Info-directory-list))'
```

**Does Emacs already do this?** Cheapest possible answer, and it turns a package
recommendation into a one-liner surprisingly often:

```bash
emacs -Q --batch --eval '(princ (apropos-internal "scroll.*mode" (quote fboundp)))'
emacs -Q --batch --eval '(princ (documentation (quote pixel-scroll-precision-mode)))'
```

**How is it meant to be done?** 77 manuals ship with Emacs. Full-text search them
rather than reasoning from memory — the manual states the intended idiom and usually
names the newer replacement for an older one:

```bash
zgrep -h "scroll-conservatively" <info-dir>/emacs.info*.gz
```

`elisp.info` for the language, `emacs.info` for the editor, `org.info` for Org, and
package-specific manuals alongside them.

**What is new?** `etc/NEWS` covers the running version — a pretest, so it includes
things not yet in any release — and `etc/NEWS.30`, `NEWS.29` and so on cover
shipped releases. Authoritative, and it says which release introduced what:

```bash
grep -n "completion-preview" <data-directory>/NEWS.30
```

**What package for X?** elpaca's menu cache is a searchable offline index of every
installable package — about 7,000 entries across MELPA, GNU ELPA and NonGNU ELPA,
each with a description. A hit here is installable by definition, which beats a
blog recommendation for a package no menu carries:

```bash
emacs -Q --batch --eval '(with-temp-buffer (insert-file-contents "var/elpaca/cache/melpa.eld") (goto-char (point-min)) (dolist (e (read (current-buffer))) (let ((d (plist-get (cdr e) :description))) (when (and d (string-match-p "journal" d)) (princ (format "%s — %s\n" (car e) d))))))'
```

Repeat for `gnu-elpa.eld` and `nongnu-elpa.eld`. Descriptions are one line, so
search generously and filter afterwards.

**How does an installed package actually work?** Read it. The clone under
`var/elpaca/sources/<pkg>/` is the real answer, ahead of any README.

## Then the web

For news, trends and what people actually like:

- Planet Emacslife: https://planet.emacslife.com — the blog aggregator
- Sacha Chua's weekly Emacs news: https://sachachua.com/blog/category/emacs-news/
- Trending Emacs Lisp: https://github.com/trending/emacs-lisp?since=monthly
- MELPA by downloads: https://melpa.org/#/?sort=downloads&asc=false
- Awesome Emacs: https://github.com/emacs-tw/awesome-emacs
- https://www.reddit.com/r/emacs/

Treat EmacsWiki with suspicion — many pages have not been touched in a decade and
confidently describe workflows that Emacs has since replaced.

## Fitting it to this config

A recommendation that is already configured, or that does not exist in this Emacs,
makes the whole list suspect. Two checks, both cheap:

```bash
emacs -Q --batch --eval '(princ (fboundp (quote pixel-scroll-precision-mode)))'
grep -rn "save-place\|savehist" modules/ init.el
```

Grep for partial configuration too, not just absence — a variable set for a mode
that is never enabled is a better find than a fresh suggestion, because it is
already half-done.

Hold packages to a higher bar than built-ins. Every package is a maintenance
liability the user carries forever; a built-in is free.

## Output

A table, most valuable first, each row saying what it is and *why it earns its place
in this config specifically*. A generic tip list is easy to produce and worthless.
Lead with built-ins and anything already half-configured.

For a direct question — *what package for X*, *how do I do Y* — answer the question
first and keep the table for anything else worth mentioning. Cite where each claim
came from: the manual node, the NEWS entry, the package's own source.

Read the Settled list at the top of `var/housekeeping.md` before recommending
anything; re-suggesting something already turned down wastes everyone's time.
