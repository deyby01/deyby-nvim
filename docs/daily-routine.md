# 🔁 A Developer's Daily Routine

> The real day-to-day flows, in the order they happen.
> For the complete shortcut reference, see **[commands-and-workflow.md](commands-and-workflow.md)**.

---

## 📋 Contents

1. [Start the day](#1-start-the-day)
2. [Start a new task](#2-start-a-new-task)
3. [Understand someone else's code](#3-understand-someone-elses-code)
4. [Write code](#4-write-code)
5. [When something breaks](#5-when-something-breaks)
6. [Work with Docker](#6-work-with-docker)
7. [Preview HTML/CSS](#7-preview-htmlcss)
8. [Refactor](#8-refactor)
9. [Before committing](#9-before-committing)
10. [Commit and push](#10-commit-and-push)
11. [Open the pull request](#11-open-the-pull-request)
12. [Review someone else's PR](#12-review-someone-elses-pr)
13. [Resolve conflicts](#13-resolve-conflicts)
14. [End the day](#14-end-the-day)
15. [The 15 shortcuts you'll use 90% of the time](#the-15-shortcuts-youll-use-90-of-the-time)

---

## 1. Start the day

```bash
# tmux session (the server survives closing the terminal)
tmux new -s my-project

cd ~/projects/my-project
source .venv/bin/activate     # important: linters come from the venv
nvim
```

auto-session restores the files you had open in this folder and branch.

```
Space+gs        # what state did the repo end in?
:Git pull origin main
Space+opr       # any PRs waiting on my review?
```

> 💡 If you don't use tmux, `Space+ld` gives you LazyDocker and `Ctrl+´` an
> integrated terminal. tmux is only needed when a process must outlive nvim.

---

## 2. Start a new task

```
:Git checkout main
:Git pull origin main
:Git checkout -b feature/task-name
```

Mark the files you'll be touching so you can hop without searching:

```
Space+ff  → models.py       → Space+a
Space+ff  → views.py        → Space+a
Space+ff  → serializers.py  → Space+a
Space+ff  → tests.py        → Space+a

# Now:
Space+1  Space+2  Space+3  Space+4
```

Start the server in its own pane:

```
Ctrl+a -                       # tmux pane below
python manage.py runserver
Ctrl+k                         # back to Neovim
```

---

## 3. Understand someone else's code

The thing developers do most: read code they didn't write.

| I want to... | Shortcut |
|--------------|----------|
| See what this function does | `K` (hover) |
| Go to where it's defined | `gd` |
| See **who calls it** | `gr` (references) |
| Get back to where I was | `Ctrl+o` |
| Search text across the project | `Space+fg` |
| See the file's structure | `Space+bp` (breadcrumbs) |
| Know who wrote this line and why | `Space+hb` (blame) |
| See the file's full history | `Space+gh` |

### A typical exploration flow

```
Space+fg   → search "OrderSerializer"
Enter      → open the result
gd         → jump to the base class definition
Ctrl+o     → back
gr         → every place that uses it
Space+hb   → why was it written this way? (blame → commit → PR)
```

> 💡 **`Ctrl+o` / `Ctrl+i`** walk the jumplist (back/forward). They're the key
> to exploring without getting lost.

---

## 4. Write code

### The basic cycle

```
i                    # enter insert
{type}               # LSP + Copilot + snippets share one menu
Tab / Shift+Tab      # move between entries
Enter                # accept
jk                   # leave insert (auto-saves)
```

### Going faster with snippets

```
model          → full models.Model class
serializer     → DRF ModelSerializer
listview       → class-based view
block          → {% block %}{% endblock %} (in templates)
div.card>ul>li*3  → HTML structure (Emmet)
```

Full list in **[django.md](django.md#snippets)**.

### When an import is missing

```
Space+ca     → code actions → "Import X from Y"
```

### Format before moving on

```
Space+cf     → ruff / prettier / djlint, depending on the filetype
```

### Editing that saves time

| I need to | How |
|-----------|-----|
| Change a whole word | `ciw` |
| Change to end of line | `C` |
| Duplicate a line | `yy` `p` |
| Comment line / selection | `gcc` / `gc` in visual |
| Wrap in quotes | `ysiw"` |
| Change `'` to `"` | `cs'"` |
| Indent several lines | `V` `j j` `>` (then `.` to repeat) |
| Edit N lines at once | `Ctrl+v` → `j j` → `I` → text → `Esc` |
| Jump to a visible spot | `s` + 2 letters |
| **Repeat the last thing** | `.` |

---

## 5. When something breaks

### First: what does the editor say?

```
Space+xf     # current file diagnostics
Space+xx     # whole project
]d / [d      # jump between them
```

### Debugger instead of prints

```
Space+db     # breakpoint on the suspicious line
Space+dc     # start → "Django runserver"
# make the request from the browser → it pauses there
Space+do     # step line by line
# inspect variables in the Scopes panel
Space+dx     # finish
```

Details in **[django.md](django.md#debugger)**.

### The tests

```
Space+nt     # run the test under the cursor
Space+no     # read the traceback if it fails
Space+nf     # run the whole file
```

### Did it work before?

```
Space+gh     # file history: what changed and when
Space+hb     # blame the suspicious line
```

---

## 6. Work with Docker

```
Space+ld     # LazyDocker: containers, logs, images and volumes
```

The fastest way to answer "is it running?", "why did it die?" and
"restart this". Inside: `Tab` switches panels, `Enter` shows logs, **`x` opens
the action menu** for the selected item.

### What you do most in a day

```bash
docker compose ps                  # what's up?
docker compose logs -f web         # follow the logs
docker compose restart web         # apply a config change
docker compose exec web bash       # get a shell in the container
docker compose exec web python manage.py migrate
```

### When a container won't start

```
Space+ld     → Containers panel → Enter on the failing one → read the log
```

If the error comes from the `Dockerfile` or `docker-compose.yml`, open them in
Neovim: they have LSP support with completion and diagnostics, so syntax
mistakes show up before you rebuild.

📖 Full reference in **[commands-and-workflow.md](commands-and-workflow.md#docker--lazydocker)**.

---

## 7. Preview HTML/CSS

For plain HTML/CSS work with no backend involved:

```
Space+lv     # Live Server: serves the folder and opens the browser
```

Save the file and the browser refreshes on its own — the same thing the VSCode
Live Server extension does.

```
1. Open your index.html
2. Space+lv        → browser opens
3. Esc             → leave the floating terminal (it keeps serving)
4. Edit and save
5. Look at the browser: already refreshed
```

📖 Details in **[commands-and-workflow.md](commands-and-workflow.md#html--live-server)**.

---

## 8. Refactor

### Renaming properly

```
Space+rn     # renames the symbol across the WHOLE project via LSP
```

This is the right tool for variables, functions and classes: it understands
scope and won't touch strings or comments that merely match.

### Search and replace text

```
Space+sw     # search the word under the cursor project-wide
# review the list, exclude what you don't want with dd
R            # apply
```

For strings, URLs, template names — things the LSP doesn't treat as symbols.

### Check you didn't break anything

```
Space+xx     # any new errors?
Space+nf     # do the tests pass?
Space+gw     # is the diff what I expected?
```

---

## 9. Before committing

**The step that saves the most review rounds:** read your own diff.

```
Space+gw     # full working-tree diff
Tab          # walk through it file by file
```

### Mental checklist

```
Space+ft     # did I leave TODOs or FIXMEs behind?
Space+xx     # any errors or warnings?
Space+cf     # is it formatted?
Space+nf     # do the tests pass?
```

Things that commonly sneak in and show up in the diff: debug `print()`,
`console.log`, hardcoded credentials, commented-out code, unused imports.

---

## 10. Commit and push

### Clean commits, hunk by hunk

If you touched several unrelated things in one file, split them:

```
]c             # go to the first change
Space+hp       # review it
Space+hs       # stage only that hunk
]c             # next one... (or leave it for another commit)
```

### Committing

```
Space+gs       # status panel
s              # stage the file under the cursor
=              # see its diff before deciding
cc             # commit → write message → Ctrl+s
```

### Push

```
:Git push origin feature/task-name
```

---

## 11. Open the pull request

Before asking for it, look at the whole set of your commits:

```
Space+gf     # every commit from the base branch to HEAD
Space+gd     # full diff against the base branch
```

Then:

```
Space+opc    # create the PR from Neovim
```

Or from the terminal:

```bash
gh pr create --base main --title "..." --body "..."
```

---

## 12. Review someone else's PR

```
Space+opr    # list PRs
Enter        # open the one assigned to you
Space+or     # start the review
Space+gD     # see the diff against origin/<base branch>
```

While reviewing:

| I want | Shortcut |
|--------|----------|
| Understand a changed function | `gd` / `K` |
| See whether it breaks other places | `gr` |
| Comment on a line | `:Octo comment add` |
| See historical context | `Space+gh` |

```
:Octo review submit
```

---

## 13. Resolve conflicts

```
:Git merge main
# → CONFLICT

Space+cl     # list every conflict in the repo
Space+cn     # go to the next one
Space+co     # keep mine
Space+ct     # keep the other branch's
Space+cb     # keep both and edit by hand

Space+cl     # verify the list is empty
Space+nf     # run the tests: badly resolved conflicts compile but fail
Space+gs → s → cc
```

> ⚠️ During a **rebase**, "ours" and "theirs" are swapped relative to a merge.
> When in doubt, read the content, not the label.

---

## 14. End the day

```
Space+gs                          # anything uncommitted?
s → cc                            # commit what's ready
:Git push origin my-branch        # push it (remote backup)
Space+ss                          # save the session
:qa                               # close Neovim
Ctrl+a d                          # detach from tmux (server stays alive)
```

The next day:

```bash
tmux attach -t my-project
# exactly as you left it
```

> 💡 If you're leaving work half-done, make a `wip:` commit and push it. A dying
> disk doesn't warn you.

---

## The 15 shortcuts you'll use 90% of the time

If you only memorize a handful, make it these:

| # | Shortcut | Action |
|---|----------|--------|
| 1 | `Space+ff` | Find a file |
| 2 | `Space+fg` | Search text in the project |
| 3 | `gd` | Go to definition |
| 4 | `gr` | Find references |
| 5 | `Ctrl+o` | Get back to where I was |
| 6 | `K` | Show documentation |
| 7 | `Space+ca` | Code actions (auto-import) |
| 8 | `Space+cf` | Format |
| 9 | `Space+xf` | Current file diagnostics |
| 10 | `Space+gs` | Git status |
| 11 | `Space+hp` | Preview a git change |
| 12 | `s` | Jump anywhere |
| 13 | `gcc` | Comment |
| 14 | `.` | Repeat the last action |
| 15 | `Ctrl+p` | Search any command you forgot |

---

## Frequent terminal commands

From `Ctrl+´` or a tmux pane:

```bash
# Django
python manage.py runserver
python manage.py makemigrations && python manage.py migrate
python manage.py shell
python manage.py createsuperuser

# Docker
docker compose up -d
docker compose logs -f web
docker compose restart web
docker compose exec web python manage.py migrate

# Tests
pytest
pytest -k "test_name"
pytest --lf                    # only what failed last time

# Frontend
npm run dev
npm run build
```

---

## Tips that make a difference

- **`.` is Vim's most underrated key.** Make a change, move to the next spot,
  press `.`. It works with almost everything.
- **`Ctrl+p` when you can't remember something.** Search by name across every
  shortcut and command. Faster than opening the docs.
- **Mark files with Harpoon at the start of the task, not halfway through.** You
  already know the four files you'll be touching.
- **`TODO:` and `FIXME:` instead of mental notes.** Get them back with `Space+ft`.
- **Stage by hunks (`Space+hs`).** Small commits review better and revert painlessly.
- **Read your own diff before requesting review.** It saves the "remove the
  print" and "unused import" round.

---

[⬅️ Back to the README](../README.md) · [Command reference ➡️](commands-and-workflow.md)
