default['vim']['install_method'] = "source",
default['vim']['source']['version'] = '7.4'
default['vim']['source']['prefix'] = "/usr/local"
default['vim']['source']["checksum"] = "d0f5a6d2c439f02d97fa21bd9121f4c5abb1f6cd8b5a79d3ca82867495734ade"
default['vim']['source']["configuration"] = "--enable-fontset --without-x --disable-darwin --disable-selinux --enable-luainterp --enable-perlinterp --enable-tclinterp --enable-pythoninterp --enable-rubyinterp --enable-cscope --enable-multibyte --with-features=huge",
default['vim']['source']["dependencies"] = [
    "python-devel",
    "ncurses",
    "ncurses-devel",
    "ruby-devel",
    "perl-devel",
    "perl-ExtUtils-Embed",
    "ctags",
    "gettext",
    "tcl-devel",
    "lua",
    "lua-devel",
    "gcc",
    "make"
]
