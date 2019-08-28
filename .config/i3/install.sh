#!/bin/bash

echo --------------------
echo Install i3
sudo apt install -y i3 i3blocks

echo --------------------
echo Numlock on
sudo apt install -y numlockx
numlockx on

echo --------------------
echo Wallpapers
sudo apt install -y feh variety

echo --------------------
echo Icons, themes, mouse
sudo apt install -y lxappearance

echo --------------------
echo Screenshot desktop
sudo apt install -y scrot

echo --------------------
echo Non active window transparency
sudo apt install -y compton

echo --------------------
echo Get mouse out of way
sudo apt install -y unclutter

echo --------------------
echo Sound systray
sudo apt install -y pasystray

echo --------------------
echo conky
sudo apt install -y conky

echo --------------------
echo Notification
sudo apt install -y dunst

echo --------------------
echo File Browser
sudo apt install -y nemo

echo --------------------
echo Rofi dmenu replacement
sudo apt install -y rofi
