program bataille_naval_;

uses crt;

//programme de bataille naval anthony lamour

{ALGO bataille naval
BUT créer un jeu de bataille naval
ENTREE positionnement des navires et cases visées
SORTIE touché ou raté et victoire d'un des deux joueurs
//précision les deux flottes sont sur la même grille et aucun des deux joueurs ne peut toucher sa propre flotte
//ni poser son bateau sur un autre peut importe sa flotte, si un joueur touche un navire alors il rejoue

// CONSTANTE

CONST
	MAX=10 //taille de la grille de jeu MAX*MAX

// TYPES

Type cellule = enregistrement	//création du type cellule composé des champs ligne et colonne

        ligne,colonne:ENTIER 

FINENREGISTREMENT

Type ensemble_cel=tableau[1..50] de cellule //création du type ensemble_cel qui sera un tableau regroupant toute les cellules créées sa taille est 50 car il y aura 5 cellules par bateau et 5 bateaux par flotte et 2 flottes

Type Tabbat=tableau[1..5] de cellule	//création du type Tabbat un tableau de 5 cellules 

Type bateau = enregistrement	//création du type bateau composé d'un Tabbat

        bat:Tabbat 

FINENREGISTREMENT

Type Tabflot=tableau[1..5] de bateau //création du type Tabflot un tableau de 5 bateaux

Type flotte = enregistrement	//création du type flotte composé d'un Tabflot et d'un numéro de joueur

        numero_joueur:ENTIER 
		flot:Tabflot 

FINENREGISTREMENT

// FONCTIONS

fonction creation_cellule(ligne,colonne:ENTIER):cellule //ligne et colonne sont la ligne et la colonne rentrée par l'utilisateur
BUT créer une cellule à partir d'une ligne et d'une colonne
ENTREE ligne et colonne
SORTIE la cellule

VAR
	res:cellule //res sera la cellule créée
DEBUT
	res.ligne<-ligne 
	res.colonne<-colonne 
	creation_cellule<-res //la fonction renvoie la cellule terminée
FINFONCTION

fonction comparer_2_cellule(cellule1,cellule2:cellule):booleen
BUT comparer la ligne et la colonne de deux cellules si elle sont identiques on renvoie vrai
ENTREE les deux cellules
SORTIE vrai ou faux

VAR
	res:booleen //res sera le booleen renvoyé 
DEBUT
	res<-FAUX //initialisation de res
	SI (cellule1.ligne=cellule2.ligne) ET (cellule1.colonne=cellule2.colonne) ALORS
		res<-VRAI //res prend la valeur vrai si la ligne et la colonne des deux cellules sont identiques
	FINSI
	comparer_2_cellule<-res //la fonction renvoie vrai ou faux
FINFONCTION

fonction verif_cel_bat(tab:ensemble_cel,cel:cellule):booleen
BUT vérifier si une cellule appartient à un bateau
ENTREE la cellule et l'ensemble des cellules créées (car nous ne crérons que les cellules appartenant aux bateaux)
SORTIE vrai ou faux
VAR
	res:booleen  //res sera le booleen renvoyé
	i:ENTIER //i sert a se déplacer dans l'ensemble de cellules
DEBUT
	res<-FAUX //initialisation de res
	i<-0 //initialisation de i
	REPETER
		i<-i+1 //i prend i+ pour parcourir chaque case de l'ensemble de cellules
		SI (cel.ligne=tab[i].ligne) ET (cel.colonne=tab[i].colonne) ALORS //si la ligne et la colonne sont identiques alors res prend la valeur vrai
			res<-VRAI 
		FINSI
	JUSQU'A (res=VRAI) OU (i=50) //jusqu'a ce que res soit vrai ou que i=50 car l'ensemble de cellules a une taille de 50
	SI (cel.ligne<0) OU (cel.colonne<0) OU (cel.ligne>MAX) OU (cel.colonne>MAX)ALORS
		res<-VRAI //vérification de si l'utilisateur à entrée des valeurs valides
	FINSI
	verif_cel_bat<-res //renvoie vrai ou faux
FINFONCTION

fonction creation_de_bateau(cel:cellule,taille,direction:ENTIER,tab:ensemble_cel):bateau
BUT créer un bateau a partir d'une cellule d'origine, d'une taille et d'une direction
ENTIER cellule d'origine du bateau, taille du bateau et direction du bateau
SORTIE le bateau construit ou rien si le bateau n'a pas pu se construire

VAR
	res:bateau //sera le bateau fini ou vide
	test:booleen //test va vérifier si les cases du bateau sont valides ou si elles existent déjà
	cel2:cellule //cel2 va permettre d'enregistré la cellule créer puis de vérifier si elle est valide
	i,compteur:ENTIER 	//i va nous permettre de créer chaque cellule du bateau et compteur de vérifier que au moins une case est non valide
DEBUT
	compteur<-0 //initialisation de compteur
	test<-verif_cel_bat(tab,cel) //vérification que la cellule d'origine est valide
	SI test=FAUX ALORS	//si elle est valide alors on construit le bateau
		res.bat[1]<-cel // la première cellule du bateau sera la cellule d'origine
		POUR i DE 2 A taille FAIRE	//de la deuxième cellule à la taille du bateau
			CAS direction PARMI	//selon la direction on fait
				1:res.bat[i].colonne<-cel.colonne+i-1 
				  res.bat[i].ligne<-cel.ligne 
				  cel2<-res.bat[i] 
				  test<-verif_cel_bat(tab,cel2) //vérification que la cellule créée est valide
				  SI test=VRAI alors
					compteur:=compteur+1 //si la case n'est pas valide alors compteur monte de 1
				  FINSI
				2:res.bat[i].colonne<-cel.colonne 
				  res.bat[i].ligne<-cel.ligne+i-1 
				  cel2<-res.bat[i] 
				  test<-verif_cel_bat(tab,cel2)  //vérification que la cellule créée est valide
				  SI test=VRAI alors
					compteur:=compteur+1 //si la case n'est pas valide alors compteur monte de 1
				  FINSI
				3:res.bat[i].colonne<-cel.colonne 
				  res.bat[i].ligne<-cel.ligne-i+1 
				  cel2<-res.bat[i] 
				  test<-verif_cel_bat(tab,cel2) //vérification que la cellule créée est valide
				  SI test=VRAI alors
					compteur:=compteur+1 //si la case n'est pas valide alors compteur monte de 1
				  FINSI
				4:res.bat[i].colonne<-cel.colonne-i+1 
				  res.bat[i].ligne<-cel.ligne 
				  cel2<-res.bat[i] 
				  test<-verif_cel_bat(tab,cel2) //vérification que la cellule créée est valide
				  SI test=VRAI alors
					compteur:=compteur+1 //si la case n'est pas valide alors compteur monte de 1
				  FINSI
			FINCASPARMI
		FINPOUR 
	FINSI
	SI compteur>0 ALORS
		test<-VRAI
	FINSI
	SI (test=FAUX) ET (taille<>5) ALORS	//si toute les cellules crée sont valide alors on rempli le reste du bateau avec des 0
		POUR i<-taille+1 A 5 FAIRE
			res.bat[i].colonne<-0 
			res.bat[i].ligne<-0 
		FINPOUR 
	SINON
		SI test=VRAI ALORS	//si une des cellules n'est pas valide alors on rempli tout le bateau de 0
			POUR i<-1 A 5 FAIRE
				res.bat[i].colonne<-0 
				res.bat[i].ligne<-0 
			FINPOUR
		FINSI
	FINSI
	creation_de_bateau<-res //on renvoie le bateau fini ou vide
FINFONCTION

fonction creation_flotte(numJoueur:ENTIER,var tab:ensemble_cel):flotte
BUT créer une flotte
ENTREE le numéro du joueur la ligne et la colonne de départ de chaque bateau anisi que leurs direction
SORTIE la flotte du joueur

VAR
	ligne,colonne,dir:ENTIER //ligne colonne et dir sont la ligne et la colonne d'origine du bateau et sa direction
	res:flotte //res sera la flotte renvoyé 
	i,j,x:ENTIER //i,j,x servent à enregistrer chaque cellule dans l'ensemble de cellule
	cel:cellule //cel est la cellule d'origine du bateau
DEBUT
	ECRIRE"Création de la flotte du joueur numéro ",numJoueur 
	res.numero_joueur<-numJoueur //le numéro du joueur prend la valeur 1 ou 2
	REPETER
		REPETER
			ECRIRE"Veuillez entrer une ligne et un colonne de départ pour votre porte-avion (taille 5) (entre 1 et '&MAX&") :" 
			LIRE ligne //demande de la ligne et la colonne de la cellule d'origine du bateau
			LIRE colonne
		JUSQU'A (ligne>0) ET (ligne<=MAX) ET (colonne>0) ET (colonne<=MAX) //jusqu'a ce que la ligne et la colonne soient valables
		cel<-creation_cellule(ligne,colonne) //création de la cellule d'origine 
		REPETER
			ECRIRE"Veuillez entrer une direction 1:droite 2:bas 3:haut 4:gauche" 
			LIRE dir //demande de la direction du bateau
		JUSQU'A (dir>0) ET (dir<5) // vérification que la direction est valide
		res.flot[1]<-creation_de_bateau(cel,5,dir,tab) //création du bateau à partir de sa cellule d'origine de sa taille et de sa direction
	JUSQU'A res.flot[1].bat[1].ligne>0 //jusqu'a ce que toute les cases du bateau soient valide
	i<-1 //initialisation de i
	TANT QUE (tab[i].ligne<>0) ET (tab[i].colonne<>0) FAIRE
		i<-i+1 //tant que la case de l'ensemble de cellule est occupée i prend i+1 i sera le point de départ de l'enregistrement de chaque cellule du bateau dans l'ensemble de cellule
	FINTANTQUE
	x<-1 //initialisation de x  x nous permettera d'enregistrer toutes les cellules du bateau
	POUR j<-i A i+4 FAIRE //j permettera de passer d'une case à l'autre de l'ensemble de cellule
		tab[j].ligne<-res.flot[1].bat[x].ligne 
		tab[j].colonne<-res.flot[1].bat[x].colonne 
		x<-x+1 
	FINPOUR
	//on refait les mêmes instruction pour chaque bateau en changeant juste la taille et leur position dans la flotte
	REPETER
		REPETER
			ECRIRE"Veuillez entrer une ligne et un colonne de départ pour votre croiser (taille 4) (entre 1 et "&MAX&") :" 
			LIRE ligne 
			LIRE colonne 
		JUSQU'A (ligne>0) ET (ligne<=MAX) ET (colonne>0) ET (colonne<=MAX) 
		cel<-creation_cellule(ligne,colonne) 
		REPETER
			ECRIRE"Veuillez entrer une direction 1:droite 2:bas 3:haut 4:gauche" 
			LIRE dir 
		JUSQU'A (dir>0) ET (dir<5) 
		res.flot[2]<-creation_de_bateau(cel,4,dir,tab) 
	JUSQU'A res.flot[2].bat[1].ligne<>0 
	i<-1 
	TANT QUE (tab[i].ligne<>0) ET (tab[i].colonne<>0) FAIRE
		i<-i+1 
	FINTANTQUE
	x<-1 
	POUR j<-i A i+4 FAIRE
		tab[j]<-res.flot[2].bat[x] 
		x<-x+1 
	FINPOUR 
	REPETER
		REPETER
			ECRIREVeuillez entrer une ligne et un colonne de départ pour votre contre-torpilleurs (taille 3) (entre 1 et "&MAX&") :" 
			LIRE ligne
			LIRE colonne
		JUSQU'A (ligne>0) ET (ligne<=MAX) ET (colonne>0) ET (colonne<=MAX) 
		cel<-creation_cellule(ligne,colonne) 
		REPETER
			ECRIRE"Veuillez entrer une direction 1:droite 2:bas 3:haut 4:gauche" 
			LIRE dir 
		JUSQU'A (dir>0) ET (dir<5) 
		res.flot[3]<-creation_de_bateau(cel,3,dir,tab) 
	JUSQU'A res.flot[3].bat[1].ligne<>0 
	i<-1 
	TANT QUE (tab[i].ligne<>0) ET (tab[i].colonne<>0) FAIRE
		i<-i+1 
	FINTANTQUE 
	x<-1 
	POUR j<-i A i+4 FAIRE
		tab[j]<-res.flot[3].bat[x] 
		x<-x+1 
	FINPOUR
	REPETER
		REPETER
			ECRIRE"Veuillez entrer une ligne et un colonne de départ pour votre sous-marin (taille 3) (entre 1 et "&MAX&") :" 
			LIRE ligne 
			LIRE colonne 
		JUSQU'A (ligne>0) ET (ligne<=MAX) ET (colonne>0) ET (colonne<=MAX) 
		cel<-creation_cellule(ligne,colonne) 
		REPETER
			ECRIRE"Veuillez entrer une direction 1:droite 2:bas 3:haut 4:gauche" 
			LIRE dir 
		JUSQU'A (dir>0) ET (dir<5) 
		res.flot[4]<-creation_de_bateau(cel,3,dir,tab) 
	JUSQU'A res.flot[4].bat[1].ligne<>0 
	i<-1 
	TANT QUE (tab[i].ligne<>0) ET (tab[i].colonne<>0) FAIRE
		i<-i+1 
	FINTANTQUE
	x<-1 
	POUR j<-i A i+4 FAIRE
		tab[j]<-res.flot[4].bat[x] 
		x<-x+1 
	FINPOUR
	REPETER
		REPETER
			ECRIRE"Veuillez entrer une ligne et un colonne de départ pour votre  torpilleur (taille 2) (entre 1 et "&MAX&") :" 
			LIRE ligne
			LIRE colonne
		JUSQU'A (ligne>0) ET (ligne<=MAX) ET (colonne>0) ET (colonne<=MAX) 
		cel<-creation_cellule(ligne,colonne) 
		REPETER
			ECRIRE"Veuillez entrer une direction 1:droite 2:bas 3:haut 4:gauche" 
			LIRE dir
		JUSQU'A (dir>0) ET (dir<5) 
		res.flot[5]<-creation_de_bateau(cel,2,dir,tab) 
	JUSQU'A res.flot[5].bat[1].ligne<>0 
	i<-1 
	TANT QUE (tab[i].ligne<>0) ET (tab[i].colonne<>0) FAIRE
		i<-i+1 
	FINTANTQUE 
	x<-1 
	POUR j<-i A i+4 FAIRE
		tab[j]<-res.flot[5].bat[x] 
		x<-x+1 
	FINPOUR 
	creation_flotte<-res //on renvoie la flotte
FINFONCTION

fonction verif_cel_flotte(var num_bat:ENTIER var num_cel:ENTIER cel:cellule F:flotte):booleen
BUT vérifier si une cellule apparteint à une flotte
ENTREE cellule et flotte
SORTIE vrai ou faux

VAR
	res:booleen //res sera le booleen renvoyé
	i,j:ENTIER //i et j vont permettre de parcourir toutes les cellules de tout les bateaux de la flotte
	cel2:cellule //cel2 permet de comparer les cellules
DEBUT

	num_bat<-0 //initialisation de num_bat et num_cel qui retiendront la position exact de la cellule touchée
	num_cel<-0 
	res<-FAUX //initialisation de res
	POUR i<-1 A 5 FAIRE //pour chaque bateaux de la flotte
		POUR j<-1 A 5 FAIRE //pour chaque cellule du bateau
			cel2<-F.flot[i].bat[j] 
			res<-comparer_2_cellule(cel,cel2) //vérifier que la cellule apparteint à la flotte
			SI (res=VRAI) ET (num_bat=0) ALORS
				num_bat<-i //si elle y apparteint alors on retient sa position (le numéro du bateau et de la cellule)
				num_cel<-j 
			FINSI
		FINPOUR 
	FINPOUR
	SI num_bat<>0 ALORS //on renvoie vrai si num_bat est différent de 0
		res<-VRAI 
	FINSI 
	verif_cel_flotte<-res //renvoie vrai ou faux
FINFONCTION

fonction verif_destruction_bateau(F:flotte,num_bat:ENTIER):booleen;
BUT vérifier qu'un bateau est entièrement détruit
ENTREE une flotte et un numéro de bateau
SORTIE vrai ou faux
VAR
	res:booleen //sera le booleen renvoyé
	i,compteur:ENTIER //i servira à vérifier chaque cellule du bateau et compteur à retenir le nombre de cellules vides
DEBUT

	compteur<-0
	res<-faux //initialisation de res 
	POUR i DE 1 A 5 FAIRE //pour chaque cellules du bateau
		SI (F.flot[num_bat].bat[i].ligne=0) ET (F.flot[num_bat].bat[i].colonne=0) ALORS
			compteur<-compteur+1 //si elle est vide comparer monte de 1
		FINSI
	FINPOUR
	SI compteur=5 ALORS //si toute les cellules sont vides 
		res<-vrai //res prend la valeur vrai
	FINSI
	verif_destruction_bateau<-res //renvoie vrai ou faux
	
FINFONCTION

fonction verif_destruction_flotte(F:flotte):booleen
BUT vérifier si une flotte est totalement détruite
ENTREE la flotte
SORTIE vrai si elle est totalement détruite ou faux
VAR
	i,j,compteur:ENTIER //i et j servent à parcourir la flotte et compteur sert à compter le nombre de cellule vide
	res:booleen //res est le booleen que l'on renvoie
DEBUT
	res<-FAUX //initialisation de res
	compteur<-0 //initialisation de compteur
	POUR i<-1 A 5 FAIRE
		POUR j<-1 A 5 FAIRE
			SI (F.flot[i].bat[j].ligne=0) ET (F.flot[i].bat[j].colonne=0) ALORS
				compteur<-compteur+1 //à chaque cellule vide le compteur monte de 1
			FINSI
		FINPOUR 
	FINPOUR
	SI compteur=25 ALORS
		res<-VRAI //vérifier si toutes les cases sont vide
	FINSI
	verif_destruction_flotte<-res //renvoie vrai ou faux
FINFONCTION

procedure dessin_soldat
BUT dessiner un visage de soldat
ENTREE aucune
SORTIE le visage du soldat
DEBUT
	ECRIRE"   __________"
	ECRIRE"  /  soldat  \"
	ECRIRE" / __________ \"
	ECRIRE"/ /__________\ \"
	ECRIRE"|| <o>   <o>  ||"
	ECRIRE"||     {      ||"
	ECRIRE"  \    __    /"
	ECRIRE"   \  [__]  /"
	ECRIRE"    \______/"
FINPROCEDURE

// ALGORITHME

VAR
	flotJ1,flotJ2:flotte 
	Tabcel:ensemble_cel 
	testVJ1,testVJ2,testtoucher:booleen 
	nbtour,ligne,colonne,num_bat,num_cel,testrejouer,i:ENTIER 
	celtire:cellule 
DEBUT

	REPETER //sert à relancer le programme
		testVJ1<-FAUX //initialisation de testVJ1 et testVJ2 qui serviront à vérifier si l'un des deux joueurs a gagné
		testVJ2<-FAUX 
		nbtour<-0 //initialisation du nombre de tour
		POUR i<-1 A 50 FAIRE //initialisation de l'ensemble de cellule
			Tabcel[i].ligne<-0 
			Tabcel[i].colonne<-0 
		FINPOUR 
		ECRIRE"Bataille naval" 
		flotJ1<-creation_flotte(1,Tabcel) //création de la flotte du joueur 1  
		flotJ2<-creation_flotte(2,Tabcel) //création de la flotte du joueur 2 
		REPETER
			nbtour<-nbtour+1 //augmentation du nombre de tours
			SI nbtour MOD 2<>0 ALORS //si le nombre de tours est impaire alors c'est le tour du joueur 1
				ECRIRE"Tour du joueur 1" 
				REPETER
					dessin_soldat
					ECRIRE"Nous attendons vos ordres amiral. Où souhaitez vous tirez ?" //demande d'une case à attaquer
					LIRE ligne 
					LIRE colonne
				JUSQU'A (ligne>0) ET (ligne<=MAX) ET (colonne>0) ET (colonne<=MAX) //vérification que les coordonnées sont valides
				celtire<-creation_cellule(ligne,colonne) //création d'une cellule visée
				testtoucher<-verif_cel_flotte(num_bat,num_cel,celtire,flotJ2) //vérification de si elle appartient à la flotte de J2 
				SI testtoucher=VRAI ALORS //SI c'est le cas alors on supprime la cellule en la remplaçant avec des 0
					//SI c'est le cas alors on supprime la cellule en la remplaçant avec des 0 
					flotJ2.flot[num_bat].bat[num_cel].ligne<-0 
					flotJ2.flot[num_bat].bat[num_cel].colonne<-0 
					SI verif_destruction_bateau(flotJ2,num_bat) ALORS //si le bateau est détruit alors 
						ECIRE"Cible détruite amiral !"// on affiche cible détruite
					SINON
						ECRIRE"Cible touchée amiral !"//sinon on affiche cible touchée
					FINSI
					nbtour<-nbtour-1	//si touché alors le joueur rejoue
					ECRIRE"L'ennemi va mettre du temps à s'en remettre."
				SINON	
					ECRIRE"Nous avons raté la cible amiral." //sinon raté
				FINSI
			SINON 
				ECRIRE"Tour du joueur 2" //si le nombre de tours est paire alors c'est le tour du joueur 2
				REPETER
					dessin_soldat
					ECRIRE"Nous attendons vos ordres amiral. Où souhaitez vous tirez ?") //demande d'une case à attaquer
					LIRE ligne 
					LIRE colonne 
				JUSQU'A (ligne>0) ET (ligne<=MAX) ET (colonne>0) ET (colonne<=MAX) //vérification que les coordonnées sont valides
				celtire<-creation_cellule(ligne,colonne) //création d'une cellule visée
				testtoucher<-verif_cel_flotte(num_bat,num_cel,celtire,flotJ1) //vérification de si elle appartient à la flotte de J1 
				SI testtoucher=VRAI ALORS 
					//SI c'est le cas alors on supprime la cellule en la remplaçant avec des 0 
					flotJ1.flot[num_bat].bat[num_cel].ligne<-0 
					flotJ1.flot[num_bat].bat[num_cel].colonne<-0 
					SI verif_destruction_bateau(flotJ1,num_bat) ALORS //si le bateau est détruit alors 
						ECIRE"Cible détruite amiral !"// on affiche cible détruite
					SINON
						ECRIRE"Cible touchée amiral !"//sinon on affiche cible touchée
					FINSI
					nbtour<-nbtour-1	//si touché alors le joueur rejoue
					ECRIRE"L'ennemi va mettre du temps à s'en remettre."
				SINON	
					ECRIRE"Nous avons raté la cible amiral." //sinon raté
				FINSI 
			FINSI
			testVJ1<-verif_destruction_flotte(flotJ2) //vérification de la victoire du joueur 1
			testVJ2<-verif_destruction_flotte(flotJ1) //vérification de la victoire du joueur 2
		JUSQU'A (testVJ1=VRAI) OU (testVJ2=VRAI) //jusqu'a ce que J1 ou J2 ai gagné
		SI testVJ1=VRAI ALORS //affichage de la victoire d'un des deux joueurs
			ECRIRE"Victoire de la flotte 1 !" 
		SINON
			ECRIRE"Victoire de la flotte 2 !" 
		FINSI 
		ECRIRE"Merci d'avoir joué" //remerciement 
		ECRIRE"Veuillez entrer 0 pour quitter ou n'importe quel autre nombre pour une revanche :" //demande si les joueurs veulent rejouer
		LIRE testrejouer 
	JUSQU'A testrejouer=0 

FIN
}

// CONSTANTE

CONST
	MAX=10; //taille de la grille de jeu MAX*MAX

// TYPES

Type
    cellule = record //création du type cellule composé des champs ligne et colonne

        ligne,colonne:integer;

end;

Type
	ensemble_cel=array[1..50] of cellule; //création du type ensemble_cel qui sera un tableau regroupant toute les cellules créées sa taille est 50 car il y aura 5 cellules par bateau et 5 bateaux par flotte et 2 flottes

Type
	Tabbat=array[1..5] of cellule; //création du type Tabbat un tableau de 5 cellules

Type
    bateau = record

        bat:Tabbat; //création du type bateau composé d'un Tabbat

end;

Type
	Tabflot=array[1..5] of bateau; //création du type Tabflot un tableau de 5 bateaux

Type
    flotte = record //création du type flotte composé d'un Tabflot et d'un numéro de joueur

        numero_joueur:integer; 
		flot:Tabflot;

end;

// FONCTIONS

function creation_cellule(ligne,colonne:integer):cellule; //ligne et colonne sont la ligne et la colonne rentrée par l'utilisateur
//BUT créer une cellule à partir d'une ligne et d'une colonne
//ENTREE ligne et colonne
//SORTIE la cellule
VAR
	res:cellule; //res sera la cellule créée
BEGIN
	res.ligne:=ligne;
	res.colonne:=colonne;
	creation_cellule:=res; //la fonction renvoie la cellule terminée
END;

function comparer_2_cellule(cellule1,cellule2:cellule):boolean;
//BUT comparer la ligne et la colonne de deux cellules si elle sont identiques on renvoie vrai
//ENTREE les deux cellules
//SORTIE vrai ou faux
VAR
	res:boolean; //res sera le booleen renvoyé 
BEGIN
	res:=FALSE; //initialisation de res
	IF (cellule1.ligne=cellule2.ligne) AND (cellule1.colonne=cellule2.colonne) THEN
		begin
			res:=TRUE; //res prend la valeur vrai si la ligne et la colonne des deux cellules sont identiques
		end;
	comparer_2_cellule:=res //la fonction renvoie vrai ou faux
END;

function verif_cel_bat(tab:ensemble_cel;cel:cellule):boolean;
//BUT vérifier si une cellule appartient à un bateau
//ENTREE la cellule et l'ensemble des cellules créées (car nous ne crérons que les cellules appartenant aux bateaux)
//SORTIE vrai ou faux
VAR
	res:boolean; //res sera le booleen renvoyé
	i:integer; //i sert a se déplacer dans l'ensemble de cellules 
BEGIN
	res:=FALSE; //initialisation de res
	i:=0; //initialisation de i
	REPEAT
		i:=i+1; //i prend i+1 pour parcourir chaque case de l'ensemble de cellules
		res:=comparer_2_cellule(cel,tab[i]);
	UNTIL (res=TRUE) OR (i=50); //jusqu'a ce que res soit vrai ou que i=50 car l'ensemble de cellules a une taille de 50
	IF (cel.ligne<0) OR (cel.colonne<0) OR (cel.ligne>MAX) OR (cel.colonne>MAX)THEN
		begin
			res:=TRUE; //vérification de si l'utilisateur à entrée des valeurs valides
		end;
	verif_cel_bat:=res; //renvoie vrai ou faux
END;

function creation_de_bateau(cel:cellule;taille,direction:integer;tab:ensemble_cel):bateau;
//BUT créer un bateau a partir d'une cellule d'origine, d'une taille et d'une direction
//ENTIER cellule d'origine du bateau, taille du bateau et direction du bateau
//SORTIE le bateau construit ou rien si le bateau n'a pas pu se construire
VAR
	res:bateau; //res sera le bateau fini ou vide
	test:boolean; //test va vérifier si les cases du bateau sont valides ou si elles existent déjà
	cel2:cellule; //cel2 va permettre d'enregistré la cellule créer puis de vérifier si elle est valide
	i,compteur:integer; //i va nous permettre de créer chaque cellule du bateau et compteur de vérifier que au moins une case est non valide
BEGIN
	compteur:=0;//initialisation de compteur
	test:=verif_cel_bat(tab,cel); //vérification que la cellule d'origine est valide
	IF test=FALSE THEN //si elle est valide alors on construit le bateau
		begin
			res.bat[1]:=cel; // la première cellule du bateau sera la cellule d'origine
			FOR i:=2 TO taille DO //de la deuxième cellule à la taille du bateau
				begin
					CASE direction of //selon la direction on fait
						1:begin
						   res.bat[i].colonne:=cel.colonne+i-1;
						   res.bat[i].ligne:=cel.ligne;
						   cel2:=res.bat[i];
						   test:=verif_cel_bat(tab,cel2);	 //vérification que la cellule créée est valide
						   IF test=TRUE THEN
							begin
								compteur:=compteur+1; //si elle n'est pas valide alors compteur monte de 1
							end;
						 end;
						2:begin
						    res.bat[i].colonne:=cel.colonne;
							res.bat[i].ligne:=cel.ligne+i-1;
							cel2:=res.bat[i];
							test:=verif_cel_bat(tab,cel2); //vérification que la cellule créée est valide
							IF test=TRUE THEN
							begin
								compteur:=compteur+1; //si elle n'est pas valide alors compteur monte de 1
							end;
						  end;
						3:begin
						    res.bat[i].colonne:=cel.colonne;
							res.bat[i].ligne:=cel.ligne-i+1;
							cel2:=res.bat[i];
							test:=verif_cel_bat(tab,cel2); //vérification que la cellule créée est valide
							IF test=TRUE THEN
							begin
								compteur:=compteur+1; //si elle n'est pas valide alors compteur monte de 1
							end;
						  end;
						4:begin
						   res.bat[i].colonne:=cel.colonne-i+1;
						   res.bat[i].ligne:=cel.ligne;
						   cel2:=res.bat[i];
						   test:=verif_cel_bat(tab,cel2); //vérification que la cellule créée est valide
						   IF test=TRUE THEN
							begin
								compteur:=compteur+1; //si elle n'est pas valide alors compteur monte de 1
							end;
						  end;
					end;
				end;
		end;
	IF compteur>0 THEN
		begin
			test:=TRUE;
		end;
	IF (test=FALSE) AND (taille<>5) THEN //si toute les cellules crée sont valide alors on rempli le reste du bateau avec des 0
		begin
			FOR i:=taille+1 TO 5 DO
				begin
					res.bat[i].colonne:=0;
					res.bat[i].ligne:=0;
				end;
		end
	ELSE
		begin
			IF test=TRUE THEN //si une des cellules n'est pas valide alors on rempli tout le bateau de 0
				begin
					FOR i:=1 TO 5 DO
						begin
							res.bat[i].colonne:=0;
							res.bat[i].ligne:=0;
						end;
				end;
		end;
	creation_de_bateau:=res; //on renvoie le bateau fini ou vide
END;

function creation_flotte(numJoueur:integer;var tab:ensemble_cel):flotte;
//BUT créer une flotte
//ENTREE le numéro du joueur la ligne et la colonne de départ de chaque bateau anisi que leurs direction
//SORTIE la flotte du joueur
VAR
	ligne,colonne,dir:integer; //ligne colonne et dir sont la ligne et la colonne d'origine du bateau et sa direction
	res:flotte; //res sera la flotte renvoyé 
	i,j,x:integer; //i,j,x servent à enregistrer chaque cellule dans l'ensemble de cellule
	cel:cellule; //cel est la cellule d'origine du bateau
BEGIN

	writeln(UTF8ToAnsi('Création de la flotte du joueur numéro '),numJoueur);
	writeln();
	res.numero_joueur:=numJoueur; //le numéro du joueur prend la valeur 1 ou 2
	REPEAT
		REPEAT
			writeln(UTF8ToAnsi('Veuillez entrer une ligne et un colonne de départ pour votre porte-avion (taille 5) (entre 1 et '),MAX,') :');
			readln(ligne); //demande de la ligne et la colonne de la cellule d'origine du bateau
			readln(colonne);
		UNTIL (ligne>0) AND (ligne<=MAX) AND (colonne>0) AND (colonne<=MAX); //jusqu'a ce que la ligne et la colonne soient valables
		cel:=creation_cellule(ligne,colonne); //création de la cellule d'origine 
		REPEAT
			writeln('Veuillez entrer une direction 1:droite 2:bas 3:haut 4:gauche');
			readln(dir); //demande de la direction du bateau
		UNTIL (dir>0) AND (dir<5); // vérification que la direction est valide
		res.flot[1]:=creation_de_bateau(cel,5,dir,tab); //création du bateau à partir de sa cellule d'origine de sa taille et de sa direction
	UNTIL res.flot[1].bat[1].ligne>0; //jusqu'a ce que toute les cases du bateau soient valide
	i:=1; //initialisation de i
	WHILE (tab[i].ligne<>0) AND (tab[i].colonne<>0) DO
		begin
			i:=i+1; //tant que la case de l'ensemble de cellule est occupée i prend i+1 i sera le point de départ de l'enregistrement de chaque cellule du bateau dans l'ensemble de cellule
		end;
	x:=1; //initialisation de x  x nous permettera d'enregistrer toutes les cellules du bateau
	FOR j:=i to i+4 DO //j permettera de passer d'une case à l'autre de l'ensemble de cellule
		begin
			tab[j].ligne:=res.flot[1].bat[x].ligne;
			tab[j].colonne:=res.flot[1].bat[x].colonne;
			x:=x+1;
		end;
	//on refait les mêmes instruction pour chaque bateau en changeant juste la taille et leur position dans la flotte
	REPEAT
		REPEAT
			writeln();
			writeln(UTF8ToAnsi('Veuillez entrer une ligne et un colonne de départ pour votre croiser (taille 4) (entre 1 et '),MAX,') :');
			readln(ligne);
			readln(colonne);
		UNTIL (ligne>0) AND (ligne<=MAX) AND (colonne>0) AND (colonne<=MAX);
		cel:=creation_cellule(ligne,colonne);
		REPEAT
			writeln('Veuillez entrer une direction 1:droite 2:bas 3:haut 4:gauche');
			readln(dir);
		UNTIL (dir>0) AND (dir<5);
		res.flot[2]:=creation_de_bateau(cel,4,dir,tab);
	UNTIL res.flot[2].bat[1].ligne<>0;
	i:=1;
	WHILE (tab[i].ligne<>0) AND (tab[i].colonne<>0) DO
		begin
			i:=i+1;
		end;
	x:=1;
	FOR j:=i to i+4 DO
		begin
			tab[j]:=res.flot[2].bat[x];
			x:=x+1;
		end;
	REPEAT
		REPEAT
			writeln();
			writeln(UTF8ToAnsi('Veuillez entrer une ligne et un colonne de départ pour votre contre-torpilleurs (taille 3) (entre 1 et '),MAX,') :');
			readln(ligne);
			readln(colonne);
		UNTIL (ligne>0) AND (ligne<=MAX) AND (colonne>0) AND (colonne<=MAX);
		cel:=creation_cellule(ligne,colonne);
		REPEAT
			writeln('Veuillez entrer une direction 1:droite 2:bas 3:haut 4:gauche');
			readln(dir);
		UNTIL (dir>0) AND (dir<5);
		res.flot[3]:=creation_de_bateau(cel,3,dir,tab);
	UNTIL res.flot[3].bat[1].ligne<>0;
	i:=1;
	WHILE (tab[i].ligne<>0) AND (tab[i].colonne<>0) DO
		begin
			i:=i+1;
		end;
	x:=1;
	FOR j:=i to i+4 DO
		begin
			tab[j]:=res.flot[3].bat[x];
			x:=x+1;
		end;
	REPEAT
		REPEAT
			writeln();
			writeln(UTF8ToAnsi('Veuillez entrer une ligne et un colonne de départ pour votre sous-marin (taille 3) (entre 1 et '),MAX,') :');
			readln(ligne);
			readln(colonne);
		UNTIL (ligne>0) AND (ligne<=MAX) AND (colonne>0) AND (colonne<=MAX);
		cel:=creation_cellule(ligne,colonne);
		REPEAT
			writeln('Veuillez entrer une direction 1:droite 2:bas 3:haut 4:gauche');
			readln(dir);
		UNTIL (dir>0) AND (dir<5);
		res.flot[4]:=creation_de_bateau(cel,3,dir,tab);
	UNTIL res.flot[4].bat[1].ligne<>0;
	i:=1;
	WHILE (tab[i].ligne<>0) AND (tab[i].colonne<>0) DO
		begin
			i:=i+1;
		end;
	x:=1;
	FOR j:=i to i+4 DO
		begin
			tab[j]:=res.flot[4].bat[x];
			x:=x+1;
		end;
	REPEAT
		REPEAT
			writeln();
			writeln(UTF8ToAnsi('Veuillez entrer une ligne et un colonne de départ pour votre  torpilleur (taille 2) (entre 1 et '),MAX,') :');
			readln(ligne);
			readln(colonne);
		UNTIL (ligne>0) AND (ligne<=MAX) AND (colonne>0) AND (colonne<=MAX);
		cel:=creation_cellule(ligne,colonne);
		REPEAT
			writeln('Veuillez entrer une direction 1:droite 2:bas 3:haut 4:gauche');
			readln(dir);
		UNTIL (dir>0) AND (dir<5);
		res.flot[5]:=creation_de_bateau(cel,2,dir,tab);
	UNTIL res.flot[5].bat[1].ligne<>0;
	i:=1;
	WHILE (tab[i].ligne<>0) AND (tab[i].colonne<>0) DO
		begin
			i:=i+1;
		end;
	x:=1;
	FOR j:=i to i+4 DO
		begin
			tab[j]:=res.flot[5].bat[x];
			x:=x+1;
		end;
	creation_flotte:=res; //on renvoie la flotte
END;

function verif_cel_flotte(var num_bat:integer;var num_cel:integer;cel:cellule;F:flotte):boolean;
//BUT vérifier si une cellule apparteint à une flotte
//ENTREE cellule et flotte
//SORTIE vrai ou faux
VAR
	res:boolean; //res sera le booleen renvoyé
	i,j:integer; //i et j vont permettre de parcourir toutes les cellules de tout les bateaux de la flotte
	cel2:cellule; //cel2 permet de comparer les cellules
BEGIN

	num_bat:=0; //initialisation de num_bat et num_cel qui retiendront la position exact de la cellule touchée
	num_cel:=0;
	res:=FALSE; //initialisation de res
	FOR i:=1 to 5 DO //pour chaque bateaux de la flotte
		begin
			FOR j:=1 to 5 DO //pour chaque cellule du bateau
				begin
					cel2:=F.flot[i].bat[j];
					res:=comparer_2_cellule(cel,cel2); //vérifier que la cellule apparteint à la flotte
					IF (res=TRUE) AND (num_bat=0) THEN
						begin
							num_bat:=i; //si elle y apparteint alors on retient sa position (le numéro du bateau et de la cellule)
							num_cel:=j;
						end;
				end;
		end;
	IF num_bat<>0 THEN //on renvoie vrai si num_bat est différent de 0
		begin
			res:=TRUE;
		end;
	verif_cel_flotte:=res; //renvoie vrai ou faux
END;

function verif_destruction_bateau(F:flotte;num_bat:integer):boolean;
//BUT vérifier qu'un bateau est entièrement détruit
//ENTREE une flotte et un numéro de bateau
//SORTIE vrai ou faux
VAR
	res:boolean; //sera le booleen renvoyé
	i,compteur:integer; //i servira à vérifier chaque cellule du bateau et compteur à retenir le nombre de cellules vides
BEGIN

	compteur:=0;
	res:=FALSE; //initialisation de res 
	FOR i:=1 TO 5 DO //pour chaque cellules du bateau
		begin
			IF (F.flot[num_bat].bat[i].ligne=0) AND (F.flot[num_bat].bat[i].colonne=0) THEN
				begin
					compteur:=compteur+1; //si elle est vide comparer monte de 1
				end;
		end;
	IF compteur=5 THEN //si toute les cellules sont vides 
		begin
			res:=TRUE; //res prend la valeur vrai
		end;
	verif_destruction_bateau:=res; //renvoie vrai ou faux
	
END;

function verif_destruction_flotte(F:flotte):boolean;
//BUT vérifier si une flotte est totalement détruite
//ENTREE la flotte
//SORTIE vrai si elle est totalement détruite ou faux
VAR
	i,j,compteur:integer; //i et j servent à parcourir la flotte et compteur sert à compter le nombre de cellule vide
	res:boolean; //res est le booleen que l'on renvoie
BEGIN
	res:=FALSE; //initialisation de res
	compteur:=0; //initialisation de compteur
	FOR i:=1 TO 5 DO
		begin
			FOR j:=1 TO 5 DO
				begin
					IF (F.flot[i].bat[j].ligne=0) AND (F.flot[i].bat[j].colonne=0) THEN
						begin
							compteur:=compteur+1; //à chaque cellule vide le compteur monte de 1
						end;
				end;
		end;
	IF compteur=25 THEN //vérifier si toutes les cases sont vide
		begin
			res:=TRUE;
		end;
	verif_destruction_flotte:=res; //renvoie vrai ou faux
END;

procedure dessin_soldat();
//BUT dessiner un visage de soldat
//ENTREE aucune
//SORTIE le visage du soldat
BEGIN
	writeln('   __________');
	writeln('  /  soldat  \');
	writeln(' / __________ \');
	writeln('/ /__________\ \');
	writeln('|| <o>   <o>  ||');
	writeln('||     {      ||');
	writeln('  \    __    /');
	writeln('   \  [__]  /');
	writeln('    \______/');
END;

// PROGRAMME PRINCIPAL

VAR
	flotJ1,flotJ2:flotte;
	Tabcel:ensemble_cel;
	testVJ1,testVJ2,testtoucher:boolean;
	nbtour,ligne,colonne,num_bat,num_cel,testrejouer,i:integer;
	celtire:cellule;
BEGIN

	REPEAT //sert à relancer le programme
		clrscr;
		testVJ1:=FALSE; //initialisation de testVJ1 et testVJ2 qui serviront à vérifier si l'un des deux joueurs a gagné
		testVJ2:=FALSE;
		nbtour:=0; //initialisation du nombre de tour
		For i:=1 to 50 do //initialisation de l'ensemble de cellule
			begin
				Tabcel[i].ligne:=0;
				Tabcel[i].colonne:=0;
			end;
		writeln('Bataille naval');
		writeln();
		writeln(UTF8ToAnsi('précision les deux flottes sont sur la même grille et aucun des deux joueurs ne peut toucher sa propre flotte ni poser son bateau sur un autre peut importe sa flotte, si un joueur touche un navire alors il rejoue'));
		writeln();
		flotJ1:=creation_flotte(1,Tabcel); //création de la flotte du joueur 1  
		clrscr;
		flotJ2:=creation_flotte(2,Tabcel); //création de la flotte du joueur 2
		clrscr;
		REPEAT
			nbtour:=nbtour+1; //augmentation du nombre de tours
			IF nbtour MOD 2<>0 THEN //si le nombre de tours est impaire alors c'est le tour du joueur 1
				begin
					clrscr;
					writeln('Tour du joueur 1');
					REPEAT
						writeln();
						dessin_soldat;
						writeln();
						writeln(UTF8ToAnsi('Nous attendons vos ordres amiral. Où souhaitez vous tirez ?'));
						readln(ligne); //demande d'une case à attaquer
						readln(colonne);
					UNTIL (ligne>0) AND (ligne<=MAX) AND (colonne>0) AND (colonne<=MAX); //vérification que les coordonnées sont valides
					celtire:=creation_cellule(ligne,colonne); //création d'une cellule visée
					testtoucher:=verif_cel_flotte(num_bat,num_cel,celtire,flotJ2); //vérification de si elle appartient à la flotte de J2 
					IF testtoucher=TRUE THEN
						begin
							writeln();
							//SI c'est le cas alors on supprime la cellule en la remplaçant avec des 0
							flotJ2.flot[num_bat].bat[num_cel].ligne:=0;
							flotJ2.flot[num_bat].bat[num_cel].colonne:=0;
							IF verif_destruction_bateau(flotJ2,num_bat) THEN //si le bateau est détruit alors 
								begin
									writeln(UTF8ToAnsi('Cible détruite amiral !'));// on affiche cible détruite
								end
							ELSE
								begin
									writeln(UTF8ToAnsi('Cible touchée amiral !'));//sinon on affiche cible touchée
								end;
							nbtour:=nbtour-1;	//si touché alors le joueur rejoue
							writeln(UTF8ToAnsi('L''ennemi va mettre du temps à s''en remettre.'));
						end
					ELSE	
						begin
							writeln();
							writeln(UTF8ToAnsi('Nous avons raté la cible amiral.')); //sinon raté
						end;
				end
			ELSE
				begin
					clrscr;
					writeln('Tour du joueur 2'); //si le nombre de tours est paire alors c'est le tour du joueur 2
					REPEAT
						writeln();
						dessin_soldat;
						writeln();
						writeln(UTF8ToAnsi('Nous attendons vos ordres amiral. Où souhaitez vous tirez ?'));
						readln(ligne); //demande d'une case à attaquer
						readln(colonne);
					UNTIL (ligne>0) AND (ligne<=MAX) AND (colonne>0) AND (colonne<=MAX); //vérification que les coordonnées sont valides
					celtire:=creation_cellule(ligne,colonne); //création d'une cellule visée
					testtoucher:=verif_cel_flotte(num_bat,num_cel,celtire,flotJ1); //vérification de si elle appartient à la flotte de J1 
					IF testtoucher=TRUE THEN
						begin
							writeln();
							//SI c'est le cas alors on supprime la cellule en la remplaçant avec des 0
							flotJ1.flot[num_bat].bat[num_cel].ligne:=0;
							flotJ1.flot[num_bat].bat[num_cel].colonne:=0;
							IF verif_destruction_bateau(flotJ1,num_bat) THEN //si le bateau est détruit alors 
								begin
									writeln(UTF8ToAnsi('Cible détruite amiral !'));// on affiche cible détruite
								end
							ELSE
								begin
									writeln(UTF8ToAnsi('Cible touchée amiral !'));//sinon on affiche cible touchée
								end;
							nbtour:=nbtour-1;	//si touché alors le joueur rejoue
							writeln(UTF8ToAnsi('L''ennemi va mettre du temps à s''en remettre.'));
						end
					ELSE	
						begin
							writeln();
							writeln(UTF8ToAnsi('Nous avons raté la cible amiral.')); //sinon raté
						end;
				end;
			testVJ1:=verif_destruction_flotte(flotJ2); //vérification de la victoire du joueur 1
			testVJ2:=verif_destruction_flotte(flotJ1); //vérification de la victoire du joueur 2
			readln;
		UNTIL (testVJ1=TRUE) OR (testVJ2=TRUE); //jusqu'a ce que J1 ou J2 ai gagné
		IF testVJ1=TRUE THEN //affichage de la victoire d'un des deux joueurs
			begin
				writeln();
				writeln('Victoire de la flotte 1 !');
			end
		ELSE
			begin
				writeln();
				writeln('Victoire de la flotte 2 !');
			end;
		writeln();
		writeln(UTF8ToAnsi('Merci d''avoir joué !')); //remerciement
		writeln();
		writeln('Veuillez entrer 0 pour quitter ou n''importe quel autre nombre pour une revanche :'); //demande si les joueurs veulent rejouer
		readln(testrejouer);
	UNTIL testrejouer=0;

END.