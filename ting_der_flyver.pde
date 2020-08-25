Ting[] listeTing;
int antalTing = 20;

void setup() {
  size(500,500);
  //Opgave 1 : Her skal du oprette listen "listeTing" med plads til 20 ting
  /*
    Der laves en liste med de 20 elementer af Ting (der er ikke lavet instanser, men kun plads til) 
  */
  listeTing = new Ting[antalTing];
  
  //Opgave 5 : Her skal du skrive kode der laver alle "Ting"
  /*
     Der laves de 20 instanser af Ting i listen fra før vha. et for-loop. 
     De får nogle tilfældige koordinater at starte på. 
     Kan testes ved at printe arrayet ud med objekterne og se i konsollen.
  */
  for (int i=0; i<antalTing; i++) {
    listeTing[i] = new Ting(random(30, 470), random(30, 470));
  }
  println(listeTing);

}


void draw() {
  clear();
  fill(200);
  rect(10, 10, 480, 480);
  
  //OPGAVE 8 (SVÆR) : Her skal du skrive kode der Ændrer farven til rød hvis din "Ting"  rører ved musen...
  /*
    Kalder funktionen i klassen, der tjekker om mousens kooridnater er indenfor tingen. 
    Koordinaterne til cirlcerne er til centerpunktet, hvorfor funktionen sammenligner koordinaterne +/- 10.
    Hvis musen er indenfor, sættes en boolean til true og derfor vil farven, når funktionen tegn() kaldes, ændres.
    Test: Kør programmet og hold musen hen over circlerne for at se, at de skifter farve. 
    Der er også lavet et print-statement, der fortæller hvilket index, tingen, der holdes over har.
  */
  for (int i=0; i<antalTing; i++) {
    listeTing[i].mouseHoverCheck(mouseX, mouseY);
    if (listeTing[i].mouseHover) println(i);
  }

  //Opgave 6 : Her skal du skrive kode, der tegner alle "Ting"
  //ps: Du SKAL kalde "tegn metoden" på ALLE "Ting"
  /*
     Jeg har lavet et for-loop for at komme gennem alle elementerne i arrayet
     og kalde tegn()-funktionen på dem. Derved bliver alle elementerne tegnet.
     Test: Hvis alle 20 ting bliver tegnet og bevæger sig ved hvert frame, er alt jo godt.
  */
  for (int i=0; i<antalTing; i++) {  
    // Her er koden til ekspert 2-opgaven 
    // Først sættes collision = false og dernæst testes der om nogen andre ting kolliderer
    listeTing[i].collision = false;
    // Gud hvor sjovt!! Dette if-statement ligner jo det fra testen med musen. Sikke et sammentræf!
    for (int j=0; j<antalTing; j++) {
      if (listeTing[i].location.x > listeTing[j].location.x-20 &&
          listeTing[i].location.x < listeTing[j].location.x+20 && 
          listeTing[i].location.y > listeTing[j].location.y-20 &&
          listeTing[i].location.y < listeTing[j].location.y+20 &&
          i != j) {
        // Hvis en anden ting overlapper, sættes variablen til true
        listeTing[i].collision = true;
      }
    }
    
    // Her er koden til opgave 6 + 7
    listeTing[i].tegn();
    listeTing[i].flyv();
  }


  //Opgave 7 : Her skal du skrive kode, der får alle "Ting" til at flytte sig
  //ps: DU SKAL kalde "
  /*
    Da det er enormt ineffektivt at lave et for-loop igen bare for at kalde "flyv"
    har jeg lavet det i samme for-loop i hvilket tegn()-funktionen kaldes. 
  */
  
  
  //EKSPERT 2:
  //Hvis to ting rører hinanden skal de blive blå!
  /*
    Ved at loope igennem hvert objekt i arrayet og lave et underloop, der looper igennem arrayet igen, 
    kan man lave en funktion, der tjekker alle tingenes positioner mod hinanden. For hvert element tjekkes
    om nogen af de andre ting er på samme position. Hvis ja, gøres elementet blåt ved at sætte variablen
    collision = true som er gemt på selve objektet. 
    Test: Kør programmet og se om der er cirlcer, der kolliderer og om de bliver blå. Der er fejl, hvis ikke
    de begge bliver blå eller overhovedet ikke farves. 
  */
}





class Ting {
  PVector location = new PVector();
  PVector movement = new PVector();
  float colorR = 100;
  boolean mouseHover = false;
  boolean collision = false;
  
  Ting(float inputX, float inputY) {
    //Opgave 2: Her skal du skrive kode der sætter positionen for tingen x og y
    /*
      Grundet flytte-funktionen, har jeg valgt at bruge PVector. Derfor sættes de to kooridnater i vektoren
      til de to koordinater, der er givet. Dernæst laves en bevægelsesvektor, der får to tilfældige
      hastigheder, der bruges senere.
      Test: Kan printes ud eller bare kigge, når programmet kører, om der er blevet sat x- og y-værdier, 
      da der ikke vil komme nogen objekter tilfældige steder, hvis x og y ikke overføres som her.
      Movement skal også sættes, ellers flytter de sig ikke.
    */
    location.x = inputX;
    location.y = inputY;
    movement.x = random(-3, 3);
    movement.y = random(-3, 3);
  }
  
  void tegn() {
    //Opgave 3: Her skal du skrive kode der tegner denne "Ting"
    /*
      Jeg sætter først en farve - her grøn. Dernæst tegnes en cirkel ved koordinaterne med diameter 20.
      Test: Se om der kommer en cirkel på skærmen ...
    */
    if (mouseHover) {
      fill(230, 20, 20);
    } else if (collision) {
      fill(20, 20, 230);
    } else {
      fill(20, 230, 20);
    }
    circle(location.x, location.y, 20);
  }
  
  void flyv() {
    //Opgave 4: Her skal du skrive kode der flytter "Ting"
    //ps: Husk de må ikke flytte sig uden for skærmen...
    /* 
      For at flytte figuren, lægges bevægelsesvektoren til.
      For at få den til at blive indenfor skærmen, skifter den retning (ved at gange med -1), hvis 
      "tingen" kommer udenfor skærmen/kassen.
      Test: Kig på programmet om tingene bevæger sig og om de skifter retning ved kanterne.
    */
    location.add(movement);
    
    if (location.x >= 480 || location.x <= 20) {
      movement.x *= -1;
    }
    if (location.y >= 480 || location.y <= 20) {
      movement.y *= -1;
    }
  }
  
  
  void mouseHoverCheck(float mouse_x, float mouse_y) {
    if (mouse_x > location.x-10 && 
        mouse_x < location.x+10 &&
        mouse_y > location.y-10 &&
        mouse_y < location.y+10) {
      mouseHover = true;
    } else {
      mouseHover = false;
    }
  }
}
