
Table table;

float getOffsetLon(float input){
  return ((input - 24) * 100 + 100);
}

float getOffsetLat(float input){
  return -((input - 53.9) * 200) + 600;  // Negative since reflection about the x-axis
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
  textFont(f, 40);  // Arg 2 is font size
  textAlign(CENTER, CENTER);

  strokeCap(ROUND);

  // Title text
  fill(0);
  text("Minard's Map of Napoleon's March in 1812-1813", 800, 100);
  
  textFont(f, 12);  // Arg 2 is font size
  
  // Black return lines
  stroke(36, 32, 33);
  fill(36, 32, 33);
  for(int i = 1; i < troop_rows; i++){
    if(table.getRow(i-1).getString("DIR").equals("R")){
      strokeWeight(table.getRow(i-1).getFloat("SURV")/5000);
      line(getOffsetLon(table.getRow(i-1).getFloat("LONP")), getOffsetLat(table.getRow(i-1).getFloat("LATP")), getOffsetLon(table.getRow(i).getFloat("LONP")), getOffsetLat(table.getRow(i).getFloat("LATP")));
    }
  }
  
  // Orangeish outward line
  stroke(229, 203, 170);
  fill(229, 203, 170);
  for(int i = 1; i < troop_rows; i++){
    if(table.getRow(i-1).getString("DIR").equals("A")){
      strokeWeight(table.getRow(i-1).getFloat("SURV")/5000);
      line(getOffsetLon(table.getRow(i-1).getFloat("LONP")), getOffsetLat(table.getRow(i-1).getFloat("LATP")), getOffsetLon(table.getRow(i).getFloat("LONP")), getOffsetLat(table.getRow(i).getFloat("LATP")));
    }
  }
  
  // Draw troop numbers text
  for(int i = 1; i < troop_rows; i++){
      float text_x = (getOffsetLon(table.getRow(i-1).getFloat("LONP")) + getOffsetLon(table.getRow(i).getFloat("LONP"))) / 2;
      float text_y = (getOffsetLat(table.getRow(i-1).getFloat("LATP")) + getOffsetLat(table.getRow(i).getFloat("LATP"))) / 2;
      fill(255, 0, 0);
      text(table.getRow(i).getString("SURV"), text_x, text_y); 
  }
  
  // Draw city text
  fill(0, 0, 255);
  for(int i = 0; i < city_rows; i++){
    // ellipse(getOffsetLon(table.getRow(i).getFloat("LONC")), getOffsetLat(table.getRow(i).getFloat("LATC")), 10, 10);
    text(table.getRow(i).getString("CITY"), getOffsetLon(table.getRow(i).getFloat("LONC")), getOffsetLat(table.getRow(i).getFloat("LATC")));  
  }
  
  // Temperature Diagram
  stroke(0);
  strokeWeight(1);
  fill(0);
  
  // --- Temperature grid lines ---
  // TODO: Move right most temp value (Oct 18) to the right axis
  // Horizontals
  for(int i = 0; i < 4; i++){
    line(getOffsetLon(table.getRow(0).getFloat("LONT")), 700 + (i * 50), getOffsetLon(table.getRow(8).getFloat("LONT")), 700 + (i * 50));
  }
  // Verticals
  line(getOffsetLon(table.getRow(0).getFloat("LONT")), 700, getOffsetLon(table.getRow(0).getFloat("LONT")),850);
  line(getOffsetLon(table.getRow(8).getFloat("LONT")), 700, getOffsetLon(table.getRow(8).getFloat("LONT")),850);
  // Temp Indicators
  for(int i = 0; i < 7; i++){
    line(getOffsetLon(table.getRow(0).getFloat("LONT")) - 5, 700 + (i * 25), getOffsetLon(table.getRow(0).getFloat("LONT")) + 5, 700 + (i * 25));
    text(i * -5, getOffsetLon(table.getRow(0).getFloat("LONT")) + 15, 700 + (i * 25));
  }
  
  for(int i = 1; i < temp_rows; i++){
    strokeWeight(3);
    // Text for temp and date
    text(table.getRow(i).getInt("TEMP") + "°C on " +  table.getRow(i).getString("MON") + " " + 
      table.getRow(i).getInt("DAY"), getOffsetLon(table.getRow(i).getFloat("LONT")),-(table.getRow(i).getFloat("TEMP") * 5) + 727);
    // Line for graph
    line(getOffsetLon(table.getRow(i - 1).getFloat("LONT")),-(table.getRow(i - 1).getFloat("TEMP") * 5) + 700, getOffsetLon(table.getRow(i).getFloat("LONT")),-(table.getRow(i).getFloat("TEMP") * 5) + 700);
  }
}
