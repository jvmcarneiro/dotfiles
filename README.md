
dotfiles
========

A collection of configuration files (and some other worth keeping stuff) that I use in my systems, managed with [stow](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html).

It's unusual
------------

It differs from other repositories through the way I target `stow` to `/` instead of `~` using a global `~/.stowrc`:

```
$ cat ~/.stowrc
--dir=/home/jcarneiro/dotfiles
--target=/
--ignore=.+~
--ignore=\.git
--ignore=\.gitignore
--ignore=^/README.*
--ignore=^/LICENSE.*
```

That way I can effortlessly stow configuration files outside of `~`, having a dotfiles folder structured like:

```
home/
  username/
    dotfiles/
      bash/
        home/
          jcarneiro/
            .bashrc
      vim/
        home/
          jcarneiro/
            .vim/
              [...some files]
            .vimrc
      xorg/
        etc/
          X11/
            xorg.conf
```

Adding files
------------

I also developed [stow-to](https://gist.github.com/jvmcarneiro/1d4349b1ee769ccff3f81be7b4a37c70), a script that automatically moves a given file from anywhere to the `~/dotfiles` directory (it must be named like that) while maintaining correct folder hierarchy. It also stows it after.

### For example:

Saving your `Xorg` configs in `/etc` to your dotfiles is as simple as: 

```
$ cd /etc
$ stow-to xorg X11
```

With `xorg` being the name of the program the dotfiles belong to, and `X11` being the name of folder or file to be moved there.

The above example will generate a structure like:

```
home/
  username/
    dotfiles/
      xorg/
        etc/
          X11/
            xinit/
              xinitrc.d/
                50-systemd-user.sh
              xinitrc
              xserverrc
            xorg.conf
            xorg.conf.d/
              00-keyboard.conf
              30-touchpad.conf
```

And `$ stow xorg` would generate the correct symlinks in `/etc/X11`, if `stow-to` hadn't already done so.

---

Feel free to do whatever with it all :)

### Personal to-dos when installing (for reference)

* Move the three .pem keys to `~/.task/`;
* `:PlugInstall` in vim;
* Install `qt5-styleplugins`;
* Install `ttf-roboto`, `ttf-roboto-mono` and `ttf-roboto-slab` from aur;
* Install `numix-icon-theme-git` and `gtk-theme-numix-solarized-git` from the aur;
* Import pass' gpg keys;
* Generate and send pub ssh key to server.
