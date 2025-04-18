
# FONTS:
PACMAN: ttf-roboto noto-fonts ttf-baekmuk noto-fonts-emoji gnu-free-fonts ttf-arphic-uming ttf-indic-otf


AUR: ttf-ms-fonts ttf-mplus-git otf-openmoji

| Font Name       | Pacman       | AUR                | Description                                                                                                                                       |
| --------------- | ------------ | ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| Roboto          | (ttf-roboto) | X                  | Default font for newer Android versions where it is complemented by Noto fonts for languages not supported like CJK                               |
| Noto fonts      | (noto-fonts) | X                  | Google font family with full Unicode coverage if installed with its emoji and CJK optional dependencies                                           |
| Microsoft fonts | X            | (ttf-ms-fonts^AUR) | Andalé Mono, Courier New, Arial, Arial Black, Comic Sans, Impact, Lucida Sans, Microsoft Sans Serif, Trebuchet, Verdana, Georgia, Times New Roman |


### Localization
| Font Name             | Pacman      | AUR              | Description                                                                                                                 |
| --------------------- | ----------- | ---------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Localization/Japanese | X           | ttf-mplus-gitAUR | Modern Gothic style Japanese outline fonts. It includes all of Japanese Hiragana/Katakana, Basic Latin, Latin-1 Supplement, | Latin Extended-A, IPA Extensions and most of Japanese Kanji, Greek, Cyrillic, Vietnamese with 7 weights (proportional) or 5 weights (monospace). |
| Localization/Korean   | ttf-baekmuk | X                | Collection of Korean TrueType fonts                                                                                         |

### Emojis
| Font Name  | Pacman                                              | AUR             | Description                                                                                                                                                      |
| ---------- | --------------------------------------------------- | --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Noto-Emoji | noto-fonts-emoji                                    | x               | Google's open-source Emoji 14.0.                                                                                                                                 |
| Emoji      | X                                                   | otf-openmojiAUR | German University of Design in Schwäbisch Gmünd open-source Emoji 13.0.                                                                                          |
| Kaomoji    | gnu-free-fonts, ttf-arphic-uming, and ttf-indic-otf | X               | Kaomoji are sometimes referred to as "Japanese emoticons" and are composed of characters from various character sets, including CJK and Indic fonts. For example |




### Extra Win fonts (fixes some wine fonts)

| Font Name                           | Pacman | AUR                                   | Description                                                                                                                                                                                        |
| ----------------------------------- | ------ | ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Windows 10 fonts & Windows 11 fonts | X      | ttf-ms-win10-auto & ttf-ms-win11-auto | These automatically fetch the Windows Enterprise 90-day evaluation edition and extracts the required fonts from it                                                                                 |
| Legacy packages                     | X      | ttf-ms-fonts                          | includes: Andalé Mono, Arial, Arial Black, Comic Sans, Courier New, Georgia, Impact, Lucida Sans, Lucida Console, Microsoft Sans Serif, Times New Roman, Trebuchet, Verdana, Webdings dependencies |
| Legacy packages                     | X      | ttf-vista-fonts                       | Calibri, Cambria, Candara, Consolas, Constantia, Corbel                                                                                                                                            |
| Legacy packages                     | X      | ttf-tahoma                            | Tahoma                                                                                                                                                                                             |




### Fontconfig rules useful for MS Fonts




Often websites specify the fonts using generic names (helvetica, courier, times or times new roman) and a rule in fontconfig maps these names to free fonts (Liberation, Google CrOS, GUST TeX Gyre...). The substitutions are defined in **/etc/fonts/conf.d/30-metric-aliases.conf**.

To make full use of the Ms Windows fonts it is necessary to create a rule mapping those generic names to the Ms Windows specific fonts contained in the various packages above:

```Bash
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
       <alias binding="same">
         <family>Helvetica</family>
         <accept>
         <family>Arial</family>
         </accept>
       </alias>
       <alias binding="same">
         <family>Times</family>
         <accept>
         <family>Times New Roman</family>
         </accept>
       </alias>
       <alias binding="same">
         <family>Courier</family>
         <accept>
         <family>Courier New</family>
         </accept>
       </alias>
</fontconfig>
```

***as seen in the [arch wiki](https://wiki.archlinux.org/title/Microsoft_fonts)***