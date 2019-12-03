# .emacs.d
Konfigurasjonsfilen min til text-editoren emacs, som er ganske kul. Konfigurasjonen er skrevet i org-mode som gjør filen mye mer oversiktlig når man åpner den i emacs. Kodeblokkene inne org-filen blir kjørt av emacs ved oppstart (med `org-babel-load-file` i `init.el`), mens resten av org-filen blir ignorert.

## Hvordan kjøre emacs med denne konfigurasjonen
1. Last ned emacs. Dette kan gjøres ved å følge [denne guiden](https://www.gnu.org/software/emacs/download.html), evnt kan man gjøre det på [denne måten](https://github.com/railwaycat/homebrew-emacsmacport) (med `brew cask`) for å få en versjon med ekstra funksjonalitet for OSX, som for eksempel retina-support.
2. Klon deretter dette repoet inn i din hjemmefolder (`~/`). Folderen skal altså være `~/.emacs.d`
3. Kjør emacs

Det er en del pakker som blir innstallert første gang du kjører emacs, og det vil da ta lenger tid å starte denne gangen.

Det kommer noen compile-advarsler etter første oppstart av programmet. Dette kan være verdt å se litt på, men har ikke merket noe særlig problemer med det ennå.

Filen init.el kommer til å endre seg når man kjører emacs første gangen, og burde ikke commites etter dette. For å sørge for at init.el ikke vises i git kan man kjøre
```
git update-index --assume-unchanged init.el
```
Og for å gjøre om operasjonen over kan kan man kjøre
```
git update-index --no-assume-unchanged init.el
```
