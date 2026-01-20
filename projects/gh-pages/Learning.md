# git rebase

When rebasing, if there are conflicts, you are basically adjusting each single commit in your branch one by one, since rebase adds commits onto existing ones. So it would be like:

1. You are working on `feature` branch, and have 3 commits.
2. You push your changes to remote, and raise PR to `main`.
3. `main` branch had some changes during work, so there are conflicts.
4. You rebase, and start resolving conflicts based on first commit.
5. You run `git rebase --continue`, and resolve for second commit etc.
6. Now you have overwritten the existing commits, so your local branch is ahead of `main` and behind the remote feature branch at the same time (since remote has different commits now).
7. You run `git push --force-with-lease` to overwrite the remote branch commits.

