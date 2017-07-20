boolean showBuffer=true;

PGraphics buffer;

int bufferRange=100;
//float distPerPixel=80*22/table.height ; bufferRange/(80*22/table.height)

void initBuffer(){
  buffer= createGraphics(table.width, table.height);
}

void renderBufferMap(PGraphics a){
  a.beginDraw();
  a.clear();
  //a.background(color(200,0,0,50));
  a.fill(color(200,0,0,150));
  for (int i=0; i<tablePieceInput.length; i++) {
  for (int j=0; j<tablePieceInput[0].length; j++) {
    int ID = tablePieceInput[i][j][0];
    if (ID ==0 || ID==1) {
      a.ellipse(4*i*gridWidth+2*gridWidth,4*j*gridHeight+2*gridHeight,bufferRange/(80*22/table.height),bufferRange/(80*22/table.height));
      //print("PRINT BUFFER TRUE");
    }
  }
  }
  a.endDraw();
}


// Rules:
// distance(B1,Residential)>100m


























public boolean[][] bufferValidation(int[][][] tablePieceInput, int bufferID, int bufferRange) {
  // based on tablePieceInput, for each position (i,j). check the buffer rules are violated or not.
  // Output:
  // for each (i,j), output true (rules are violated )or false.
  //
  // Rules:
  // 1. distance(Industrial-B2, Mixed Use A) > 100
  // 2. distance(Industrial-B2, H-Residential) > 100
  // 3. distance(Industrial-B2, M-Residential) > 100
  // 4. distance(Industrial-B2, L-Residential) > 100

  int nrow = tablePieceInput.length;
  int ncol = tablePieceInput[0].length;
  boolean[][] isBufferID = new boolean[nrow][ncol];
  boolean[][] needBufferValidation = new boolean[nrow][ncol];
  boolean[][] bufferValidationOutput = new boolean[nrow][ncol];

  // step 1: search positions of all target buildings  which is defined by BufferID.
  for (int i = 0; i < nrow; i++) {
    for (int j = 0; j < ncol; j++) {
      if (tablePieceInput[i][j][0] == bufferID) {
        isBufferID[i][j] = true;
      }
    }
  }
  // step 2: use bufferRange to label positions need to be check.
  for (int i = 0; i < nrow; i++) {
    for (int j = 0; j < ncol; j++) {
      if (isBufferID[i][j]) {
        for (int k = Math.max (0, i-bufferRange); k < Math.min(nrow, i+bufferRange+1); k++) {
          for (int l = Math.max (0, j-bufferRange); l< Math.min(ncol, j+bufferRange+1); l++) {
            needBufferValidation[k][l] = true;
          }
        }
      }
    }
  }
  // step 3: check all buildings to see buffer rules are violated or not.
  for (int i = 0; i < nrow; i++) {
    for (int j = 0; j < ncol; j++) {
      //                bufferValidationOutput[i][j] = false;

      if (needBufferValidation[i][j]) {

//        Set<Integer> restrictedBuildingID = new HashSet<>();
//        //Residential Building
//        restrictedBuildingID.add(0);
//        restrictedBuildingID.add(1);
//        restrictedBuildingID.add(2);
//        //Mixed Use A
//        restrictedBuildingID.add(5);


        // check tablePieceInput[i][j][0]
        int buildingID = tablePieceInput[i][j][0];
//        if (!restrictedBuildingID.add(buildingID)) {
        if (buildingID == 0 ||buildingID == 1 ||buildingID == 2 ||buildingID == 5 ) {
          bufferValidationOutput[i][j] = true;
        }
      }
    }
  }
  return bufferValidationOutput;
}