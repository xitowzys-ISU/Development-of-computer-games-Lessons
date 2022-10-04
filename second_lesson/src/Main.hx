import hxd.Window;
import hxd.Key;
import h2d.Scene.ScaleMode;
import Vector2D.Vector2d;
import hxd.res.DefaultFont;
import Entity.Entity;
import Liquid.Liquid;

class Main extends hxd.App {
    var sky: h2d.Bitmap;
    var center: Vector2d;
    var fpsLabel: h2d.Text;
    var tf: h2d.Text;
    var entity: Entity;
    var entity1: Entity;
    var entity2: Entity;
    var gravityOn: Bool = false;
    var windOn: Bool = false;
    var floatingOn: Bool = false;
    var gravity = new Vector2d(0, 3);
    var wind = new Vector2d(3, 0);
    var floating = new Vector2d(0, -4);
    var width: Int;
    var height: Int;
    var liquid: Liquid;
    
    function initScene() {
        var bg = new h2d.Bitmap(hxd.Res.skybox.toTile(), s2d);
        var ground = new h2d.Bitmap(hxd.Res.ground.toTile(), s2d);
        sky = new h2d.Bitmap(hxd.Res.sky_clouds.toTile(), s2d);
        
        bg.setPosition(-30, -30);
        sky.setPosition(-30, -30);
        ground.setPosition(-30, -30);

        width = Std.int(bg.getBounds().width - 60);
        height = Std.int(bg.getBounds().height - 60);
        s2d.scaleMode = ScaleMode.Stretch(width, height);
        center = new Vector2d(width / 2, height / 2);

        fpsLabel = new h2d.Text(DefaultFont.get(), s2d);
        fpsLabel.textColor = 0x006A1E;
        fpsLabel.setScale(2);
        Window.getInstance().addEventTarget(onEvent);
        
    }

    override function init() {
        hxd.Res.initEmbed();
        initScene();
        entity = new Entity(hxd.Res.baloon, center.copy(), s2d, 0.2);
        entity1 = new Entity(hxd.Res.baloon, center.copy(), s2d, 0.4);
        entity2 = new Entity(hxd.Res.baloon, center.copy(), s2d, 0.6);
        liquid = new Liquid(0, width, 2 * height / 3, height, 45.25);
    }

    public static function remap(value: Float, omin: Float, omax: Float, nmin: Float, nmax: Float) {
        return ((value - omin) / (omax - omin)) * (nmax - nmin) + nmin;
    }

    override function update(dt:Float) {
        // fpsLabel.text = 'FPS = ${Math.round(1/dt)}';
        var mouse = new Vector2d(s2d.mouseX, s2d.mouseY);
        var diff = center.sub(mouse);
        var newX = remap(diff.x, -center.x, center.x, -15, 15);
        var newY = remap(diff.y, -center.y, center.y, -10, 10);
        sky.setPosition(-30 + newX, -30 + newY);
        fpsLabel.text = 'Gravity = $gravityOn, Wind = $windOn, Floating = $floatingOn';
        if (gravityOn) {
            entity.applyForce(gravity);
            entity1.applyForce(gravity);
            entity2.applyForce(gravity);
        }
        if (floatingOn) {
            entity.applyForce(floating);
            entity1.applyForce(floating);
            entity2.applyForce(floating);
        }
        if (windOn) {
            entity.applyForce(wind);
            entity1.applyForce(wind);
            entity2.applyForce(wind);
        }

        if (entity.velocity.mag() != 0) {
            var friction = entity.velocity.mul(-1).norm();
            entity.applyForce(friction.mul(0.05));
        }
        if (entity1.velocity.mag() != 0) {
            var friction1 = entity1.velocity.mul(-1).norm();
            entity1.applyForce(friction1.mul(0.05));
        }
        if (entity2.velocity.mag() != 0) {
            var friction2 = entity2.velocity.mul(-1).norm();
            entity2.applyForce(friction2.mul(0.05));
        }

        if (liquid.isInside(entity)) {
            var mag = entity.velocity.mag();
            var drag = liquid.c * mag * mag;
            var dragForce = entity.velocity.mul(-1).norm().mul(drag);
            entity.applyForce(dragForce);
            entity1.applyForce(dragForce);
            entity2.applyForce(dragForce);
        }

        entity.update(dt);
        entity.applyBoundaries(-30, width+30, -30, height+30);
        entity1.update(dt);
        entity1.applyBoundaries(-30, width+30, -30, height+30);
        entity2.update(dt);
        entity2.applyBoundaries(-30, width+30, -30, height+30);
    }

    function onEvent(event: hxd.Event) {
        switch (event.kind) {
            case EKeyDown:{
                switch (event.keyCode) {
                    case hxd.Key.F: floatingOn = !floatingOn;
                    case hxd.Key.G: gravityOn = !gravityOn;
                    case hxd.Key.W: {
                        windOn = !windOn;
                        if (windOn) {
                            wind.x = wind.x * -1;
                        }
                    }
                    case _:
                }
            }
            case _:
        }
    }


    static function main() {
        new Main();
    }
}