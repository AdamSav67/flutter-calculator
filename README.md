# Flutter Calculator App

A fully-functional Flutter calculator with accumulator display, supporting proper order of operations and error handling.

## Features

### Core Functionality
- **Accumulator Display**: Shows both the input expression and the result of calculations
- **Developer Title**: Displays "Calculator - Alex Johnson" at the top
- **All Basic Operations**: Support for addition (+), subtraction (-), multiplication (*), and division (/)
- **Number Input**: Digits 0-9 with decimal point support
- **Clear Function**: Button to reset the calculator
- **Backspace Function**: Delete the last entered digit
- **Equals Function**: Evaluate the current expression

### User Interface
- **Dark Theme**: Professional dark calculator interface with good contrast
- **Responsive Layout**: Buttons arranged in standard calculator layout
- **Color Coding**:
  - Red: Clear button (C)
  - Orange: Backspace button (⌫)
  - Blue: Operator buttons (+, -, *, /)
  - Green: Equals button (=)
  - Gray: Number buttons (0-9, .)
- **Large Display**: Easy-to-read font with expression and result on separate lines

### Mathematical Features
- **Order of Operations**: Follows PEMDAS/BODMAS rules
  - Multiplication and Division are evaluated before Addition and Subtraction
  - Operations of the same precedence are evaluated left to right
- **Decimal Support**: Full support for decimal numbers
- **Error Handling**: Gracefully handles invalid operations (e.g., division by zero)

## Implementation Details

### Technology Stack
- **Framework**: Flutter
- **Language**: Dart
- **Expression Parser**: `expressions: ^0.2.5` package

### Key Components

#### CalculatorApp
- Root widget that sets up the MaterialApp with theme configuration
- Uses BlueAccent as the primary color with Material 3 design

#### CalculatorScreen
- Stateful widget managing the calculator's user interface
- Displays the input expression and calculated result

#### _CalculatorScreenState
- Manages the calculator's state with three main variables:
  - `_display`: Current number being displayed
  - `_expression`: The accumulated expression string
  - `_shouldResetDisplay`: Flag to reset display when starting new calculation

### State Management Methods

#### `_onNumberPressed(String number)`
- Handles digit and decimal point input
- Prevents multiple decimal points in a single number
- Replaces display with new number after operator is pressed

#### `_onOperatorPressed(String operator)`
- Adds operator to the expression string
- Sets flag to reset display on next number input

#### `_onEqualsPressed()`
- Evaluates the complete expression using the `expressions` package
- Handles result formatting (removes trailing zeros)
- Catches exceptions and displays "Error" for invalid operations

#### `_onClearPressed()`
- Resets all state variables to initial values
- Clears both display and expression

#### `_onBackspacePressed()`
- Removes the last character from the display
- Sets display to '0' if empty

## Testing

The app includes comprehensive unit tests in `test/calculator_test.dart` covering all calculation logic:

### Test Results
✅ **All 25 tests passing** - Validating calculator correctness across various scenarios

### Test Categories

1. **Basic Arithmetic Operations**
   - Addition: 2 + 3 = 5
   - Subtraction: 10 - 4 = 6
   - Multiplication: 5 * 6 = 30
   - Division: 20 / 4 = 5

2. **Order of Operations**
   - Multiplication before Addition: 2 + 3 * 4 = 14
   - Division before Subtraction: 20 - 10 / 2 = 15
   - Complex expressions with multiple operators
   - Left-to-right evaluation for same precedence

3. **Decimal Numbers**
   - Decimal arithmetic: 1.5 + 2.5 = 4
   - Decimal multiplication: 2.5 * 4 = 10
   - Decimal division: 7.5 / 2.5 = 3

4. **Edge Cases**
   - Division by Zero: Displays "Error"
   - Single numbers: 42 = 42
   - Zero operations: 0 + 0 = 0
   - Negative results: 5 - 10 = -5
   - Large numbers: 1000 * 1000 = 1,000,000

5. **Long Expressions**
   - Five operands: 2 + 3 + 4 + 5 + 6 = 20
   - Mixed long expressions with proper precedence
   - Ten operands: 1+1+1+1+1+1+1+1+1+1 = 10

6. **Floating Point Precision**
   - Proper handling of floating point arithmetic
   - Tests for results very close to expected values

7. **Trailing Zero Removal**
   - Cleans up display results: 10 / 2 = 5 (not 5.0)
   - Preserves meaningful decimals: 1 / 2 = 0.5

### Running Tests

```bash
flutter test
```

All 25+ tests validate the calculator's correctness across various scenarios.

## Usage Examples

### Example 1: Simple Calculation
```
Input: 2 + 3 =
Display: 2 + 3
Result: 5
```

### Example 2: Complex Expression with Order of Operations
```
Input: 2 + 3 * 4 =
Display: 2 + 3 * 4
Result: 14 (not 20, because * has higher precedence)
```

### Example 3: Using Backspace
```
Input: 125 (then backspace)
Display: 12 (last digit removed)
```

### Example 4: Clear Function
```
Input: 5 + 3 C
Display: 0 (cleared)
Expression: (empty)
```

### Example 5: Error Handling
```
Input: 5 / 0 =
Display: Error (graceful error handling)
```

## Code Quality

### Error Handling
- Try-catch blocks around expression evaluation
- Validation for multiple decimal points
- Safe handling of division by zero

### UI/UX Considerations
- Intuitive button layout matching traditional calculators
- Clear visual feedback through color coding
- Readable fonts and spacing for accessibility
- Proper handling of text overflow in display

### Code Organization
- Separated concerns with individual methods for each operation
- Reusable `_buildButtonRow()` and `_buildButton()` helper methods
- Clear state management with descriptive variable names
- Proper use of Flutter's `setState()` for UI updates

## Getting Started

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Dart SDK
- expressions package (^0.2.5)

### Installation

1. Clone or download the project
2. Navigate to the project directory
3. Run: `flutter pub get`
4. Run the app: `flutter run`
5. Run tests: `flutter test`

## Future Enhancements

Possible improvements could include:
- History of previous calculations
- Memory functions (M+, M-, MR, MC)
- Scientific calculator mode with advanced functions
- Keyboard input support
- Landscape mode optimization
- Theme customization
- Sound effects for button presses
