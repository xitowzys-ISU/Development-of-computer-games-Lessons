import Random;
import Noise;

class Fly {
	var bm:h2d.Bitmap;
	var speed:Float;

	public function new(image, speed, scene, x:Float, y:Float) {
		bm = new h2d.Bitmap(image, scene);
		bm.tile.dx = -bm.tile.width * 0.5;
		bm.tile.dy = -bm.tile.height * 0.5;
		bm.x = x;
		bm.y = y;
		this.speed = speed;
	}

	public function update(dt:Float) {
		bm.x += speed;
		bm.y += speed;
	}

	public function toString() {
		return 'Fly(${this.bm.x}, ${this.bm.y})';
	}
}

class RandomFly extends Fly {
	public override function update(dt:Float) {
		var step = Random.int(0, 3);

		switch (step) {
			case 0:
				bm.y -= speed;
			case 1:
				bm.y += speed;
			case 2:
				bm.x -= speed;
			case 3:
				bm.x += speed;
		}
	}
}

class PerlinFly extends Fly {
	var noiseX = new Noise();
	var noiseY = new Noise();

	var tx = 0.0;
	var ty = 0.0;

	public override function update(dt:Float) {
		var nX = Noise.remap(noiseX.perlin(tx, 0, 0), -1, 1, 0, Window.getInstance().width);
		var nY = Noise.remap(noiseX.perlin(ty, 0, 0), -1, 1, 0, Window.getInstance().height);

		tx += 0.02;
		ty += 0.01;

		this.bm.x = nX;
		this.bm.y = nY;
	}
}d

class PurposefulFly extends Fly {
	public override function update(dt:Float) {
		var step = Random.float(0, 1);

		if (step < 0.6) {
			bm.x += speed;
		} else {
			bm.x -= speed;
		}

		var step = Random.int(0, 1);

		switch (step) {
			case 0:
				bm.y -= speed;
			case 1:
				bm.y += speed;
		}
	}
}

class HerdFlies {
	var flies:List<Fly> = new List<Fly>();

	public function new(image, speed, scene, x:Float, y:Float, n:Int, cls:Class<Dynamic>) {
		for (i in 0...n) {
			var fly = Type.createInstance(cls, [image, speed, scene, x, y]);
			flies.add(fly);
		}
	}

	public function update(dt:Float) {
		for (fly in flies) {
			fly.update(dt);
		}
	}
}
