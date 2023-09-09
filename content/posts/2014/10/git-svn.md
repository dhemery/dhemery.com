---
date: "2014-10-23T00:00:00Z"
tags:
- coding
- git
- version control
- collaborating
title: Using Git With Subversion Repositories
---

Some of my clients want to use git
with their existing Subversion repositories.
These are the notes I give them
(along with training and coaching)
to get them started.

For additional help, see the
[Git and Subversion](http://git-scm.com/book/ch8-1.html)
section of _Pro Git._

## General Safety Rules

These rules will help keep you out of trouble
until you learn the subtleties
of working with git and subversion:

1.  **Make changes
    _ONLY_
    on feature branches.**
1.  **Merge your features into master
    _ONLY_
    immediately before committing to SVN.**

## Working With The SVN Repository

You will do most of your work
in a local git repository,
using normal `git` commands.

You will use the `git svn` command
only to do three things:

-   [Create a git repository](#create-a-git-repository-from-an-svn-repository)
    from an SVN repository.
-   [Update your master branch](#update-the-master-branch)
    with changes from the SVN repository.
-   [Commit your feature](#commit-the-feature-to-the-svn-repository)
    to the SVN repository.

###  Create A Git Repository From An SVN Repository

To **create** a local git repository
from a remote SVN repository:

~~~ bash
git svn clone url-to-svn-repo my-git-repo-name
~~~

Note that this can take a _very_ long time
if the SVN repository has a large history.

## Working With Feature Branches

You will do your work
in **feature branches**
in your local git repository.
A common approach
is to create a feature branch
for **each feature** that you are working on.

See the git documentation
for details about how to work with branches.

### Create A Feature Branch

1.  **Choose the starting point.**
    Decide whether
    to base your new feature branch
    on the master branch
    or on another feature branch.
1.  **Update the starting point branch** (optional).
    If you want
    your new feature branch
    to include the latest changes from SVN,
    update the existing branch:
    -   How to
        [update the master branch](#update-the-master-branch).
    -   How to
        [update an existing feature branch](#update-the-feature-branch).
1.  **Check out the starting point branch.**
1.  **Create the feature branch.**
    There are two ways to do this.
    See below.

    To
    **create a feature branch
    _and check it out_**:

    ~~~ bash
    git checkout -b my-feature
    ~~~

    To
    **create a feature branch
    _without checking it out_**:

    ~~~ bash
    git branch my-feature
    ~~~

## Committing Your Feature

To commit your feature
into the SVN repository:

1.  **[Update the master branch](#update-the-master-branch)**
    with the changes from the SVN repository.
1.  **[Update the feature branch](#update-the-feature-branch)**
    with the changes from the
    up-to-date master.
1.  **[Merge the feature into the master branch](#merge-the-feature-into-the-master-branch)**.
    You may need to
    [resolve conflicts](#resolve-conflicts).
1.  **[Commit the feature to the SVN repository](#commit-the-feature-to-the-svn-repository)**.

Each step is described in its own section below.

The complete sequence looks like this:

~~~ bash
## Update master...
git checkout master
git svn rebase

## Update the feature branch
git checkout my-feature
git rebase master
## may need to resolve conflicts here

## Merge the feature into master
git checkout master
git merge my-feature

## Commit the feature from master
git svn dcommit
~~~

### Update The Master Branch

To get the latest changes
from the SVN repository
into your master branch:

~~~ bash
git checkout master
git svn rebase
~~~

You may wish to update your master branch often.
That way,
every time you create a feature branch
from the master branch,
the initial feature branch
is up-to-date with the SVN repository.

### Update The Feature Branch

You will be getting the new changes
from the master branch.
So before you do this,
**you must
[update the master branch](#update-the-master-branch)**.

Then:

~~~ bash
git checkout my-feature
git rebase master
~~~

You may need to [resolve conflicts](#resolve-conflicts).

I often update my feature branch,
even if I am not going to commit soon.
Keeping my feature branch up to date
makes the final merge easier
when I am ready to commit.

### Resolve Conflicts

Whenever you rebase your feature branch
on top of master,
there may be conflicts
between your feature branch
and the new changes in master.

If there are conflicts,
git will interrupt the rebase operation
and alert you.
To complete the rebase,
you must first resolve the conflicts.

To resolve the conflicts,
either edit the conflicting files in an editor,
or use a mergetool:

~~~ bash
git mergetool
~~~

Once you have resolved the conflicts,
continue the rebase process:

~~~ bash
git add .
git rebase --continue
~~~

### Merge The Feature Into The Master Branch

Do this **ONLY** immediately before committing.

Before you do this,
**you must
[update the feature branch](#update-the-feature-branch)**
with changes from SVN.

Once your feature branch is up to date:

~~~ bash
git checkout master
git merge my-feature
## OR git merge --squash my-feature
~~~

### Commit The Feature To The SVN Repository

You will be committing from the master branch.
So before you do this,
**you must
[merge your feature into the master branch](#merge-the-feature-into-the-master-branch)**.

Once your feature is merged into the master branch:

~~~ bash
git checkout master
git svn dcommit
~~~
