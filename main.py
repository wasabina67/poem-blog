import os
import sys
from pathlib import Path

from openai import OpenAI


def append_audio_tag_to_markdown(markdown_file_path: str, filename_without_ext: str):
    with open(markdown_file_path, "r", encoding="utf-8") as f:
        content = f.read()

    audio_tag = f'<audio controls><source src="/poem-blog/audio/{filename_without_ext}.mp3" type="audio/mpeg">Your browser does not support the audio element.</audio>'  # noqa
    if audio_tag in content:
        return

    if not content.endswith("\n"):
        content += "\n"
    content += f"\n{audio_tag}\n"

    with open(markdown_file_path, "w", encoding="utf-8") as f:
        f.write(content)


def tts(model: str, voice: str, text: str, output_file: str):
    client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))
    response = client.audio.speech.create(
        model=model,
        voice=voice,
        input=text,
    )

    output_path = Path(output_file)
    with open(output_path, "wb") as f:
        f.write(response.content)


def read_markdown_from_line9(markdown_file_path: str) -> str:
    with open(markdown_file_path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    if len(lines) >= 9:
        return "".join(lines[8:])
    else:
        return ""


def main():
    if len(sys.argv) < 2:
        print("Usage: uv run python main.py <markdown_file_path>")
        sys.exit(1)

    markdown_file_path = sys.argv[1]

    if not os.path.exists(markdown_file_path):
        print(f"Error: File '{markdown_file_path}' not found")
        sys.exit(1)

    text = read_markdown_from_line9(markdown_file_path)
    if text == "":
        print(f"Error: No text found from line 9 onwards in file: {markdown_file_path}")
        sys.exit(1)

    filename_without_ext = Path(markdown_file_path).stem
    output_file = f"static/audio/{filename_without_ext}.mp3"
    tts("tts-1", "alloy", text, output_file)
    append_audio_tag_to_markdown(markdown_file_path, filename_without_ext)


if __name__ == "__main__":
    main()
