/**
 * Library-specific constants
 *
 * @enum
 */
enum SSD1306_CONSTANTS {
    // Display constants
    SETLOWCOLUMN = 0x00
    EXTERNALVCC = 0x01,
    SWITCHCAPVCC = 0x02,
    SETHIGHCOLUMN = 0x10,
    MEMORYMODE = 0x20,
    COLUMNADDR = 0x21,
    PAGEADDR = 0x22,
    RIGHT_HORIZONTAL_SCROLL = 0x26,
    LEFT_HORIZONTAL_SCROLL = 0x27,
    VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL = 0x29,
    VERTICAL_AND_LEFT_HORIZONTAL_SCROLL = 0x2A,
    DEACTIVATE_SCROLL = 0x2E,
    ACTIVATE_SCROLL = 0x2F,
    WRITETOBUFFER = 0x40,
    SETSTARTLINE = 0x40,
    SETCONTRAST = 0x81,
    CHARGEPUMP = 0x8D,
    SEGREMAP = 0xA1,
    SET_VERTICAL_SCROLL_AREA = 0xA3,
    DISPLAYALLON_RESUME = 0xA4,
    DISPLAYALLON = 0xA5,
    NORMALDISPLAY = 0xA6,
    INVERTDISPLAY = 0xA7,
    SETMULTIPLEX = 0xA8,
    DISPLAYOFF = 0xAE,
    DISPLAYON = 0xAF,
    COMSCANINC = 0xC0,
    COMSCANDEC = 0xC8,
    SETDISPLAYOFFSET = 0xD3,
    SETDISPLAYCLOCKDIV = 0xD5,
    SETPRECHARGE = 0xD9,
    SETCOMPINS = 0xDA,
    SETVCOMDETECT = 0xDB,
    // Scrolling constants
    ACTIVATE_SCROLL = 0x2F,
    DEACTIVATE_SCROLL = 0x2E,
    SET_VERTICAL_SCROLL_AREA = 0xA3,
    RIGHT_HORIZONTAL_SCROLL = 0x26,
    LEFT_HORIZONTAL_SCROLL = 0x27,
    VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL = 0x29,
    VERTICAL_AND_LEFT_HORIZONTAL_SCROLL = 0x2A
}

/**
 * Hardware driver for Adafruit 128 x 32 and 128 x 64 OLED displays
 * based on the Solomon SSD§1306 controller.
 * For example: http://www.adafruit.com/products/931
 *
 * Bus          I2C
 * Availibility Device
 * @author      Tony Smith (@smittytone)
 * @license     MIT
 *
 * @class
 */
class SSD1306OLED {

    /**
     * @property {string} VERSION - The library version
     */
    static VERSION = "1.0.0";

    /**
     * @property {array} CHARSET - The proportionally spaced alphanumeric character set
     */
    static CHARSET_COUNT = 96;
    static CHARSET = [
        "\x00\x00",             // space - Ascii 32
        "\xfa",                 // !
        "\xe0\xc0\x00\xe0\xc0", // "
        "\x24\x7e\x24\x7e\x24", // #
        "\x24\xd4\x56\x48",     // $
        "\xc6\xc8\x10\x26\xc6", // %
        "\x6c\x92\x6a\x04\x0a", // &
        "\xc0",                 // '
        "\x7c\x82",             // (
        "\x82\x7c",             // )
        "\x10\x7c\x38\x7c\x10", // *
        "\x10\x10\x7c\x10\x10", // +
        "\x06\x07",             // ,
        "\x10\x10\x10\x10\x10", // -
        "\x06\x06",             // .
        "\x04\x08\x10\x20\x40", // /
        "\x7c\x8a\x92\xa2\x7c", // 0 - Ascii 48
        "\x42\xfe\x02",         // 1
        "\x46\x8a\x92\x92\x62", // 2
        "\x44\x92\x92\x92\x6c", // 3
        "\x18\x28\x48\xfe\x08", // 4
        "\xf4\x92\x92\x92\x8c", // 5
        "\x3c\x52\x92\x92\x8c", // 6
        "\x80\x8e\x90\xa0\xc0", // 7
        "\x6c\x92\x92\x92\x6c", // 8
        "\x60\x92\x92\x94\x78", // 9
        "\x36\x36",             // : - Ascii 58
        "\x36\x37",             // ;
        "\x10\x28\x44\x82",     // <
        "\x24\x24\x24\x24\x24", // =
        "\x82\x44\x28\x10",     // >
        "\x60\x80\x9a\x90\x60", // ?
        "\x7c\x82\xba\xaa\x78", // @
        "\x7e\x90\x90\x90\x7e", // A - Ascii 65
        "\xfe\x92\x92\x92\x6c", // B
        "\x7c\x82\x82\x82\x44", // C
        "\xfe\x82\x82\x82\x7c", // D
        "\xfe\x92\x92\x92\x82", // E
        "\xfe\x90\x90\x90\x80", // F
        "\x7c\x82\x92\x92\x5c", // G
        "\xfe\x10\x10\x10\xfe", // H
        "\x82\xfe\x82",         // I
        "\x0c\x02\x02\x02\xfc", // J
        "\xfe\x10\x28\x44\x82", // K
        "\xfe\x02\x02\x02\x02", // L
        "\xfe\x40\x20\x40\xfe", // M
        "\xfe\x40\x20\x10\xfe", // N
        "\x7c\x82\x82\x82\x7c", // O
        "\xfe\x90\x90\x90\x60", // P
        "\x7c\x82\x92\x8c\x7a", // Q
        "\xfe\x90\x90\x98\x66", // R
        "\x64\x92\x92\x92\x4c", // S
        "\x80\x80\xfe\x80\x80", // T
        "\xfc\x02\x02\x02\xfc", // U
        "\xf8\x04\x02\x04\xf8", // V
        "\xfc\x02\x3c\x02\xfc", // W
        "\xc6\x28\x10\x28\xc6", // X
        "\xe0\x10\x0e\x10\xe0", // Y
        "\x86\x8a\x92\xa2\xc2", // Z - Ascii 90
        "\xfe\x82\x82",         // [
        "\x40\x20\x10\x08\x04", // \
        "\x82\x82\xfe",         // ]
        "\x20\x40\x80\x40\x20", // ^
        "\x02\x02\x02\x02\x02", // _
        "\xc0\xe0",             // '
        "\x04\x2a\x2a\x2a\x1e", // a - Ascii 97
        "\xfe\x22\x22\x22\x1c", // b
        "\x1c\x22\x22\x22",     // c
        "\x1c\x22\x22\x22\xfc", // d
        "\x1c\x2a\x2a\x2a\x10", // e
        "\x10\x7e\x90\x90\x80", // f
        "\x18\x25\x25\x25\x3e", // g
        "\xfe\x20\x20\x20\x1e", // h
        "\xbe\x02",             // i
        "\x02\x01\x01\x21\xbe", // j
        "\xfe\x08\x14\x22",     // k
        "\xfe\x02",             // l
        "\x3e\x20\x18\x20\x1e", // m
        "\x3e\x20\x20\x20\x1e", // n
        "\x1c\x22\x22\x22\x1c", // o
        "\x3f\x22\x22\x22\x1c", // p
        "\x1c\x22\x22\x22\x3f", // q
        "\x22\x1e\x22\x20\x10", // r
        "\x12\x2a\x2a\x2a\x04", // s
        "\x20\x7c\x22\x22\x04", // t
        "\x3c\x02\x02\x3e",     // u
        "\x38\x04\x02\x04\x38", // v
        "\x3c\x06\x0c\x06\x3c", // w
        "\x22\x14\x08\x14\x22", // x
        "\x39\x05\x06\x3c",     // y
        "\x26\x2a\x2a\x32",     // z - Ascii 122
        "\x10\x7c\x82\x82",     // {
        "\xee",                 // |
        "\x82\x82\x7c\x10",     // }
        "\x40\x80\x40\x80",     // ~
        "\x60\x90\x90\x60"      // Degrees sign - Ascii 127
    ]

    // ********** PRIVATE PROPERTIES **********
    _address = 0x3C;
    _i2c = null;
    _rst = null;
    _buffer = null;
    _width = 128;
    _height = 32;
    _x = 0;
    _y = 0;

    /**
     *  Instantiate the display object
     *
     *  @constructor
     *
     *  @param {imp::i2c} i2cBus        - Whichever configured imp I2C bus is to be used for the SSD1306
     *  @param {imp::pin} rstPin        - An imp pin to be used for the RESET line
     *  @param {integer}  [address]     - I2C address of the SSD1306. Default: 0x3C
     *  @param {integer}  [pixelWidth]  - Width of the OLED in pixels. Default: 128
     *  @param {integer}  [pixelHeight] - Height of the OLED in pixels. Default: 32
     *
     *  @returns {instance} The instance
     */
    constructor(i2cBus, rstPin, address = 0x3C, pixelWidth = 128, pixelHeight = 32) {
        if (i2cBus == null || address == 0) throw "SSD1306OLED() requires a non-null imp I2C bus object and a non-zero I2C address";
        _i2c = i2cBus;
        _address = address << 1;
        _rst = rstPin;
        _width = pixelWidth;
        _height = pixelHeight;
        _buffer = blob(_width * _height / 8);
    }

    /**
     *  Initialize the display
     */
    function init() {
        //  Toggle the RST pin over 1ms + 10ms
        _rst.write(1)
        imp.sleep(0.001)
        _rst.write(0)
        imp.sleep(0.01)
        _rst.write(1);

        // Write the display settings
        local pages = (_height / 8) - 1;
        _write(true, _makeChar(SSD1306_CONSTANTS.DISPLAYOFF))
        _write(true, _makeChar(SSD1306_CONSTANTS.SETDISPLAYCLOCKDIV) + "\x80")
        _write(true, _makeChar(SSD1306_CONSTANTS.SETMULTIPLEX) + _makeChar(_height - 1))
        _write(true, _makeChar(SSD1306_CONSTANTS.SETDISPLAYOFFSET) + "\x00")
        _write(true, _makeChar(SSD1306_CONSTANTS.SETSTARTLINE))
        _write(true, _makeChar(SSD1306_CONSTANTS.CHARGEPUMP) + "\x14")
        _write(true, _makeChar(SSD1306_CONSTANTS.MEMORYMODE) + "\x00")
        _write(true, _makeChar(SSD1306_CONSTANTS.SEGREMAP))
        _write(true, _makeChar(SSD1306_CONSTANTS.COMSCANDEC) + _makeChar(_height == 32 || _height == 16 ? 0x02 : 0x12));
        _write(true, _makeChar(SSD1306_CONSTANTS.SETCONTRAST) + "\x8F")
        _write(true, _makeChar(SSD1306_CONSTANTS.SETPRECHARGE) + "\xF1")
        _write(true, _makeChar(SSD1306_CONSTANTS.SETVCOMDETECT) + "\x40")
        _write(true, _makeChar(SSD1306_CONSTANTS.DISPLAYALLON_RESUME))
        _write(true, _makeChar(SSD1306_CONSTANTS.NORMALDISPLAY))
        _write(true, _makeChar(SSD1306_CONSTANTS.DISPLAYON))
        _write(true, _makeChar(SSD1306_CONSTANTS.COLUMNADDR) + "\x00" + _makeChar(_width - 1));
        _write(true, _makeChar(SSD1306_CONSTANTS.PAGEADDR) + "\x00" + _makeChar(pages));

        // Clear the display
        clear();
        draw();
    }

    /**
     *  Output the buffer to the display
     */
    function draw() {
        _write(false, _buffer.tostring());
    }

    /**
     *  Clear the display buffer
     *  You must call 'draw()' to update the display
     *
     *  @returns {instance} The instance
     */
    function clear() {
        _buffer = blob(_width * _height / 8);
        return this;
    }

    /**
     *  Move the cursor to the home position
     *
     *  @returns {instance} The instance
     */
    function home() {
        move(0, 0);
        return this;
    }

    /**
     *  Move the cursor to the specified position
     *
     *  @param {integer} x - The column value.
     *  @param {integer} y - The row value.
     *
     *  @returns {instance} The instance
     */
    function move(x, y) {
        if (x < 0 || x > (_width - 1) || y < 0 || y > (_height - 1)) {
            server.error("SSD1306OLED.move() co-ordinates out of range");
        } else {
            _x = x;
            _y = y;
        }

        return this;
    }

    /**
     *  Set or unset the pixel at the specified position
     *  You must call 'draw()' to update the display
     *
     *  @param {integer} x        - The column value.
     *  @param {integer} y        - The row value.
     *  @param {integer} [colour] - The colour: 1 (set) or 0 (clear). Default: set
     *
     *  @returns {instance} The instance
     */
    function plot(x, y, color = 1) {
        if (x < 0 || x > (_width - 1) || y < 0 || y > (_height - 1)) {
            server.error("SSD1306OLED.plot() co-ordinates out of range");
        } else {
            // Get the buffer byte holding the pixel
            local byte = _coordsToIndex(x, y);
            local value = _buffer[byte];

            // Get the specific bit representing the pixel
            local bit = y - ((y >> 3) << 3);

            if (color == 1) {
                // Set the pixel
                value = value | (1 << bit);
            } else {
                // Clear the pixel
                value = value & ~(1 << bit);
            }

            // Write the buffer byte back
            _buffer[byte] = value;
        }

        return this;
    }

    /**
     *  Add the specific text to the buffer
     *  You must call 'draw()' to update the display
     *
     *  @param {string} printString - The string to print
     *
     *  @returns {instance} The instance
     */
    function text(printString = "") {
        if (printString == "" || printString.len() == 0) {
            server.error("SSD1306OLED.text() string must not be zero-length");
        } else {
            // Get the cursor position
            local x = _x;
            local y = _y;

            // Run through the string's characters, adding them to the buffer
            for (local i = 0 ; i < printString.len() ; i++) {
                local asc = printString[i] - 32;
                local glyph = CHARSET[asc];
                local c = 0;
                local z = 0;

                for (local j = 0 ; j < glyph.len() + 1; j++) {
                    c = (j == glyph.len() && x < 128) ? 0x00 : _flip(glyph[j]);
                    z = -1;

                    for (local k = 0 ; k < 8 ; k++) {
                        if (((y + k) % 8) == 0 && k != 0) {
                            z = 0
                        } else {
                            z += 1
                        }

                        local b = _coordsToIndex(x , y + k)
                        local v = _buffer[b];
                        local d = 1 << z;
                        if ((c & d) > 0) v = v | d;
                        _buffer[b] = v;
                    }

                    // Move on one pixel
                    x += 1;
                    if (x > _width - 1) {
                        // Right side hit, so move to next text line
                        if (y + 8 < _height) {
                            x = 0;
                            y += 8;
                        } else {
                            break;
                        }
                    }
                }
            }
        }

        return this;
    }

    // ********** PRIVATE FUNCTIONS **********

    function _makeChar(value) {
        // Convert an integer to a char
        return format("%c", value);
    }

    function _write(isCommand, data) {
        // Write a commmand or data to the display via I2C
        local pre = isCommand ? "\x00" : "\x40";
        local r = _i2c.write(_address, pre + data);
        if (r != 0) server.error("I2C read/write: " + r);
    }

    function _coordsToIndex(x, y) {
        // Convert pixel co-ordinates to a bytearray index
        return ((y >> 3) * _width) + x;
    }

    function _indexToCoords(idx) {
        // Convert bytearray index to pixel co-ordinates
        local y = idx >> 4;
        local x = idx - (y << 4);
        return [x, y];
    }

    function _flip(value) {
        // Rotates the character array from the saved state
        local flipped = 0;
        for (local i = 0 ; i < 8 ; i++) {
            if ((value & (1 << i)) > 0) flipped += (1 << (7 - i));
        }
        return flipped;
    }
}
