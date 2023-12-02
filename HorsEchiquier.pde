

void affichageHorsEchiquier() {
  //Les textes
  textSize(w/30);
  fill(0);
  text("Tour :", w/50, h/17);
  text("Pieces Mortes", w/20, h/4);
  text("IA", w/285*10, h/105*100);
  

  // Tour de l'equipe
  stroke(155, 105, 30);
  if (tour == equipeBlanche) {
    fill(255);
  } else {
    fill(0);
  }
  rect(w/7, h/90, dimCase, dimCase);

  //Pieces mangée
  pushStyle();
  noFill();
  stroke(0);
  rect(dimCase/5, posEchY, 4*dimCase, dimCase);
  //fill(255);
  //rect(dimCase/5,posEchY+dimCase,2*dimCase,dimCase);
  //fill(0);
  //rect(dimCase/5+2*dimCase,posEchY+dimCase,2*dimCase,dimCase);
  fill(200);
  rect(dimCase/5, posEchY+dimCase, 2*dimCase, 8*dimCase);
  rect(dimCase/5+2*dimCase, posEchY+dimCase, 2*dimCase, 8*dimCase);
  if (echiquierAff.pieceMorte.size() > 0 ) {
    int npB = 0;
    int npN = 0;
    for (int i = 0; i  < echiquierAff.pieceMorte.size(); i ++) {

      if (echiquierAff.pieceMorte.get(i).equipe == equipeBlanche) {
        image(pieces[echiquierAff.pieceMorte.get(i).type-1][0], dimCase/5+(npB%2)*dimCase, posEchY+(npB/2+1)*dimCase, dimCase, dimCase);
        npB ++;
      } else {
        image(pieces[echiquierAff.pieceMorte.get(i).type-1][1], (npN%2+2)*dimCase+dimCase/5, posEchY+(npN/2+1)*dimCase, dimCase, dimCase);
        npN ++;
      }
    }
  }
  popStyle();

  //bouton réinitialisation echiquier
  noFill();
  stroke(0);
  rect(w-w/10, h-h/10, w/10, h/10);
  ellipse(w-w/20, h-h/20, w/17, h/17);

  //IA
  stroke(0);
  for (int i = -1; i <= nIAMax; i ++) {
    if (i == nIA) {
      fill(210);
    } else {
      fill(255);
    }
    rect(dimCase/5+dimCase*(i+2), posEchY+dimCase*9.37, dimCase, dimCase);
  }
  fill(0);
  for(int i = -1;i<= nIAMax ; i ++){
    text(i, w/88*10+dimCase*(i+1), h/105*100);
  }

}

void affichageVictoire() {
  if (victorieux != 0) {
    pushStyle();
    stroke(75, 230, 50);
    //strokeWeight(w/100);
    noFill();
    rect(w/3, h/22.5, w/1.65, h/10);
    fill(0);
    textSize(w/25);
    String equipeGagnante = "";
    if (victorieux == equipeBlanche) {
      equipeGagnante = "blanche";
    } else {
      equipeGagnante = "noire";
    }

    text("Victoire de l'équipe "+equipeGagnante, w/2.77, h/9);
    popStyle();
  }
}