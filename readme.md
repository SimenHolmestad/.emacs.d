# .emacs.d
Konfigurasjonsfilen min til text-editoren emacs, som er ganske kul. Konfigurasjonen er skrevet i org-mode som gjør filen mye mer oversiktlig når man åpner den i emacs. Kodeblokkene inne org-filen blir kjørt av emacs ved oppstart (med `org-babel-load-file` i `init.el`), mens resten av org-filen blir ignorert.

## Hvordan kjøre emacs med denne konfigurasjonen
1. Last ned emacs. Dette kan gjøres ved å følge [denne guiden](https://www.gnu.org/software/emacs/download.html)
2. Klon deretter dette repoet inn i din hjemmefolder (`~/`). Folderen skal altså være `~/.emacs.d`
3. Kjør emacs

Det er en del pakker som blir innstallert første gang du kjører programmet, og det vil da ta lenger tid å starte programmet denne gangen.

Det kommer noen compile-advarsler etter første oppstart av programmet. Dette kan være verdt å undersøke.