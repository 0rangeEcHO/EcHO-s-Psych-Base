package states.aechos;

class MainMenuSubstate extends MusicBeatSubstate {
    var assets:Array<String> = ['hellBack','hellFore','graveBack','graveFore','fountain','echo','nahum','logo'];
    var assetGrp:FlxTypedGroup<FlxSprite>;

    var transitioning:Bool = false;
    var left:Bool = false;

    override public function create() {
        super.create();

        assetGrp = new FlxTypedGroup();
        add(assetGrp);

        final nums:Array<Array<Float>> = [[0,0,1,1],[0,0,1,1],[0,0,1,1],[0,0,1,1],[0,0,1,1]];
        for(i in 0...assets.length) {
            final spr = new SpriteFromSheet(nums[i][0],nums[i][0],'menus/main', assets[i], 12, true);
            spr.scrollFactor.set(nums[i][2], nums[i][3]);
            assetGrp.add(spr);
        }
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        if(!transitioning && !left) {
            if(controls.ACCEPT) transition();
            FlxG.camera.scroll.set(FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.x / 60) - 10, FlxMath.bound(elapsed * 6 / (FlxG.updateFramerate / 20), 0, 1)), FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.y / 60) - 22, FlxMath.bound(elapsed * 6 / (FlxG.updateFramerate / 20), 0, 1)));
        } else {
            FlxG.camera.scroll.set(FlxMath.lerp(FlxG.camera.scroll.x, 0, 0.05),FlxMath.lerp(FlxG.camera.scroll.y, 0, 0.05));
        }
    }

    function transition() {
        transitioning = true;
        left = true;

        final spr = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
        spr.scale.set(FlxG.width, FlxG.height);
        spr.scrollFactor.set();
        spr.screenCenter();
        spr.alpha = 0;
        add(spr);

        FlxTween.tween(spr, {alpha: 0}, 1, {ease: FlxEase.sineOut, onComplete: function(t:FlxTween) {
            transitioning = false;
        }});
    }
}