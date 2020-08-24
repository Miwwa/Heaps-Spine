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
        var alienAtlas:TextureAtlas = new TextureAtlas(spineboyAtlasData, spineboyLoader);
        
        // You can load animations from json files:
        var json:SkeletonJson = new SkeletonJson(new AtlasAttachmentLoader(alienAtlas));
        json.setScale(0.6);
        var spineboySkeletonData:SkeletonData = json.readSkeletonData(new spine.HeapsSkeletonFileHandle("spineboy-pro.json"));

        var spineboySkeleton = new spine.SpineAnimation(spineboySkeletonData, s2d);
        spineboySkeleton.state.addListener(new EventListener());
        spineboySkeleton.state.setAnimationByName(0, "walk", true);
        spineboySkeleton.x = 200;
        spineboySkeleton.y = 500;
        skeletons.push(spineboySkeleton);
    }

    override function update(dt:Float) 
    {
        for (skeleton in skeletons)
        {
            skeleton.advanceTime(dt);
        }
    }
}