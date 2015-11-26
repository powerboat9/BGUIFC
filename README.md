# BGUIFC
Better Graphical User Interface For Computercraft.

# Documentation
This will come later, after the code works

hexToNumber(hexadecimal code) - Turns a string in hexadecimal into a base-10 number.

getScreen(terminal object, layers) - Creates a screen object with a certain amount of layers.

screen:writeChar(layer, character to write, color of the character, background color for the character).

screen:clearLine(layer, line to clear) - Clears a line.

screen:clear(layer) - Clears a layer.

screen:clearLayerRange(first layer to clear, last layer to clear) - Clears a range of layers.

screen:scroll(layer) - Scrolls the layer.

screen:blit(layer, text to write, text color, background color of text) - Writes text to layer.

Please note that the color is a value between 1 and 16, inclusive. You can't use the color api.
