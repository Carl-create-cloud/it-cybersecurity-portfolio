# How to document technical work

A useful report lets another person understand the problem, repeat your investigation, and see why your conclusion follows from evidence.

## Write in this order

1. **Problem:** what did you expect, and what actually happened?
2. **Environment and scope:** OS/tool versions, relevant lab setup, and which systems you may test.
3. **Hypothesis:** a possible explanation, not yet a fact.
4. **Test:** exact command, where it ran, and why you chose it.
5. **Observation:** relevant output or error, with a sanitized evidence link.
6. **Interpretation:** what the test supports and what it does not prove.
7. **Action and verification:** what changed, how you checked it, and how to undo it.
8. **Lesson:** what you would do differently next time.

## Example only: not an actual result

Problem: the local demo site does not load. Hypothesis: no service is listening on TCP port 8000. Test: `Test-NetConnection 127.0.0.1 -Port 8000` in Windows PowerShell. If `TcpTestSucceeded` is false, the connection attempt failed; this alone does not identify the cause. Check the server process and its configured port next. After starting the intended server, repeat the TCP test and request the page. Record the actual outcomes, even if they differ from the hypothesis.

## Markdown essentials

```markdown
# Report title
## Problem
Describe the symptom.
- First observation
- Second observation
- [ ] Task not yet completed
- [x] Task completed with evidence
[Evidence](evidence/example.txt)
```

Use triple backticks around commands or output. `README.md` is the entry page GitHub displays for a directory. Use relative links so documentation works both locally and on GitHub. See [GitHub's syntax guide](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).

## Evidence and commits

Prefer short text excerpts over screenshots when possible. Caption screenshots with what they prove. Replace sensitive values consistently with labels such as LAB-IP or USERNAME; keep raw originals in `local-only/`. Never commit passwords, tokens, personal email addresses, or unrelated desktop content. `.gitignore` is a convenience, not a secret detector.

Before committing, use `git status` to see changed files and `git diff` to read changes. Stage explicit paths with `git add <path>`, then inspect `git diff --cached`. Commit one meaningful change with a message such as `docs: record service recovery test`. Commit saves locally; push sends commits to GitHub. These are examples to learn, not commands to paste with literal placeholders.

## Final review

Can a classmate reproduce it? Are conclusions supported? Are limitations explicit? Can you explain each command without reading an AI answer? Did you credit sources and assistance? A clear account of a failed hypothesis is useful engineering evidence.
