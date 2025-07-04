# Cartes Duel University

Ce dépôt contient les cartes custom utilisées par le serveur Duel University pour le simulateur Edopro.
Les cartes ont déjà été testées et devraient fonctionner normalement, merci de créer un post dans "Issues" au moindres problème, avec autant de détails que possible et accompagné des codes d'erreur s'il y en a.

Je ne possède aucun artwork utilisé pour les cartes.

## Installation des cartes custom

Pour obtenir les cartes, il faut d'abord installer le fichier de configuration.
Ce fichier se nomme ``user_configs.json`` et se trouvera dans ```.../ProjectIgnis/config```

### 1er cas : Pas de fichier déjà installé

Si vous ne possédez pas encore le fichier, vous pouvez le télécharger [**ICI**](https://drive.google.com/file/d/1GC1vScvBaAPDsibMUON1Yi5CTUG6EdOn/view?usp=drive_link), ou bien le créer vous même.
Pour ce faire, copiez-coller le contenue suivant à l'intérieur :
```json
{
   "repos": [
      {
         "url": "https://github.com/Este98/Cartes-DU",
         "repo_name": "Duel University Custom Card",
         "repo_path": "./repositories/Duel University",
         "should_update": true,
         "should_read": true
      }
	]
}
```

Et voilà. Si tout est bien fait, vous devriez voir ceci en ouvrant EdoPro: 

<p align="center">
<img src="https://github.com/Este98/Cartes-DU/blob/23b502184916bc25cccd6b534e6aa07145dd1c06/success_installation.jpg" >
</p>

 Vous pouvez maintenant passer à l'étape suivante.

<details>
<summary>

### 2e cas : Fichier déjà installé
</summary>
<p>

TODO

</p>
</details>

## Utiliser les cartes custom

