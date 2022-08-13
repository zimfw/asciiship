asciiship
=========

A heavily reduced, ASCII-only version of the [Spaceship] and [Starship] prompts.

<img width="706" src="https://zimfw.github.io/images/prompts/asciiship@2.png">

What does it show?
------------------

  * On the top line:
    * Value of `SHLVL` when shell level is at least 2.
    * User name when root or in an SSH session.
    * Host name when in an SSH session.
    * Current directory.
    * Git information when you are in a git repo. This requires the [git-info]
      module, that can be customized with additional [settings][git-info settings].
      The following information is shown:
      * Current branch name, or commit short hash when in ['detached HEAD' state].
      * Git action, when there's an operation in progress.
      * `$` when there are stashed states.
      * `!` when there are modified files.
      * `+` when there are staged files.
      * `>` and/or `<` when there are commits ahead and/or behind of remote,
        respectively.
    * Python [venv] indicator.
    * How long the last command took to execute. This requires the [duration-info]
      module, that can also be customized with additional [settings][duration-info settings].
  * On the bottom line:
    * `*` when there are background jobs running.
    * Exit code of last command, when it's not zero.
    * `#` when root, `%` otherwise.
    * Keymap indicator.

Requirements
------------

Requires Zim's [git-info] module to show git information, and [duration-info]
module to show the last command duration.

[Spaceship]: https://spaceship-prompt.sh/
[Starship]: https://starship.rs/
[git-info]: https://github.com/zimfw/git-info
[git-info settings]: https://github.com/zimfw/git-info/blob/master/README.md#settings
['detached HEAD' state]: https://git-scm.com/docs/git-checkout#_detached_head
[venv]: https://docs.python.org/3/library/venv.html
[duration-info]: https://github.com/zimfw/duration-info
[duration-info settings]: https://github.com/zimfw/duration-info/blob/master/README.md#settings
