#!/usr/bin/env bash

pacman_packages=(
    # Hyprland & Wayland
    hyprland hyprlock uwsm xdg-desktop-portal-hyprland xdg-desktop-portal-wlr xdg-desktop-portal-gtk
    grim slurp hyprshot swaync waybar rofi rofi-emoji rofimoji wlogout yad

    # Wallpaper & theming
    nwg-look adw-gtk-theme kvantum-qt5
    qt5ct qt6ct qt5-wayland qt6-wayland

    # Terminal & shell
    kitty ghostty zsh tmux zoxide fzf fd fastfetch

    # File manager
    nemo gvfs dolphin yazi

    # Editor
    neovim

    # Audio & video
    pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber gst-plugin-pipewire
    mpvpaper obs-studio vlc celluloid cava waybar-cava

    # Fonts
    ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk noto-fonts-emoji

    # System utils
    btop htop cliphist network-manager-applet networkmanager polkit-kde-agent
    pacman-contrib git wget zip stow npm rust python313

    # Display & GPU
    sddm intel-media-driver libva-intel-driver vulkan-intel vulkan-radeon vulkan-nouveau
    lib32-mesa lib32-vulkan-radeon xorg-server xorg-xinit

    # Input method (Japanese)
    fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-bamboo

    # Apps
    keepass gnome-characters gnome-keyring gnome-calculator evince loupe
    libreoffice-fresh kdenlive flatpak discord spotify steam
    libvips libheif openslide poppler-glib

    # KDE apps
    kclock

    # Misc
    tty-clock-git awww resvg smartmontools
)

aur_packages=(
    # Theming
    ttf-segoe-ui-variable sddm-astronaut-theme apple_cursor whitesur-icon-theme tint

    # Apps
    notion-app-electron notion-calendar-electron-fixed google-chrome
    obsidian-bin visual-studio-code-bin
    the-honkers-railway-launcher-bin

    # Utils
    yay mpvpaper wofi
)

sudo pacman -S --noconfirm "${pacman_packages[@]}"
yay -S --noconfirm "${aur_packages[@]}"
