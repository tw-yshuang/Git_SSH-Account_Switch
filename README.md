# Git_SSH-Account_Switch

A CLI tool can switch ssh account to your current shell. You will easily switch to your git account & ssh key when using the server, and using your account to manipulate the project on the server.

**NOTE**: This tool is for the user who using `Zsh` on the UNIX/Linux platfrom.

## Installation

```shell
$ zsh ./setup.sh
```

it will add some code in your `profile` & `$logout_profile`, and setup `git-acc` & `.gitacc` on the `$HOME`. \
file:

> git-acc.sh -> $HOME/.git-acc, `git-acc` function.\
> .gitacc -> $HOME/.gitacc, save info. that regist on `git-acc`.

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
      -t, --type          ssh-key types, follow `ssh-keygen` rule,
                          types: dsa | ecdsa | ecdsa-sk | ed25519 | ed25519-sk | rsa(default)
  -rm, --remove_account   remove git_account info. & ssh-key from this device
  -out, --logout          logout your current ssh-acc.


EXAMPLES

  $ git-acc tw-yshuang
```

### SWITCH ACCOUNT

When you want to use the account that you have already added it, you can type:

```shell
$ git-acc <tab>
```

Then it will come out the current account that registers in the `git-acc` to let you choose, e.g.

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

#### **CHOOSE YOUR SSH-KEY TYPE**

If you do not want to use `rsa` type to create your ssh-key, you can use this:

```shell
$ git-acc -add -t <key-type>
    or
$ git-acc -add --type <key-type>
```

This args is following `ssh-keygen -t` rule, you can type corresponding key type you wnat! \
Types: `dsa | ecdsa | ecdsa-sk | ed25519 | ed25519-sk | rsa(default)`

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

### LOGOUT

```shell
$ git-acc -out
    or
$ git-acc --logout
```

Logout your ssh-acc perfectly at CLI mode.
