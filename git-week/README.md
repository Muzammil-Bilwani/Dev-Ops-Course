## Git Week

This week focuses on mastering Git and GitHub, essential tools for version control and collaboration in software development. Students will learn how to manage code repositories, collaborate with others, and implement best practices for version control.

You can learn more at: [Git Go ahead](https://gitgoahead.muzammilbilwani.com)


# Git Interview Questions and Answers

### 1. **What are the key differences between `git add .`, `git add -A`, and `git add -u`?**

- `git add .` adds new/modified files in the current directory (not deletions).
- `git add -A` stages all changes (including deletions).
- `git add -u` stages modifications and deletions but not untracked files.

---

### 2. **How do you view all remotes and their corresponding URLs in a Git repo?**

```bash
git remote -v
```

---

### 3. **What’s the difference between `HEAD`, `HEAD~1`, and `HEAD^`?**

- `HEAD` refers to the latest commit on the current branch.
- `HEAD~1` is one commit before `HEAD`.
- `HEAD^` is also the parent of `HEAD` (same as `HEAD~1` unless merge commit).

---

### 4. **How do you stage only part of a file (a few lines) instead of the whole file?**

```bash
git add -p
```

It lets you interactively choose chunks to stage.

---

### 5. **How do you find the author of a specific line in a file?**

```bash
git blame filename
```

---

### 6. **What is the effect of `git log --oneline --graph --all`?**

Displays a visual representation of the repo’s commit history in a concise graph format.

---

### 7. **How do you revert multiple commits without losing history?**

Use:

```bash
git revert HEAD~2..HEAD
```

This reverts the last 3 commits as separate revert commits.

### 8. **How does Git internally track file changes—by line or by snapshot?**

Git uses a **snapshot-based** model, storing a new snapshot of files at each commit (with deduplication via SHA-1 hashes), not diffs.

---

### 9. **What’s the difference between `git merge --no-ff` and `git merge --squash`?**

- `--no-ff` forces a merge commit even if fast-forward is possible.
- `--squash` compresses all changes into a single commit, but doesn’t retain individual commit history or create a merge commit.

---

### 10. **What is the Git index (staging area), and how does it work?**

The index is a cached snapshot between the working directory and the repository. When you run `git add`, changes move from working directory to index. `git commit` commits the index snapshot.

---

### 11. **What happens during `git pull --rebase` and when should it be used?**

It fetches remote changes and rebases your local commits on top of the updated remote branch—helps maintain a linear history.

---

### 12. **How do you recover a deleted branch in Git?**

If you know the last commit hash:

```bash
git checkout -b branch-name <commit-hash>
```

You can also find it via:

```bash
git reflog
```

---

### 13. **Explain the purpose and usage of `git worktree`.**

`git worktree` allows you to check out multiple branches into separate working directories from a single repo—useful for testing or parallel feature dev.

---

### 14. **What is the difference between shallow clone (`--depth`) and full clone?**

Shallow clones use `--depth` to limit history, reducing clone time and size. Full clones include complete history and all branches.

---

### 15. **What are Git hooks and give an example use-case.**

Git hooks are custom scripts triggered by Git events (e.g., `pre-commit`, `pre-push`, `post-merge`).  
Example: enforcing linting via `pre-commit`.

### 16. **What are the risks of using `git reset --hard`, and how can you recover from it?**

It permanently deletes local changes and commits. Recovery is possible _only_ if the commits existed in `reflog`.

---

### 17. **Describe how Git handles merging histories with unrelated parents.**

By default, Git cannot merge unrelated histories. You can force it using:

```bash
git merge other-branch --allow-unrelated-histories
```

---

### 18. **How does `git rebase -i` help rewrite history, and when should it NOT be used?**

It allows you to reorder, squash, or edit commits.  
**Avoid using on shared/public branches** to prevent rewriting shared history.

---

### 19. **What is the difference between a tracked, untracked, staged, and modified file in Git?**

- **Untracked**: Not in Git yet
- **Tracked**: Being watched by Git
- **Modified**: Changes made but not staged
- **Staged**: Changes added to index (ready to commit)

---

### 20. **How does Git determine if two files are the same (even with different names)?**

Git uses SHA-1 hashing. Identical content gets the same hash, allowing Git to track renames and copies.

---

### 21. **What are submodules and how do they differ from subtrees?**

- **Submodules**: Linked references to external Git repos. Maintained separately.
- **Subtrees**: Merges an entire external project inside your repo. Easier to work with but less decoupled.

---

### 22. **Explain how reflog differs from `git log`.**

- `git log`: Shows branch commit history.
- `git reflog`: Tracks updates to branch HEAD and allows recovery of lost commits.

---

### 23. **How do you move a commit from one branch to another?**

Use `git cherry-pick`:

```bash
git checkout new-branch
git cherry-pick <commit-hash>
```

---

### 24. **Describe Git’s object model.**

Git stores four objects:

- **Blob** – file data
- **Tree** – directory structure
- **Commit** – snapshot with metadata
- **Tag** – pointer to a commit (with annotation)

---

### 25. **What happens if you `git push --force` to a shared branch?**

It rewrites remote history, potentially **breaking collaborators' clones**. Should be used with extreme caution, or use `--force-with-lease` instead for safety.

---
