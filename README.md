## dependency

Vim 7.4+, with python support
Or run `apt_install_vim.sh` to build vim from source.(Only for Debian/Ubuntu)

### system

```
sudo [apt-get] install ctags build-essential cmake python-dev
```

### python

```
sudo pip install pyflakes pylint pep8(or simply pip install -r vim-requirements.txt)
```

### javascript

```
sudo npm install -g jshint
cd ~/.vim/bundle/tern_for_vim && npm install
```
