String parametres[] = new String[1];//Parametres du fichier parametres.txt
float w,h;// largeur et hauteur -> ATTENTION chaque élement graphique doit être définit par rapport à eux et non en pixels (car la taille de la fenetre peut varier)
Echiquier echiquierAff = new Echiquier();// Echiquier qui est afficher

void settings(){
  //Charge les parametres
  String para[] = loadStrings("parametres.txt");
  for(int i = 0 ; i < para.length ; i ++){
    parametres[i] = para[i].split("=")[1];
  }
  
  //Créé la fenetre
  size(int(parametres[0]),int(parametres[0]));
}

void setup(){
  
  //Initialisations
  w = width;
  h = height;
  initialisationCaracteristiqueEchiquier();
  initialisationImages();
  echiquierAff.initial();
  echiquierAff.vraiEch = true;
}



void draw(){
  affichageGlobal();
}

void affichageGlobal(){
  background(255);//Fond d'écran blanc
  affichageEchiquier();
  affichageHorsEchiquier();
  affichageVictoire();
  jouerIA();
}


void jouerIA(){
  if(nIA >=0 && tour == 1 && victorieux == 0){ // le tour de l'IA est le tour 1
    switch(nIA){
      //case(0):
      //IA0();
      //break;
      
      //case(1):
      //IA1();
      //break;
      
      case(2):
      int mBase2 = millis();
      IA2();
      println(millis()-mBase2);
      break;
      
      //case(3):
      //int mBase3 = millis();
      //IA3();
      //println(millis()-mBase3);
      //break;
    }
  }
}