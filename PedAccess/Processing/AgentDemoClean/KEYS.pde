boolean keyLoaded = true;
char initKey;

void keyPressed() {
  switch (key) {
    case '0': //ReBoots App
      setLoader("Agent Demo| Version " + version);
      // runs key_0() next frame
      break;
    case 'o': //show obstacle outlines
      showObstacles = toggle(showObstacles);
      break;
    case 'k': //show sources and sinks for agents
      showSource = toggle(showSource);
      break;
    case 'r': //reset agents and simulation
      setLoader("New Agents");
      // runs key_r() next frame
      break;
    case 'f': //print framerate to console
      showFrameRate = toggle(showFrameRate);
      break;
    case 'S': //toggles display of swarms of agents
      showSwarm = toggle(showSwarm);
      break;
    case 'e': //shows network edges of motion
      showEdges = toggle(showEdges);
      break;
    case 'i': //shows info about swarms like weight and agent numbers
      showInfo = toggle(showInfo);
      break;
    case 'p': //makes a grid of obstacles
      setLoader("Gridded Obstacles");
      // runs key_p() next frame
      break;
    case 'F': //toggles frameStep
      frameStep = toggle(frameStep);
      println("FrameStep = " + frameStep);
      break;
    case '+': //speed it up
      updateSpeed(1);
      break;
    case '-': //slow it down
      updateSpeed(-1);
      break;
    case 'l': //loads course
      if (editObstacles) {
        boundaries.loadCourse("data/course.tsv");
      }
      break;
    case 's'://save course
      if (editObstacles) {
        boundaries.saveCourse("data/course.tsv");
      }
      break;
    case 'E': // shows or hides obsticale editor 
      setLoader("Obstacles Editor");
      // runs key_E() next frame
      break;
    case '': //hit the delete key 
      if (editObstacles) {
        boundaries.removeVertex();
      }
      break;
    case 'A': //lets you add obstcles
      if (editObstacles) {
        boundaries.addObstacle();
      }
      break;
    case 'R': //lets you remove obstacles 
      if (editObstacles) {
        boundaries.removeObstacle();
      }
      break;
    case ' ': //switch between the two obstacles to edit them 
      if (editObstacles) {
        boundaries.nextIndex();
      }
      break;
    case 'N': //hops to next vertice 
      if (editObstacles) {
        boundaries.nextVert();
      }
      break;
    case 'V': //starts printing frames to file
      printFrames = toggle(printFrames);
      break;
    case 'b': //toggle background between black and white
      background = toggleBW(background);
      textColor = toggleBW(textColor);
      grayColor = int(abs(background - (255.0/2)*schemeScaler));
      pFinderGrid_Viz(tableCanvas);
      break;
    case 'P': //toggle display of shortest paths
      showPaths = toggle(showPaths);
      break;
    case 'G': //toggle display for pathing grip
      showGrid = toggle(showGrid);
      break;
    case 'X': 
      setLoader("New Origin-Destination Pair");
      // runs key_X() next frame
      break;
    case 'n': // randomize/reset current network for pathfinding
      setLoader("New Pathfinder Network");
      // runs key_n() next frame
      break;
    case '>': // Toggle network for pathfinding
      setLoader("Pathfinder Mode " + nextMode(finderMode, 3));
      // runs key_RightCarrot() next frame
      break;
    case '<': // Enable/Disable Pathfinding
      setLoader("Pathfinder: " + toggle(enablePathfinding));
      // runs key_LeftCarrot() next frame
      break;
    case '{': // Decrease Alpha
      adjustAlpha(-10);
      pFinderGrid_Viz(tableCanvas);
      grayColor = int(abs(background - (255.0/2)*schemeScaler));
      println("schemeScaler: " + schemeScaler);
      println("masterAlpha: " + masterAlpha);
      break;
    case '}': // Increase Alpha
      adjustAlpha(+10);
      pFinderGrid_Viz(tableCanvas);
      grayColor = int(abs(background - (255.0/2)*schemeScaler));
      println("schemeScaler: " + schemeScaler);
      println("masterAlpha: " + masterAlpha);
      break;
    case 'T': // Turns demo background image on or off
      showDemoMap = toggle(showDemoMap);
      break;
  }
  
  //------arrow keys and how to code keys that aren't characters exactly----- 
  if (key == CODED) { 
    if (keyCode == LEFT) {
      if (editObstacles) {
        boundaries.nudgeVertex(-1, 0);
      }
    }  
    if (keyCode == RIGHT) {
      if (editObstacles) {
        boundaries.nudgeVertex(+1, 0);
      }
    }  
    if (keyCode == DOWN) {
      if (editObstacles) {
        boundaries.nudgeVertex(0, +1);
      }
    }  
    if (keyCode == UP) {
      if (editObstacles) {
        boundaries.nudgeVertex(0, -1);
      }
    }
  }
}

// Running this method will display a loading screen when 
// running a method placed in "initKey()".
// Useful for laggy commands
void setLoader(String txt) {
  drawDelay = 2;
  keyLoaded = false;
  loadText = txt;
  initKey = key;
  println(initKey);
  loading(tableCanvas, loadText);
}

void setLoader(String txt, char k) {
  drawDelay = 2;
  keyLoaded = false;
  loadText = txt;
  initKey = k;
  println(initKey);
  loading(tableCanvas, loadText);
}

boolean toggle(boolean bool) {
  if (bool) {
    return false;
  } else {
    return true;
  }
}

int toggleBW(int col) {
  if (col == 255) {
    return 0;
  } else if (col == 0) {
    return 255;
  } else {
    return 0;
  }
}

int nextMode(int mode, int maxMode) {
  if (mode < maxMode) {
    return mode + 1;
  } else {
    return 0;
  }
}

// variables for Scroll Bar
int y_0;
int scroll = 0;
int scroll_0 = 0;

void mousePressed() {
  y_0 = mouseY;
}

void mouseDragged() {
  scroll = scroll_0 + mouseY - y_0;
}

void mouseReleased() {
  scroll_0 = scroll;
}

void mouseClicked() {
  if (editObstacles) {
    boundaries.addVertex(new PVector(mouseX, mouseY));
  }

}

// Runs on a delay
void keyInit() {
  switch(initKey) {
    case '0':
      key_0();
      break;
    case '>':
      key_RightCarrot();
      break;
    case '<':
      key_LeftCarrot();
      break;
    case 'n':
      key_n();
      break;
    case 'E':
      key_E();
      break;
    case 'p':
      key_p();
      break;
    case 'r':
      key_r();
      break;
    case 'X':
      key_X();
      break;
  }
}
  
void key_0() {
  // Restarts the whole sh'bang
  initCanvas();
  initContent(tableCanvas);
  tableCanvas.beginDraw();
  tableCanvas.background(background);
  tableCanvas.endDraw();
}


void key_RightCarrot() {
  // Toggle network for pathfinding
  finderMode = nextMode(finderMode, 3);
  refreshFinder(tableCanvas);
}

void key_LeftCarrot() {
  // Enable/Disable Pathfinding
  enablePathfinding = toggle(enablePathfinding);
  refreshFinder(tableCanvas);
}

void key_n() {
  // randomize/reset current network for pathfinding
  resetFinder(tableCanvas, 10, finderMode);
  refreshFinder(tableCanvas);
}

void key_E() {
  // shows or hides obstale editor 
  editObstacles = toggle(editObstacles);
  println("editObstacles = " + editObstacles);
  if (!editObstacles) { //if deactivapting editor, reinitializes custom network
    // Resets the network for custom mode
    resetFinder(tableCanvas, 10, 2); // '2' for custom mode
    refreshFinder(tableCanvas);
  } else { // If activating editor, sets finder mode to custom
    finderMode = 2;
    refreshFinder(tableCanvas);
    showObstacles = true;
  }
}

void key_p() {
  //makes a grid of obstacles
  testObstacles = toggle(testObstacles);
  testObstacles(tableCanvas, testObstacles);
  // Resets the network for gridded mode
  resetFinder(tableCanvas, 10, finderMode); // '1' for gridded mode
  refreshFinder(tableCanvas);
}

void key_r() {
  //reset agents and simulation
  initAgents(tableCanvas);
}

void key_X() {
  // randomize locations of origin and destination paths
  initOD(tableCanvas);
  initPath(pFinder, A, B);
  pFinderGrid_Viz(tableCanvas);
}
