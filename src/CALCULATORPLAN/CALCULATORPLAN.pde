
// Emery Carter | Sept 14th 2026 | Calculator
float l, r, result;
char op;
boolean left;
boolean newEntry;
String displayVal;

Button[] numButtons = new Button[10];
Button[] opButtons = new Button[12];

void setup() {
  size(260, 450);
  
  l = 0.0;
  r = 0.0;
  result = 0.0;
  op = ' ';
  left = true;
  newEntry = true;
  displayVal = "0.0";

  // Number Buttons
  numButtons[0] = new Button(20, 260, 40, 40, '0');
  numButtons[1] = new Button(20, 200, 40, 40, '1');
  numButtons[2] = new Button(80, 200, 40, 40, '2');
  numButtons[3] = new Button(140, 200, 40, 40, '3');
  numButtons[4] = new Button(20, 140, 40, 40, '4');
  numButtons[5] = new Button(80, 140, 40, 40, '5');
  numButtons[6] = new Button(140, 140, 40, 40, '6');
  numButtons[7] = new Button(20, 80, 40, 40, '7');
  numButtons[8] = new Button(80, 80, 40, 40, '8');
  numButtons[9] = new Button(140, 80, 40, 40, '9');

  // Operator Buttons
  opButtons[0]  = new Button(200, 80, 40, 40, '÷');
  opButtons[1]  = new Button(200, 140, 40, 40, '×');
  opButtons[2]  = new Button(200, 200, 40, 40, '-');
  opButtons[3]  = new Button(200, 260, 40, 40, '+');
  opButtons[4]  = new Button(20, 320, 40, 40, '.');
  opButtons[5]  = new Button(20, 380, 100, 40, '=');
  opButtons[6]  = new Button(80, 320, 40, 40, ',');
  opButtons[7]  = new Button(140, 260, 40, 40, '±');
  opButtons[8]  = new Button(140, 320, 40, 40, '%');
  opButtons[9]  = new Button(200, 320, 40, 40, '!');
  opButtons[10] = new Button(140, 380, 100, 40, 'C');
  opButtons[11] = new Button(80, 260, 40, 40, '^');
}

void draw() {
  background(#E8DFF5); // Soft lavender background
  updateDisplay();

  for (int i = 0; i < numButtons.length; i++) {
    numButtons[i].mouseOver(mouseX, mouseY);
    numButtons[i].display();
  }
  for (int i = 0; i < opButtons.length; i++) {
    opButtons[i].mouseOver(mouseX, mouseY);
    opButtons[i].display();
  }
}

void updateDisplay() {
  // Display box
  noStroke();
  fill(#FCE1E4);
  rect(20, 20, 220, 45, 12);

  // Text
  fill(#6C5B7B);
  textSize(22);
  textAlign(RIGHT, CENTER);
  text(displayVal, 230, 40);
}

void mouseReleased() {
  // Handle Number Buttons
  for (int i = 0; i < numButtons.length; i++) {
    if (numButtons[i].hover) {
      String digit = str(numButtons[i].val);

      if (newEntry || displayVal.equals("0.0") || displayVal.equals("ERROR")) {
        displayVal = digit;
        newEntry = false;
      } else {
        displayVal += digit;
      }

      if (left) {
        l = float(displayVal);
      } else {
        r = float(displayVal);
      }
    }
  }

  // Handle Operator Buttons
  for (int i = 0; i < opButtons.length; i++) {
    if (opButtons[i].hover) {
      char clicked = opButtons[i].val;

      if (clicked == '=') {
        performCalc();
      } else if (clicked == '+' || clicked == '-' || clicked == '×' || clicked == '÷' || clicked == '^') {
        op = clicked;
        left = false;
        newEntry = true;
      } else if (clicked == 'C') {
        l = 0.0;
        r = 0.0;
        result = 0.0;
        op = ' ';
        left = true;
        newEntry = true;
        displayVal = "0.0";
      } else if (clicked == '.' || clicked == ',') {
        if (!displayVal.contains(".")) {
          displayVal += ".";
          if (left) {
            l = float(displayVal);
          } else {
            r = float(displayVal);
          }
        }
      } else if (clicked == '±') {
        if (!displayVal.equals("0.0") && !displayVal.equals("ERROR")) {
          if (displayVal.startsWith("-")) {
            displayVal = displayVal.substring(1);
          } else {
            displayVal = "-" + displayVal;
          }
          if (left) {
            l = float(displayVal);
          } else {
            r = float(displayVal);
          }
        }
      } else if (clicked == '%') {
        if (left) {
          l = l / 100.0;
          displayVal = str(l);
        } else {
          r = l * (r / 100.0);
          displayVal = str(r);
        }
      } else if (clicked == '!') {
        float valToFactorial = left ? l : r;
        if (valToFactorial >= 0 && valToFactorial <= 20) {
          float factResult = factorial((int)valToFactorial);
          displayVal = str(factResult);
          if (left) {
            l = factResult;
          } else {
            r = factResult;
          }
        } else {
          displayVal = "ERROR";
          newEntry = true;
        }
      }
    }
  }

  printState();
}

void printState() {
  println("l: " + l + " | r: " + r + " | result: " + result + " | left: " + left + " | op: " + op + " | display: " + displayVal);
}

void performCalc() {
  if (op == '+') {
    result = l + r;
  } else if (op == '-') {
    result = l - r;
  } else if (op == '÷') {
    if (r == 0) {
      displayVal = "ERROR";
      newEntry = true;
      return;
    }
    result = l / r;
  } else if (op == '×') {
    result = l * r;
  } else if (op == '^') {
    result = pow(l, r);
  } else {
    return;
  }

  displayVal = str(result);
  l = result;
  r = 0.0;
  left = true;
  newEntry = true;
}

float factorial(int n) {
  if (n <= 1) return 1;
  float fact = 1;
  for (int i = 2; i <= n; i++) {
    fact *= i;
  }
  return fact;
}
