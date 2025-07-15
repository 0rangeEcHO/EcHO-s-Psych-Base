package states.aechos;

import flixel.addons.display.FlxRuntimeShader;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.keyboard.FlxKey;
import flixel.group.FlxGroup;
import backend.WeekData;
import states.aechos.*;
import haxe.Json;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.Assets;

import states.StoryMenuState;
import states.MainMenuState;

#if (!flash && sys)
import openfl.filters.ShaderFilter;
#end

class TitleState extends MusicBeatState {
    public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];
    public static var initialized:Bool = false;

    var assets:Array<String> = ['hellBack','hellFore','graveBack','graveFore','fountain','echo','nahum','static'];
    var assetGrp:FlxTypedGroup<FlxSprite>;
    public static var left:Bool = false;
    var transitioning:Bool = false;
	public var camGame:FlxCamera;
    public var camFORE:FlxCamera;

    var heatShader:FlxRuntimeShader;

    override public function create() {
        Paths.clearStoredMemory();
		ClientPrefs.loadPrefs();
        Language.reloadPhrases();

        super.create();

        if (!initialized && FlxG.sound.music == null)
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

        FlxG.plugins.add(CitrusUtil.instance = new CitrusUtil());

        camGame = initPsychCamera();
		camFORE = new FlxCamera();

		camFORE.bgColor.alpha = 0;
		FlxG.cameras.add(camFORE, false);
        
        if(ClientPrefs.data.shaders && !ClientPrefs.data.lowQuality) {
            heatShader = new FlxRuntimeShader(Paths.getContent(Paths.exists(Paths.modsShaderFragment('titleShader')) ? Paths.modsShaderFragment('titleShader') : Paths.shaderFragment('titleShader')));
            camGame.setFilters([new ShaderFilter(heatShader)]);
        } else {
            heatShader = null;
        }

        var spr = new FlxSprite().makeGraphic(1, 1, 0xFF101715);
        spr.scale.set(FlxG.width, FlxG.height);
        spr.scrollFactor.set();
        spr.screenCenter();
        add(spr);

        assetGrp = new FlxTypedGroup();
        add(assetGrp);

        final nums:Array<Array<Float>> = [[-104,-82,0.7,0.7],[-107,-29,0.8,0.8],[567,-23,0.7,0.7],[880,-101,0.8,0.8],[495,-17,0.9,0.9],[14,251,1.2,1.2],[773,299,1.2,1.2],[238,608,1.35,1.35]];
        for(i in 0...assets.length) {
            final spr = new SpriteFromSheet(nums[i][0],nums[i][1],'menus/title', assets[i], 24, true);
            spr.updateHitbox();

            spr.scrollFactor.set(nums[i][2], nums[i][3]);
            spr.antialiasing = false;
            assetGrp.add(spr);
            
            CitrusUtil.quickAddSprite([spr]);

            switch(i) {
                case 4: spr.scale.set(1, 1.05);
                case 5: spr.cameras = [camFORE];
                case 6: spr.cameras = [camFORE];
                case 7: 
                    spr.animation.addByPrefix('pressed', 'press', 24, false);
                    spr.animation.play('static');
                    spr.cameras = [camFORE];
                    FlxTween.tween(spr, {y: spr.y - 10}, 2, {ease: FlxEase.sineOut, type: FlxTweenType.PINGPONG});
                default: spr.cameras = [camGame];
            }
        }
    }

    var itime:Float = 0;

    override public function update(elapsed:Float) {
        super.update(elapsed);

        if(heatShader!=null) {
            itime+=elapsed;
            heatShader.setFloat('iTime', itime);
        }

        if(!transitioning && !left && controls.ACCEPT) transition();

        #if debug
        if(controls.RESET) FlxG.resetState();
        #end

        if(!transitioning && !left) {
            if(controls.ACCEPT) transition();
            FlxG.camera.scroll.set(FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.x / 60) - 10, FlxMath.bound(elapsed * 6 / (FlxG.updateFramerate / 20), 0, 1)), FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.y / 60) - 22, FlxMath.bound(elapsed * 6 / (FlxG.updateFramerate / 20), 0, 1)));
            camFORE.scroll.set(FlxMath.lerp(camFORE.scroll.x, (FlxG.mouse.x / 60) - 10, FlxMath.bound(elapsed * 6 / (FlxG.updateFramerate / 20), 0, 1)), FlxMath.lerp(camFORE.scroll.y, (FlxG.mouse.y / 60) - 22, FlxMath.bound(elapsed * 6 / (FlxG.updateFramerate / 20), 0, 1)));
        } else {
            FlxG.camera.scroll.set(FlxMath.lerp(FlxG.camera.scroll.x, 0, 0.05),FlxMath.lerp(FlxG.camera.scroll.y, -7, 0.05));
            camFORE.scroll.set(FlxMath.lerp(camFORE.scroll.x, 0, 0.05),FlxMath.lerp(camFORE.scroll.y, -7, 0.05));
        }
    }

    function transition() {
        transitioning = true;
        left = true;

        assetGrp.members[7].animation.play('pressed');

        final spr = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
        spr.scale.set(FlxG.width, FlxG.height);
        spr.cameras = [camFORE];
        spr.scrollFactor.set();
        spr.screenCenter();
        spr.alpha = 0;
        add(spr);

        FlxTween.tween(spr, {alpha: 1}, 1, {ease: FlxEase.sineOut, onComplete: function(t:FlxTween) {
            transitioning = false;
            MusicBeatState.citrus = false;

            FlxTransitionableState.skipNextTransIn = true;
            MusicBeatState.switchState(new MainMenuState());
        }});
    }
}