
Table table;

float getOffsetLon(float input){
  return ((input - 24)*100 + 100);
}

float getOffsetLat(float input){
  return -((input - 53.9)*100) + 400;
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
  textFont(f, 12);  // Arg 2 is font size
  textAlign(CENTER, CENTER);

  strokeCap(SQUARE);

  // TODO: Consider multiple loop runs for drawing each part (Text, lines, etc) in the correct layer
  
  // TODO: Use vertex and stroke join instead of individual lines

  // May need to reverse loop (to draw orange over black lines)
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
      // Ellipse to hide gaps between line segments
      strokeWeight(1);
      ellipse(getOffsetLon(table.getRow(i).getFloat("LONP")), getOffsetLat(table.getRow(i).getFloat("LATP")), table.getRow(i).getFloat("SURV")/10000, table.getRow(i).getFloat("SURV")/10000);
    
      fill(0);
      text(table.getRow(i).getString("SURV"), getOffsetLon(table.getRow(i).getFloat("LONP")), getOffsetLat(table.getRow(i).getFloat("LATP")) + 10);
    }
  }
  
  for(int i = 0; i < city_rows; i++){
    // ellipse(getOffsetLon(table.getRow(i).getFloat("LONC")), getOffsetLat(table.getRow(i).getFloat("LATC")), 10, 10);
    fill(0);
    text(table.getRow(i).getString("CITY"), getOffsetLon(table.getRow(i).getFloat("LONC")), getOffsetLat(table.getRow(i).getFloat("LATC")));  
  }
  
  // Temperature Diagram
  stroke(0);
  fill(0);
  
  // --- Temperature grid lines ---
  // TODO: Move right most temp value (Oct 18) to the right axis
  // Horizontals
  for(int i = 0; i < 4; i++){
    line(getOffsetLon(table.getRow(0).getFloat("LONT")), 500 + (i * 50), getOffsetLon(table.getRow(8).getFloat("LONT")),500 + (i * 50));
  }
  // Verticals
  line(getOffsetLon(table.getRow(0).getFloat("LONT")), 500, getOffsetLon(table.getRow(0).getFloat("LONT")),650);
  line(getOffsetLon(table.getRow(8).getFloat("LONT")), 500, getOffsetLon(table.getRow(8).getFloat("LONT")),650);
  // Temp Indicators
  for(int i = 0; i < 7; i++){
    line(getOffsetLon(table.getRow(0).getFloat("LONT")) - 5, 500 + (i * 25), getOffsetLon(table.getRow(0).getFloat("LONT")) + 5, 500 + (i * 25));
    text(i * -5, getOffsetLon(table.getRow(0).getFloat("LONT")) + 15, 500 + (i * 25));
  }
  
  strokeWeight(3);
  
  for(int i = 0; i < temp_rows; i++){
    text(table.getRow(i).getInt("TEMP") + "°C on " +  table.getRow(i).getString("MON") + " " + 
      table.getRow(i).getInt("DAY"), getOffsetLon(table.getRow(i).getFloat("LONT")),-(table.getRow(i).getFloat("TEMP") * 5) + 527);
    if(i != 0){
      line(getOffsetLon(table.getRow(i - 1).getFloat("LONT")),-(table.getRow(i - 1).getFloat("TEMP") * 5) + 500, getOffsetLon(table.getRow(i).getFloat("LONT")),-(table.getRow(i).getFloat("TEMP") * 5) + 500);
    }
  }
  
  // Say in writeup: Using programatic approach instead of hardcoded lines.
}
