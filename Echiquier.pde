float posEchX, posEchY, dimEch, dimCase;//variable de dimension d'elements graphique
int nCasesL = 8; //nombre de cases sur la longueur (ou hauteur qu'importe) (j'ai oublier de l'utiliser parfois)
PImage pieces[][] = new PImage[6][2];//Images des pieces, 0 -> blanc, 1 -> noir
String nomsPieces [] = {"vide", "p", "t", "c", "f", "r", "k"}; // nom des pièces (utile uniquement pour le chargement des images), ainsi : 0 -> rien, 1 -> pion, 2 -> tour, 3 -> cavalier, 4 -> fou, 5 -> reine, 6 -> roi (king) 
String dossierImage = "Images/";//dossier où on range les images
int equipeBlanche = -1; // 1 ou -1 -> 1 est l'équipe en haut, l'équipe blanche est définit aléatoirement lors des initialisations

PVector caseSelect = new PVector(-1, -1); // case sélectionnée, si x négatif, aucune case sélectionnée
int casesPoss[][] = new int[0][2];//cases où la piece selectionnée peut aller

int tour = equipeBlanche;//tour du joueur
int victorieux = 0;//0 si partie en cours, 1 si equipe 1 victorieux, de m^ pour -1

int nIA = 2;//-1 -> joueur contre joueur ; 0 -> IA0 ect ..., se référer à la fonction jouerIA dans EchessL
int nIAMax = 3;
int echecs = 0;// -1 -> l'equipe -1 est mise en echec ; 0 -> pas de mise en echec ; 1 -> de l'equipe 1 

//boolean roquable[][] = {{true, true}, {true, true}}; //(PAS ENCORE FINI) roquable[0][0] roque (equipe -1) avec tour bas gauche ; roquable[0][1] roque (equipe -1) avec tour bas droite 

void initialisationCaracteristiqueEchiquier() {
  posEchX = w/3;// position X du sommet haut gauche de l'echiquier
  posEchY = (h-w*29/48)/2;// position Y du sommet haut gauche de l'echiquier
  dimEch = w*29/48; // Taille de l'echiquier
  dimCase = dimEch/nCasesL;

  //On définit l'équipe qui commence
  float r = random(0, 1);
  if (r<0.5) {
    equipeBlanche = 1;
  } else {
    equipeBlanche = -1;
  }
  tour = equipeBlanche;
}

void initialisationImages() {
  for (int i = 0; i < 6; i ++) {
    pieces[i][0] = loadImage(dossierImage+nomsPieces[i+1]+"b.png");
    pieces[i][1] = loadImage(dossierImage+nomsPieces[i+1]+"n.png");
  }
}



void affichageEchiquier() {
  noStroke();
  for (int x = 0; x < nCasesL; x ++) {
    for (int y = 0; y < nCasesL; y ++) {
      if ( (y*(nCasesL-1)+x)%2 == 1-int(equipeBlanche+0.1)) { // savante formule qui permet de savoir quelles cases sont blanche ou noir, Normalement les équipe c'est -1 et 1 mais int(equipeBlanche+0.1) transforme les equipes en 0 et 1 (souvent utile)
        fill(0);//noir
        if (x == caseSelect.x && y == caseSelect.y) {//si c'est une case sélectionnée
          fill(55);
        }
      } else {
        fill(255);
        if (x == caseSelect.x && y == caseSelect.y) {
          fill(200);
        }
      }
      rect(posEchX+x*dimCase, posEchY+y*dimCase, dimCase, dimCase);//affiche la case
    }
  }
  if (casesPoss.length > 0) {//Si il y a des cases à la pièce select peut se déplacer
    for (int i = 0; i < casesPoss.length; i ++) {
      fill(50, 100, 200, 120);
      rect(posEchX+casesPoss[i][1]*dimCase, posEchY+casesPoss[i][0]*dimCase, dimCase, dimCase);
    }
  }

  //affiche les pièces
  for (int x = 0; x < nCasesL; x ++) {
    for (int y = 0; y < nCasesL; y ++) {

      int numPiece = echiquierAff.e[y][x].type;
      int equipePiece = echiquierAff.e[y][x].equipe;
      if (equipePiece == equipeBlanche) {
        equipePiece = 0;
      } else {
        equipePiece = 1;
      }
      if (numPiece > 0) {
        image(pieces[numPiece-1][equipePiece], posEchX+x*dimCase, posEchY+y*dimCase, dimCase, dimCase);
      }
    }
  }

  //Affiche les lignes
  stroke(155, 105, 30);
  strokeWeight(2);
  for (int x = 0; x < nCasesL+1; x ++) { // Traçage du cadrillage
    line(posEchX+x*dimCase, posEchY, posEchX+x*dimCase, posEchY+dimEch);
    line(posEchX, posEchY+x*dimCase, posEchX+dimEch, posEchY+x*dimCase);
  }
}

void finTour() {//Check List de fin de tour
  echecs = 0;
  tour *= -1;
  caseSelect = new PVector(-1, -1);
  casesPoss = new int[0][2];
  if (victorieux == 0) {
    echecs = echiquierAff.miseEnEchec();
  }
}
