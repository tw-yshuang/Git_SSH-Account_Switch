# Git_SSH-Account_Switch
A CLI tool can easily switch ssh account to your current shell. You will easliy switch to your git account & ssh key when using server, and using your account to manipulate the project on the server.

```shell
        +---------------+
        |    git-acc    |
        +---------------+

SYNOPSIS

  git-acc [account]/[-h]

OPTIONS

  [account]               use which account on this shell, type account name that you register.
  -h, --help              print help information.
  -add, --add_account     build git_account info. & ssh-key.
  -rm, --remove_account   remove git_account info. & ssh-key from this device


EXAMPLES

  $ git-acc.sh -a default
```