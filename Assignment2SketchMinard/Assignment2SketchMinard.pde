
Table table;

float getOffsetLon(float input){
  return ((input - 24)*100 + 100);
}

float getOffsetLat(float input){
  return ((input - 53.9)*100 + 100);
}

void setup(){
  // Window size
  size(1600,1000);
  background(255);
  // Load data
  table = loadTable("minard-data.csv", "header");
  int city_rows = 20;
  int temp_rows = 9;
  int troop_rows = 48;

  // Setup text
  PFont f = createFont("Arial",16,true);  // True for Anti-aliasing
  textFont(f, 20);  // Arg 2 is font size
  textAlign(CENTER, CENTER);

  strokeCap(SQUARE);

  for(int i = 0; i < troop_rows; i++){
    if(i != 0){
      if(table.getRow(i-1).getString("DIR").equals("A")){
        // Orangeish outward line
        stroke(229, 203, 170);
        fill(229, 203, 170);
      }
      else{
        // Black return line
        stroke(36, 32, 33);
        fill(36, 32, 33);
      }
      strokeWeight(table.getRow(i).getFloat("SURV")/10000);
      // To prevent gaps between lines. NOTE: NEED TO CHANGE LINE WIDTH BACK TO NORMAL FOR DRAWING ELLIPSE
      //ellipse(getOffsetLon(table.getRow(i).getFloat("LONP")), getOffsetLat(table.getRow(i).getFloat("LATP")), table.getRow(i).getFloat("SURV")/40000, table.getRow(i).getFloat("SURV")/40000);
      
      // Off by one for line colour
      line(getOffsetLon(table.getRow(i-1).getFloat("LONP")), getOffsetLat(table.getRow(i-1).getFloat("LATP")), getOffsetLon(table.getRow(i).getFloat("LONP")), getOffsetLat(table.getRow(i).getFloat("LATP")));
      
      strokeWeight(1);
      ellipse(getOffsetLon(table.getRow(i).getFloat("LONP")), getOffsetLat(table.getRow(i).getFloat("LATP")), table.getRow(i).getFloat("SURV")/10000, table.getRow(i).getFloat("SURV")/10000);
    }
  }
  
  for(int i = 0; i < city_rows; i++){
    // ellipse(getOffsetLon(table.getRow(i).getFloat("LONC")), getOffsetLat(table.getRow(i).getFloat("LATC")), 10, 10);
    fill(0);
    text(table.getRow(i).getString("CITY"), getOffsetLon(table.getRow(i).getFloat("LONC")), getOffsetLat(table.getRow(i).getFloat("LATC")));  
  }
}
