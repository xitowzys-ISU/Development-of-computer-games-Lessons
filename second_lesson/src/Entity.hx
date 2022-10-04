import h2d.Scene;
import hxd.res.Image;
import h2d.Bitmap;
import Vector2D.Vector2d;

class Entity {
    public var location(default, null): Vector2d;
    public var velocity(default, null): Vector2d = Vector2d.zero();
    public var acceleration(default, default) = Vector2d.zero();
    var bm: Bitmap;

    public function new(image: Image, location: Vector2d, scene: Scene, scale=1.0) {
        var tile = image.toTile();
        bm = new Bitmap(tile, scene);
        bm.setScale(scale);
        bm.tile.dx = -bm.tile.width * 0.5;
        bm.tile.dy = -bm.tile.height * 0.5;
        this.location = location;
    }
    public function update(dt: Float) {
        velocity = velocity.add(acceleration.mul(dt));
        location = location.add(velocity);
        acceleration = acceleration.mul(0);
        bm.setPosition(location.x, location.y);    
    }

    public function applyForce(force: Vector2d) {
        acceleration = acceleration.add(force.div(bm.scaleX * 10));
    }

    public function applyBoundaries(xmin, xmax, ymin, ymax) {
        var hwidth = bm.tile.width / 2 * bm.scaleX;
        var hheight = bm.tile.height / 2 * bm.scaleY;

        if (location.x - hwidth < xmin) {
            velocity.x = -velocity.x;
        }
        else if (location.x + hwidth > xmax) {
            velocity.x = -velocity.x;
        }

        if (location.y - hheight < ymin) {
            velocity.y = -velocity.y;
        }
        else if (location.y + hheight > ymax) {
            velocity.y = -velocity.y;
        }
    }

    public function getBoundingBox() {
        return[location.x - bm.tile.width / 2 * bm.scaleX, location.x + bm.tile.width / 2 * bm.scaleX,
                location.y - bm.tile.width / 2 * bm.scaleY, location.y + bm.tile.width / 2 * bm.scaleY];       
    }


}