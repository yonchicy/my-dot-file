# MyDotFile

## 介绍

用于存储各种配置文件以便于快速搭建适合自己的开发环境


## VIM

### 1.安装`NeoVim`

*  为什么用NeoVim？

NeoVim是Vim的现代版，他完全兼容vim，同时提供了对lsp、lua等支持，更加快速、好用、便于配置。

* 安装NeoVim

可以去github上搜索NeoVim克隆源码本地编译(不过太难编译成功了)，也可以选择下载他们的编译好的二进制包。
下面是一种下载编译好的二进制包的方法
```
$ wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
```
然后解压，将其中的/bin文件夹加入到环境变量里，使用
```
nvim
```
命令即可在终端中使用nvim啦.

ps:可以用`alias vim=nvim`

### 2.配置`NeoVim`

只需要将本仓库的`nvim`文件夹整个复制到`~/.config/`目录下面即可。
然后在终端中打开nvim，就稍等片刻，输入`:PackInstall`就可以安装全部插件了。

### 3.常见问题

* `LSP`、`Tree-sitter` 安装慢的问题

可以选择科学shangwang，也可以去修改插件中下载lsp的url源

### 4.附

* 安装`ripgrep`可以在vim中解锁类似`grep`的功能。

[ripgrep](https://github.com/BurntSushi/ripgrep "ripgrep")是`grep`的升级版，更好用。

* 安装`ranger`

[ranger](https://github.com/ranger/ranger "ranger")是非常好用的linux下的资源管理器。
我的vim配置文件也支持了这个。

* 安装`fzf`

[fzf](https://github.com/junegunn/fzf "fzf")非常好用的一个模糊查找，我的vim配置也支持这个玩意儿。可以去



## tmux
- 无脑把`.tmux.conf`和`.tmux.conf.local`扔到用户目录

## zsh

- 复制`.zshrc`

- 到`~/.zsh`目录中运行`zsh-plug.sh`脚本


