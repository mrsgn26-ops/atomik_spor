import base64
import pathlib

from PIL import Image, ImageFilter

B64_PATH = pathlib.Path("web/assets/splash@2x.png.b64")
PNG_PATH = pathlib.Path("web/assets/splash@2x.png")


def decode_base_image() -> Image.Image:
    b64 = B64_PATH.read_text()
    PNG_PATH.parent.mkdir(parents=True, exist_ok=True)
    PNG_PATH.write_bytes(base64.b64decode(b64))
    return Image.open(PNG_PATH).convert("RGBA")


def emit_variant(source: Image.Image, width: int, stem: str) -> None:
    height = round(source.height * width / source.width)
    resized = source.resize((width, height), Image.LANCZOS)
    sharpened = resized.filter(ImageFilter.UnsharpMask(radius=1.0, percent=80, threshold=3))
    target = pathlib.Path(f"web/assets/{stem}.webp")
    target.parent.mkdir(parents=True, exist_ok=True)
    sharpened.save(target, format="WEBP", quality=82, method=6)


def main() -> None:
    image = decode_base_image()
    emit_variant(image, 768, "splash-768")
    emit_variant(image, 1536, "splash-1536")
    print("assets ready")


if __name__ == "__main__":
    main()
