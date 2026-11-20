# Désmothène Zeus — expérience promo

Page web (HTML/CSS/JS, sans framework ni serveur spécial) :
**ENTRER → teaser vidéo → touche OUT NOW → les portes s'ouvrent → 18 extraits d'1 minute max.**

## Fichiers
| Fichier | Rôle |
|---|---|
| `index.html` | l'expérience complète. La config (titres, durée max, liens Spotify) est en haut du `<script>`. |
| `.vercelignore` | fichiers de travail non publiés sur le site |
| `assets/teaser.mp4` | ta vidéo |
| `assets/outnow.jpg` | dernière image de la vidéo (sert à l'animation d'ouverture) |
| `assets/cover.jpg` | pochette (640 px, depuis Spotify) |
| `audio/` | **à remplir** : `01.mp3` … `18.mp3` |
| `make_clips.sh` + `clips.csv` | coupe les extraits de 60 s à partir des masters |

## Ajouter les vrais extraits
1. Mets les masters dans un dossier, nommés `01.wav` … `18.wav`.
2. Dans `clips.csv`, mets la seconde de départ de chaque extrait (le refrain, la meilleure punchline).
3. Lance le script :
   ```bash
   ./make_clips.sh /chemin/vers/masters
   ```
4. Commit + push : Vercel redéploie automatiquement.

## Tester en local
```bash
python3 -m http.server 8000
```
Puis ouvre http://localhost:8000. Un double-clic sur le fichier marche aussi, mais sans le visualiseur audio réel.

## Mettre en ligne
C'est un site statique. Glisse le dossier sur Netlify Drop, Vercel ou GitHub Pages. Tu obtiens un lien pour la bio Instagram ou TikTok.

## Points d'attention
- **Les 60 s doivent venir des fichiers, pas du code.** Si tu mets les titres entiers en ligne et que le code coupe à 60 s, n'importe qui peut les télécharger depuis l'onglet réseau du navigateur. N'envoie que des extraits déjà coupés.
- **Droits.** Les extraits viennent des masters du label (Le Syndicat). L'API Spotify ne fournit plus d'extraits audio pour les nouvelles apps. Le lecteur intégré de Spotify joue le titre entier aux personnes connectées, donc la règle de la minute ne tiendrait pas.
- **Orthographe du titre.** Spotify affiche « Dé**smo**thène Zeus », mais le titre 1 s'appelle « Dé**mos**thène blues » et un autre projet s'appelle « Démosthène ». À vérifier avec le distributeur : si c'est une coquille, corrige aussi la constante `ALBUM.title` et les deux titres en dur dans `index.html`.
- La progression de la pochette est gardée dans le navigateur (`localStorage`). Elle se perd en navigation privée, ce qui n'est pas grave.
