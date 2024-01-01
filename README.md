# Absolute VIM Configuration

## Introduction

Here's the VIM configuration I'm going to be using for most of my professional work this year.
There may be changes as I discover new plugins. I intent to personalize this to my taste and
coding conventions. Feel free to try it out if you fancy 😄.

## Installation

```bash

git clone https://github.com/boxpositron/absolute-vim ~/.config/nvim --depth 1 && nvim

```

## Important

I built this to be compatible with Apple Silicon. It should work with other platforms. I've just
removed any incompatible plugins.

## Components

### Package Manager
I'm using lazy.nvim to manage all the packages. I setup the project to use the after directory as
well. Lazy does not need to use this but I set it up incase you want to switch to a different
package manager like packer. You'll notice I require the plugin file from after in the config
function for the plugin. It's worked for me and it keeps things organized.
