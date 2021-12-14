# Git_SSH-Account_Switch
A CLI tool can switch ssh account to your current shell. You will easily switch to your git account & ssh key when using the server, and using your account to manipulate the project on the server.

## Installation
```shell
$ bash ./setup.sh
```
it will add some code in your `profile` & `$logout_profile`, and setup `git-acc` & `.gitacc` on the `$HOME`. \
file:
> git-acc.sh -> $HOME/.git-acc, `git-acc` function.\
> .gitacc   -> $HOME/.gitacc, save info. that regist on `git-acc`.
## Control
```shell
        +---------------+
        |    git-acc    |
        +---------------+

SYNOPSIS

  git-acc [account]|[option]

OPTIONS

  [account]               use which accounts on this shell, type the account name that you register.
  -h, --help              print help information.
  -add, --add_account     build git_account info. & ssh-key.
  -rm, --remove_account   remove git_account info. & ssh-key from this device


EXAMPLES

  $ git-acc tw-yshuang
```

### SWITCH ACCOUNT
When you want to use the account that you have already added it, you can type:
```shell
$ git-acc <tab>
```
Then it will come out the current account that registers in the git-acc to let you choose, e.g.
```shell
$ git-acc <tab>
tw-yshuang cool-name ...
```

### ADD
```shell
$ git-acc -add
    or
$ git-acc --add_account
```
It will ask you to type:
```shell
Enter your git user name: <acc_name>
Enter your git user mail: <acc_mail>
```
After that, `git-acc` will generate `id_rsa_<acc_name>`, `id_rsa_<acc_name>.pub` in the `$HOME/.ssh`. \
Next, you can type `$ git-acc <acc_name>`, to login your account.\
NOTE: You also can overwrite your account.

### REMOVE
```shell
$ git-acc -rm
    or
$ git-acc --remove_account
```
It will ask you to type:
```shell
Enter the git user name you want to remove: <acc_name>
```
