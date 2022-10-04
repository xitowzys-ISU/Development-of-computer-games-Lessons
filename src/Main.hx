import Fly.RandomFly;
import hxd.res.DefaultFont;
import h2d.Bitmap;
import hxd.Window;
import h2d.Console;
import Fly.HerdFlies;
import Fly.PurposefulFly;
import Noise;

class Main extends hxd.App {
	var fpsLabel:h2d.Text;
	var fly:PurposefulFly;
	var console:Console;

	var herdFlies:HerdFlies;
	var perlin_noise:Noise;

	override function init() {
		hxd.Res.initEmbed();
		engine.backgroundColor = 0x8CE6FF;

		var image = hxd.Res.background.toTile();
		var bg:h2d.Bitmap = new h2d.Bitmap(image, s2d);
		var width = Std.int(image.width);
		var height = Std.int(image.height);

		Window.getInstance().resize(width, height);

		var image = hxd.Res.mosquito_small.toTile();
		// fly = new PurposefulFly(hxd.Res.mosquito_small.toTile(), 0.5, s2d, width / 2, height / 2);

		herdFlies = new HerdFlies(hxd.Res.mosquito_small.toTile(), 5, s2d, width / 2, height / 2, 10000, RandomFly);
		perlin_noise = new Noise();

		fpsLabel = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
		fpsLabel.textColor = 0xff0000;
		fpsLabel.setScale(2);

		console = new Console(DefaultFont.get(), s2d);
		console.addCommand("whereisfly", "", [], function() console.log(Std.string(perlin_noise.perlin(3.14, 42, 7))));
	}

	override function update(dt:Float) {
		fpsLabel.text = 'FPS = ${Math.round(1 / dt)}';
		herdFlies.update(dt);
		trace(fly);
		// fly.x += 1;
		// fly.y += 1;
	}

	static function main() {
		new Main();
	}
}
