

class Echiquier {
  Piece e[][];
  //int nPieceMorte = 0;
  ArrayList<Piece> pieceMorte = new ArrayList<Piece>();
  ArrayList<int[]> deplacements = new ArrayList<int[]>();
  boolean vraiEch = false;
  
  Echiquier() {
    e = new Piece[8][8];
  }

  void initial() {
    //nPieceMorte = 0;
    pieceMorte = new ArrayList<Piece>();
    for (int i = 0; i < 8; i ++) {
      for (int j = 0; j < 8; j ++) {
        e[i][j] = new Piece(0, 0, 0);
      }
    }
    for (int i = 0; i < 8; i ++) {
      e[1][i] = new Piece(1, valeurPieces[0], 1);
      e[6][i] = new Piece(1, valeurPieces[0], -1);
    }
    for (int i = 0; i < 3; i ++) {
      e[0][i] = new Piece(2+i, valeurPieces[i+1], 1);
      e[0][7-i] = new Piece(2+i, valeurPieces[i+1], 1);
      e[7][i] = new Piece(2+i, valeurPieces[i+1], -1);
      e[7][7-i] = new Piece(2+i, valeurPieces[i+1], -1);
    }
    e[0][3] = new Piece(5, valeurPieces[4], 1);
    e[0][4] = new Piece(6, valeurPieces[5], 1);
    e[7][4] = new Piece(6, valeurPieces[5], -1);
    e[7][3] = new Piece(5, valeurPieces[4], -1);
  }



  int miseEnEchec() {//renvoie 1 si le roi de l'equipe 1 sur l'echiquier echiquierMEE est en échecs (-1 pour l'equipe -1 et 0 pour pas de checkmate)
    int rep = 0;
    int caseMangeable[][] = new int[8][8]; //forme d'echiquier, si caseMangeable[0][0] = 1, alors cette case peut être mangé par un pion de l'équipe 1, si elle vaut 0 elle ne peut pas être mangé
    PVector roi[] = new PVector[2]; // 0 -> position du roi de l'equipe -1 ; 1-> de l'equipe 1

    for (int l = 0; l < 8; l ++) {
      for (int c = 0; c < 8; c ++) {
        // Pour chaques pièces de l'echiquier on regarde où il peut manger
        int casePoss[][] = e[l][c].deplacementPossible(l, c, e, 0);
        int equipePiece = e[l][c].equipe;
        if (casePoss.length > 0) {
          for (int i = 0; i < casePoss.length; i ++) {
            caseMangeable[casePoss[i][0]][casePoss[i][1]] = equipePiece;
          }
        }
        //On enregistre la position des rois
        if (e[l][c].type == 6) {
          roi[int(equipePiece+0.1)] = new PVector(l, c);
        }
      }
    }
    //si les roi sont mangeable
    try {
      if (caseMangeable[int(roi[0].x)][int(roi[0].y)] == 1) {
        rep = -1;
      } else if (caseMangeable[int(roi[1].x)][int(roi[1].y)] == -1) {
        rep = 1;
      }//NullPointerException
    }
    catch(NullPointerException e) {
      print("");
    }

    return rep;
  }

  void printlnE() {//Affiche dans la console un echiquier -> utile pour le debbugage
    for (int i = 0; i < 8; i ++) {
      for (int j = 0; j < 8; j ++) {
        if (e[i][j].type==0) {
          print("·");
        } else {
          print(e[i][j].type);
        }
      }
      println("");
    }
  }

  Piece[][] copieEchiquier() {
    Piece echiquierBis[][] = new Piece[8][8];
    for (int l = 0; l < 8; l ++) {
      for (int c = 0; c < 8; c ++ ) {
        echiquierBis[l][c] = e[l][c];
      }
    }
    return echiquierBis;
  }

  void deplacement(int liD, int coD, int liA, int coA) {//déplace une pièce, Attention : effet de bord avec echiquier
    if (e[liA][coA].type > 0 ) {//si c'est un vrai déplacmeent et qu'une pièce est mangé, on l'enregistre dans les pièces mortes
      pieceMorte.add(e[liA][coA]);
      //nPieceMorte ++;
      if (e[liA][coA].type == 6 && vraiEch) {//si c'est un roi -> Victoire !
        victorieux = tour;
      }
    }
    int depla[] = {liD,coD,liA,coA};
    deplacements.add(depla);
    //déplace
    e[liA][coA] = e[liD][coD];
    e[liD][coD] = new Piece(0, 0, 0);
  }
  
  void defEchi(Piece trE[][]){
    e = trE;
  }
  
  
  
  
  
}