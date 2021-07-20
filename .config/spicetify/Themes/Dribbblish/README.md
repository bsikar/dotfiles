# Dribbblish

## Install
```bash
cd "$(dirname "$(spicetify -c)")/Themes/Dribbblish"
mkdir -p ../../Extensions
cp dribbblish.js ../../Extensions/
spicetify config extensions dribbblish.js
spicetify config current_theme Dribbblish
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify apply
```

## Patch
From Spotify > v1.1.62, in sidebar, they use an adaptive render mechanic to actively show and hide items on scroll. It helps reducing number of items to render, hence there is significant performance boost if you have a large playlists collection. But the drawbacks is that item height is hard-coded, it messes up user interaction when we explicity change, in CSS, playlist item height bigger than original value. So you need to add these 2 lines in Patch section in config file:
```ini
[Patch]
xpui.js_find_8008 = ,(\w+=)32,
xpui.js_repl_8008 = ,${1}56,
```

## Uninstall
```
spicetify config extensions dribbblish.js-
```
And remove Patch lines you added in config file earlier. Finally, run:
```
spicetify apply
```
