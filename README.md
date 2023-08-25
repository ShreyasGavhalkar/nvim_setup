# Setting up Neovim
## Installing neovim
Nvim can be installed with `sudo apt install neovim` but it will most probably install an older version which will not work. Preferred method is to download the latest release from [neovim’s github repository](https://github.com/neovim/neovim/releases) , extract the `*.tar.gz` file and add the path of the bin folder of the extracted archive to your `$PATH`. 

```sh
wget <link to the nvim release archive>
tar -xvf <archive>

export PATH=<path to extracted archive>/bin:$PATH # this will reset after 
                                                  #terminal session is closed
```
## Vim plugged
There are many ways of installing extensions into nvim, one of them is Vim Plugged. Lua can also be used. Lua needs no setup, Vim Plugged is easy to setup as well, just run:
```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
   	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## Configuring Nvim
Download the configuration files from this github repo.
Place the `init.vim` file inside a folder named nvim inside `~/.config`, so the location of init.vim must be `~/.config/nvim/init.vim`. Create another folder inside nvim and call it `lua/nvimtree`. Inside it place the `init.lua` file. Therefore init.lua is at `~/.config/nvim/lua/nvimtree/init.lua`

Now you can run `:PlugInstall` to install the plugins specified in your `init.vim`. Before doing that it is suggested to decide which method of code completion is to be used,  follow it’s setup, and then finally run `:PlugInstall`
# Code Completion in Nvim
Now running nvim will give errors which is expected since some more setup is required.
There are 3 methods using which code completion can be set up.
  1. Install Coc 
  2. Install YouCompleteMe
  3. Set up LSP server 
## Setting up YouCompleteMe
> [!IMPORTANT]
>Python >=3.8 IS NEEDED TO INSTALL ELSE IT WONT WORK

Remove the plug entry for coc in `init.vim` and add this
```
Plug 'ycm-core/YouCompleteMe'
```
Now goto `~/.vim/plugged/YouCompleteMe` and run
```
python3 install.py --clangd-completer
```
Support for more languages can be added. Refer to the instructions at [YCM’s GitHub repo](https://github.com/ycm-core/YouCompleteMe)


## Setting Up Coc
> [!IMPORTANT]
> Coc requires nodejs > 14 to run. Setting this up is relatively easier that setting up python when sudo is not available.

### Setting up nodejs
If sudo is available run:
```sh
sudo apt install nodejs
```
Else:
Download the nodejs binary from [their downloads page](https://nodejs.org/en/download).
> [!IMPORTANT]
> CHECK INSTALLED `glibc` VERSION(`ldd --version`) BEFORE INSTALLING THE LATEST `nodejs` RELEASE. AN OLDER VERSION MIGHT BE NEEDED FOR OLDER/NOT SUPPORTED `glibc`

Extract and add to `$PATH`
```sh
wget <link to node archive>

tar -xvf <downloaded archive>

export PATH=$PATH:<path to archive>/bin # this will reset after
                                        #terminal session is closed
```
Now launch nvim and run `:PlugInstall.`

## C/C++ code completion
`coc-clangd` is needed for autocompletion for c and cpp.
Run `:CocInstall coc-clangd`
If `clangd` isn’t installed install it by running `:CocCommand clangd.install`

## Python code completion
Install `coc-python` for python autocomplete support
A python installation needs to be set up for coc-python to work properly. If for some reason coc-python is not able to pick up the global python configuration and apply it for current user, it needs to be set up explicitly.
Edit the `~/.config/coc/memos.json` file. In it add an entry for your user like

```
”coc-python”|<path to home folder>/<user> : {
	<configuration>
},
```
The `<configuration>` part can be substituted with any of the python installations listed in the same file for other users like `usr/bin/python`. A sample `<configuration>` can be:
```
   "/usr/bin/python3.8.v3": {
  	"data": {    
    	"architecture": 3,    
    	"path": <path to python binary>,    
    	"version": {     "options": {    
        	"loose": false,    
        	"includePrerelease": false    
      	},    
      	"loose": false,    
      	"raw": "3.8.10-final",    
      	"major": 3,    
      	"minor": 8,    
      	"patch": 10,    
      	"prerelease": [    
        	"final"    
      	],    
      	"build": [],    
      	"version": "3.8.10-final"    
    	},    
    	"sysPrefix": "/usr",    
    	"fileHash": <hash of binary>    
  	},    
  	"expiry": 1693036040117    
	},
```
Now install Jedi using the same python binary you configured
```
<python binary like python3> -m pip install jedi
```
Coc-python may further ask to install a linter when editing a python file for the first time. The installation can be skipped but is recommended.


## Other languages/file types
Support for more languages and file types is available, refer [Coc’s GitHub repository](https://github.com/neoclide/coc.nvim) and the web

# Ctags
For goto definitions to work, ctags are required. A `tags` file must be present and nvim must be told where to find it. 

General syntax to generate a tags file:
```
ctags -R <include files(like headers) dirs> --exlude=<dir to exclude>
```
The more include dirs and bigger the source code, the more precise the ctags are but their generation takes a while (can also be hours therefore the directories must be specified with caution)
`--exclude` can be given any number of times to exclude multiple directories

# References to other plugins part of init.vim
There are many other plugins part of the `init.vim` file, here is a brief on what each of them does and references. These are not “needed” but are good to have to make life less painful

## Gruvbox
[Gruvbox](https://github.com/morhetz/gruvbox) is a theme for nvim. The web has many other themes available, can be skipped while setup. 

## Ale
It is used for syntax analysis, it supports many file formats automatically, just install and it runs without any configuration. Refer [github repo](https://github.com/dense-analysis/ale)

## Fzf
[Fzf](https://github.com/junegunn/fzf) is a fuzzy search tool for finding files quickly. It searches for files with a pattern as well as contents of files for the pattern.

## Nvimtree
[Nvimtree](https://github.com/nvim-tree/nvim-tree.lua) is the file explorer to open new files and folders. 

## Vim-eunuch and vim-vinegar
[Vim-eunuch](https://github.com/tpope/vim-eunuch) and [Vim-vinegar](https://github.com/tpope/vim-vinegar) are tools to perform file operations and some more good-to-have features. To install just clone the repo into `~/.config/nvim/lua/`

## Barbar
[Barbar](https://github.com/romgrk/barbar.nvim) is used to reform the tabs in nvim. It gives a better look and more control over buffers.

## Toggleterm
Integrated terminal support in nvim for running commands without leaving nvim, putting it into background or moving to a different tmux pane. Highly customizable, refer [github repo](https://github.com/akinsho/toggleterm.nvim).

