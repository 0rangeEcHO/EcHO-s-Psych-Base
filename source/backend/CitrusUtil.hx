package backend;

import flixel.FlxObject;
import flixel.FlxBasic;

class CitrusUtil extends FlxBasic {
    public static var instance:CitrusUtil = new CitrusUtil();
    public static var spriteList:Array<FlxSprite> = [];
    public static var textList:Array<FlxText> = [];
    public var oneSelected:Int;
    
    public static var spriteSelected:Bool = true;

    public function new() {
        super();
    }

    public static function grabSprite():CitrusUtil {
        return instance;
    }

    public function addSpriteToDebug(sprite:Array<FlxSprite>) {
        spriteList = spriteList.concat(sprite);
        oneSelected = spriteList.length - 1;
        //trace(spriteList.toString()); idk how to make it trace the names of the sprites
        trace("Selected sprite num: " + oneSelected);
    }

    public function addTextToDebug(text:Array<FlxText>) {
        textList = textList.concat(text);
        oneSelected = textList.length - 1;
        //trace(spriteList.toString()); idk how to make it trace the names of the sprites
        trace("Selected text num: " + oneSelected);
    }

    override public function update(elapsed:Float) {
		super.update(elapsed);

        if (spriteList.length == 0 && textList.length == 0) return;

        if(spriteList.length != 0) {
            if(spriteSelected) {
                if (FlxG.keys.justPressed.PERIOD) {
                    if(oneSelected != spriteList.length - 1) oneSelected += 1; else oneSelected = 0;
                    trace("Selected sprite num: " + oneSelected);
                }
                if (FlxG.keys.justPressed.COMMA) {
                    if(oneSelected != 0) oneSelected -= 1; else oneSelected = spriteList.length - 1;
                    trace("Selected sprite num: " + oneSelected);
                }
            } else {
                if(oneSelected > spriteList.length - 1) oneSelected = 0;
                spriteSelected = false;
                trace('Sprite now selected!');
            }
        }

        if(textList.length != 0) {
            if(!spriteSelected) {
                if(FlxG.keys.justPressed.RBRACKET) {
                    if(oneSelected != textList.length - 1) oneSelected += 1; else oneSelected = 0;
                    trace("Selected text num: " + oneSelected);
                }
                if (FlxG.keys.justPressed.LBRACKET) {
                    if(oneSelected != 0) oneSelected -= 1; else oneSelected = textList.length - 1;
                    trace("Selected text num: " + oneSelected);
                }
            } else {
                if(oneSelected > textList.length - 1) oneSelected = 0;
                spriteSelected = false;
                trace('Text now selected!');
            }
        }

        if(spriteSelected) {
            if (FlxG.keys.justPressed.LEFT) spriteList[oneSelected].x += FlxG.keys.pressed.SHIFT ? -10 : -1;
            if (FlxG.keys.justPressed.RIGHT) spriteList[oneSelected].x += FlxG.keys.pressed.SHIFT ? 10 : 1;
            if (FlxG.keys.justPressed.UP) spriteList[oneSelected].y += FlxG.keys.pressed.SHIFT ? -10 : -1;
            if (FlxG.keys.justPressed.DOWN) spriteList[oneSelected].y += FlxG.keys.pressed.SHIFT ? 10 : 1;
            if (FlxG.keys.justPressed.Z) {
                spriteList[oneSelected].scale.y += FlxG.keys.pressed.SHIFT ? 0.2 : 0.05;
                spriteList[oneSelected].scale.x += FlxG.keys.pressed.SHIFT ? 0.2 : 0.05;
                spriteList[oneSelected].updateHitbox();
            }
            if (FlxG.keys.justPressed.X) {
                spriteList[oneSelected].scale.y -= FlxG.keys.pressed.SHIFT ? 0.2 : 0.05;
                spriteList[oneSelected].scale.x -= FlxG.keys.pressed.SHIFT ? 0.2 : 0.05;
                spriteList[oneSelected].updateHitbox();
            }
        } else {
            if (FlxG.keys.justPressed.LEFT) textList[oneSelected].x += FlxG.keys.pressed.SHIFT ? -10 : -1;
            if (FlxG.keys.justPressed.RIGHT) textList[oneSelected].x += FlxG.keys.pressed.SHIFT ? 10 : 1;
            if (FlxG.keys.justPressed.UP) textList[oneSelected].y += FlxG.keys.pressed.SHIFT ? -10 : -1;
            if (FlxG.keys.justPressed.DOWN) textList[oneSelected].y += FlxG.keys.pressed.SHIFT ? 10 : 1;
            if (FlxG.keys.justPressed.Z) textList[oneSelected].size += FlxG.keys.pressed.SHIFT ? 10 : 1;
            if (FlxG.keys.justPressed.X && textList[oneSelected].size >= 11) textList[oneSelected].size -= FlxG.keys.pressed.SHIFT ? 10 : 1;
        }

        if (FlxG.keys.justPressed.ALT) {
            if(spriteSelected) {
                trace('Sprite $oneSelected' + ' X: ' + spriteList[oneSelected].x + ' | Sprite $oneSelected' + ' Y: ' + spriteList[oneSelected].y + ' | Sprite $oneSelected Scale: ' + spriteList[oneSelected].scale.x);
            } else {
                trace('Text $oneSelected' + ' X: ' + textList[oneSelected].x + ' | Text $oneSelected' + ' Y: ' + textList[oneSelected].y + ' | Text $oneSelected Scale: ' + textList[oneSelected].size);
            }
        }
    }

    public static function quickAddSprite(sprite:Array<FlxSprite>) {
        CitrusUtil.grabSprite().addSpriteToDebug(sprite);
        spriteSelected = true;
    }

    public static function quickAddText(text:Array<FlxText>) {
        CitrusUtil.grabSprite().addTextToDebug(text);
        spriteSelected = false;
    }
}