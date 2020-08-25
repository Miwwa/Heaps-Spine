import spine.support.graphics.TextureAtlas;
import spine.SkeletonData;
import spine.SkeletonJson;
import spine.attachments.AtlasAttachmentLoader;

class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initEmbed();
        
        new Game();
    }

    var skeletons:Array<spine.SpineAnimation>;

    override function init() 
    {
        skeletons = [];
        
        var spineboyLoader:spine.HeapsTextureLoader = new spine.HeapsTextureLoader("spineboy.png");
        var spineboyAtlasData = hxd.Res.load("spineboy.atlas").toText();
        var spineboyAtlas:TextureAtlas = new TextureAtlas(spineboyAtlasData, spineboyLoader);
        var json:SkeletonJson = new SkeletonJson(new AtlasAttachmentLoader(spineboyAtlas));
        json.setScale(0.6);
        var spineboySkeletonData:SkeletonData = json.readSkeletonData(new spine.HeapsSkeletonFileHandle("spineboy-pro.json"));

        var spineboySkeleton = new spine.SpineAnimation(spineboySkeletonData, s2d);
        spineboySkeleton.state.addListener(new EventListener());
        spineboySkeleton.state.setAnimationByName(0, "walk", true);
        spineboySkeleton.x = 200;
        spineboySkeleton.y = 500;
        skeletons.push(spineboySkeleton);

		var mixAndMatchLoader = new spine.HeapsTextureLoader('mix-and-match.png');
		var minAndMatchAtlasData = hxd.Res.load('mix-and-match.atlas').toText();
        var mixAndMatchAtlas = new TextureAtlas(minAndMatchAtlasData, mixAndMatchLoader);
        var mixAndMatchJson = new SkeletonJson(new AtlasAttachmentLoader(mixAndMatchAtlas));
		var mixAndMatchSkeletonData = mixAndMatchJson.readSkeletonData(new spine.HeapsSkeletonFileHandle("mix-and-match-pro.json"));
        
        var girl = new spine.SpineAnimation(mixAndMatchSkeletonData, s2d);
        girl.skeleton.setSkinByName('full-skins/boy');
		girl.skeleton.setSkinByName('hair/blue');
        girl.setScale(0.5);
        girl.state.setAnimationByName(0, "dance", true);
		girl.x = 400;
        girl.y = 500;
        skeletons.push(girl);
        
		var boy = new spine.SpineAnimation(mixAndMatchSkeletonData, s2d);
		boy.skeleton.setSkinByName('full-skins/girl-spring-dress');
		boy.setScale(0.5);
		boy.state.setAnimationByName(0, "dance", true);
		boy.x = 600;
		boy.y = 500;
		skeletons.push(boy);
    }

    override function update(dt:Float) 
    {
        for (skeleton in skeletons)
        {
            skeleton.advanceTime(dt);
        }
    }
}