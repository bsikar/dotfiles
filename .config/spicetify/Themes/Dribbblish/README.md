# Dribbblish

## Install
```bash
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
cd "$(dirname "$(spicetify -c)")/Themes/Dribbblish"
mkdir -p ../../Extensions
cp dribbblish.js ../../Extensions/
spicetify config extensions dribbblish.js
spicetify config current_theme Dribbblish color_scheme gruv
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify apply
```

## Uninstall
```
spicetify config extensions dribbblish.js-
```
And remove Patch lines you added in config file earlier. Finally, run:
```
spicetify apply
```
