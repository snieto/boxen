class people::pedrogimenez {
  $home     = "/Users/${::luser}"
  $my       = "${home}/my"
  $dotfiles = "${my}/.dotfiles"

  repository { $dotfiles:
    source  => 'pedrogimenez/dotfiles',
    require => File[$my]
  }

  # OS X
  include osx::finder::unhide_library
  include osx::finder::empty_trash_securely
  include osx::finder::show_external_hard_drives_on_desktop
  include osx::dock::autohide
  include osx::dock::clear_dock
  include osx::global::expand_save_dialog
  include osx::dock::icon_size
  include osx::global::key_repeat_rate
  include osx::global::key_repeat_delay

  class { 'osx::global::key_repeat_delay':
    delay => 0
  }

  class { 'osx::dock::icon_size': 
    size => 48
  }

  # DEV
  include openssl
  include php::5_4
  include postgresql
  include virtualbox
  include java
  include heroku
  include iterm2::stable
  include wget
  include zsh
  include clojure
  include vim

  vim::bundle { [
    'scrooloose/syntastic',
    'scrooloose/nerdtree',
    'godlygeek/tabular',
    'airblade/vim-gitgutter',
    'vim-ruby/vim-ruby',
    'rizzatti/dash.vim',
    'flazz/vim-colorschemes',
    'tpope/vim-endwise',
    'Townk/vim-autoclose',
    'Lokaltog/powerline',
    'tpope/vim-fugitive',
    'sjl/badwolf'
  ]: }

  file { "${vim::vimrc}":
    target  => "${dotfiles}/.vimrc",
    require => Repository["${dotfiles}"]
  }

  include ctags
  include github_for_mac

  # APPS
  include transmit
  include vlc
  include onepassword
  include dropbox
  include textual
  include brow
  include calibre
  include chrome
  include transmission
  include alfred
  include firefox
  include propane
}
