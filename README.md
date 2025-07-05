# Cartes Duel University

Ce dépôt contient les cartes custom utilisées par le serveur Duel University pour le simulateur Edopro.
Les cartes ont déjà été testées et devraient fonctionner normalement, merci de créer un post dans "Issues" au moindres problème, avec autant de détails que possible et accompagné des codes d'erreur s'il y en a.

Je ne possède aucun artwork utilisé pour les cartes.

## Installation des cartes custom

Pour obtenir les cartes, il faut d'abord installer le fichier de configuration.
Ce fichier se nomme ``user_configs.json`` et se trouvera dans ```.../ProjectIgnis/config```

### 1er cas : Pas de fichier déjà installé

Si vous ne possédez pas encore le fichier, vous pouvez télécharger l'archive [__ICI__](https://downgit.github.io/#/home?url=https://github.com/Este98/Cartes-DU/blob/asset/user_configs.json) (le fichier se trouve à l'intérieur), ou bien le créer vous-même.
Pour ce faire, copiez-coller le contenue suivant à l'intérieur :
```json
{
   "repos": [
      {
         "url": "https://github.com/Este98/Cartes-DU",
         "repo_name": "Duel University Custom Cards",
         "repo_path": "./repositories/Duel University",
         "should_update": true,
         "should_read": true
      }
	]
}
```

Et voilà ! Si tout est bien fait, vous devriez voir ceci en ouvrant EdoPro: 

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

## Utiliser les cartes custom en duel

Dans un premier temps, il faut aller télécharger le [__client Zerotier__](https://www.zerotier.com/download/). Une fois fait, lancez l'installation. 

**!!! Si votre système vous demande d'autoriser les autres appareils du réseau à vous détecter, dites oui ! Sans quoi ça ne fonctionnera pas. !!!**


Vous devriez maintenant voir cette icône dans votr barre des tâches :

<p align="center">
<img src= "https://github.com/Este98/Cartes-DU/blob/asset/zerotier_icone.jpg">
</p>

Cliquez dessus, et cette petite fenêtre va s'afficher :

<p align="center">
<img src="https://github.com/Este98/Cartes-DU/blob/asset/zerotier_windows.jpg">
</p>

La flèche rouge indique votre adresse par lequel le réseau va vous identifier. Pour les membres du serveur **Duel University**, merci d'envoyer cette adresse en mp à **Este** à des fins de gestion.

Ensuite, cliquez sur la flèche jaune, "Join New Network", pour rejoindre le réseau virtuel.
Pour les membres de la **Duel University**, l'adresse à rentrer se trouve sur le Discord.


Si tout s'est bien passé, félicitations, vous êtes connecté !
Il ne vous reste plus qu'à lancer Edopro, dans **Local + AI** et d'host une partie, et votre adversaire pourra cliquer sur "Refresh" pour vous trouver.