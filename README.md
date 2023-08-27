<h1 align="center">dotfiles</h1>

<p align="center">A simple framework to organize my dotfiles</p>

## Idea

The system is based on fragments which will compose the configuration for a
given host.

You can arrange your aliases and other settings in different files depending on
where you want them to run. There is a very barebones installer that will work
in Debian/Arch/RedHat based distros, but that requires a bit more work to be
fully functional.

## Publishing

This repo receives automatic commits whenever I publish one to my private
dotfiles repository, which includes per-host private settings. Those are added
to `.gitignore` in the [github action in charge of the
publishing](https://github.com/javfg/dotfiles/blob/master/.github/workflows/publish.yml#L26).

## Features

* zsh-based with [oh-my-zsh](https://ohmyz.sh/)
* custom tmux settings
* colors in many cli applications
* aliases for git, docker and others

## Structure

Paths marked with `F` indicate files, the rest are directories.

```
.
├── bin                         <- binaries
├── compdef                     <- zsh autocompletion files
├── conf                        <- configuration files to be installed
├── envs                        <- environment definition (export commands)
│   ├── _host_1
│   ├── _...
│   └── _host_n
├── fragments                   <- fragment definitions
│   ├F─ global                  <- global fragment (runs everywhere)
│   ├── common                  <- per-topic fragments
│   │   ├F─ _git
│   │   ├F─ _docker
│   │   └F─ _...
│   └── hosts                   <- per-host fragments
│       ├F─ _host_1
│       ├F─ _...
│       └F─ _host_n
├── install                     <- installation scripts
│   ├F─ install.sh
│   ├── _host_1
│   ├── _...
│   └── _host_n
└F─ zshrc
```

## Usage

I'll eventually write a cheatsheet in some way that makes it convenient for
query. For now, you'll have to rely on the config files themselves. :)
