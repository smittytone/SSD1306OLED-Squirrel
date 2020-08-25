# SSD1306OLED Squirrel 1.0.0 #

A hardware driver for the [Adafruit 128x32 OLED](https://www.adafruit.com/product/931) and [Adafruit 128x64 OLED](https://www.adafruit.com/product/326) panels, which are based on the Solomon SSD1306 controller. The OLEDs communicate over any I&sup2;C bus.

### Character Set ###

The driver contains a full, proportionally spaced Ascii character set.

### I2C Addressing ###

The displays have the following default I2C addresses:

- 128x32 — `0x3C`
- 128x64 — `0x3D`

The first of these is the constructor default, so you will need to pass in the second value if you are using the larger panel. You will need to pass in an alternative address if you have changed it at the board level.

## Class Usage ##

### Constructor: SSD1306OLED(*i2cBus, rstPin, [i2cAddress][, height][, width]*) ###

To instantiate an SSD1306OLED object pass the reset pin and I&sup2;C bus to which the display is connected, and, optionally, its I&sup2;C address, pixel height and pixel width. If no address is passed, the default value, `0x3C` will be used. The default pixel dimensions are 128 x 32.

The passed reset pin and I&sup2;C bus must be configured before the SSD1306OLED object is created.

#### Example ####

```squirrel
// Set up on imp001-based board
displayI2C <- hardware.i2c89;
displayI2C.configure(CLOCK_SPEED_100_KHZ);

// Set up the RST pin
resetPin <- hardware.pin2;
resetPin.configure(DIGITAL_OUT, 0);

// Set up OLED display at the default address
display <- SSD1306OLED(displayI2C, resetPin);
```

## Class Methods ##

### clear() ###

This method clears the driver’s graphics buffer. It does not update the screen — call [*draw()*](#draw) to do so.

*clear()* returns a reference to the driver instance in order to allow command chaining. For example:

```squirrel
display.clear().text("Hello, World!").draw();
```

### draw() ###

This method is used to write the contents of the driver’s buffer to the display itself.

#### Example ####

```squirrel
// Draw a diagonal line
display.home().line(127, 31).draw();
```

### inverse(*makeInverse*) ###

This method is called to set the display to black-on-white (`true`) or white-on-black (`false`). It defaults to `true`.

### move(*x, y*) ###

This method moves the text cursor to the specified co-ordinates.

### home() ###

This method moves the text cursor to the home position: the top left of the screen (co-ordinates (0,0).

### plot(*x, y[, colour]*) ###

This sets or clears a single pixel, specified by its co-ordinates, on the display. It does not update the screen — call [*draw()*](#draw) to do so.

By default, *plot()* uses the current ink colour: white for a white-on-black display, or black for black-on-white (see [*inverse()*](#inverse-makeinverse)), but you can set the ink colour to clear the pixel instead. Pass 1 for the foreground colour (the default) or 0 for the background colour.

*plot()* returns a reference to the driver instance in order to allow command chaining.

#### Example ####

```squirrel
# Put dots in the corners
display.plot(0,0).plot(0,31);
display.plot(127,0).plot(127,31);
display.draw();
```

### line(*tox, toy[, thickness][, colour])* ###

This method draws a line between the current cursor co-ordinates and (tox,toy) of the required thickness. If no thickness is specified the method defaults to a single pixel. If no ink colour is specified, the method defaults to the current foreground colour.

*line()* returns a reference to the driver instance in order to allow command chaining. It does not update the screen — call [*draw()*](#draw) to do so.

**Note** This method moves the cursor co-ordinates to the end of the line (or the edge of the display if the line extends beyond it).

#### Example ####

```squirrel
// Draw two diagonal lines
display.move(0, 0).line(127,31).move(127, 0).line(0,31).draw();
```

### circle(*radius[, colour][, fill]*) ###

This method draws a circle centred on the current cursor co-ordinates and with the specified radius. If no ink colour is specified, the method defaults to the current foreground colour. You can also opt to pass `true` into the *fill* parameter to create a solid circle; otherwise an outline will be drawn.

*circle()* does not update the screen — call [*draw()*](#draw) to do so.

#### Example ####

```squirrel
// Draw two filled circles side by side
display.move(47, 16).circle(14, 1, true).move(81, 16).circle(14, 1, true).draw();
```

## Release Notes ##

- 1.0.0 *Unreleased*
    - Initial public release

## License ##

The SSD1306OLED library is licensed under the [MIT License](LICENSE).
