#!/usr/bin/env python3
"""
Breeze ANSI vibrance demo for terminal output.

This script intentionally prints many full-bodied sections so the palette fills
the screen and showcases each Breeze-inspired text category in Python.
"""

from __future__ import annotations

from dataclasses import dataclass
from itertools import cycle
from shutil import get_terminal_size
from textwrap import wrap


RESET = "\033[0m"


@dataclass(frozen=True)
class Tone:
    name: str
    hex_code: str


PALETTE = {
    # semantic palette from README
    "action_label": Tone("action_label", "#3DAEE9"),
    "info_blue": Tone("info_blue", "#EBA0AC"),
    "command_name": Tone("command_name", "#CBA6F7"),
    "path": Tone("path", "#1ABC9C"),
    "string": Tone("string", "#CDD6F4"),
    "number": Tone("number", "#FAB387"),
    "text": Tone("text", "#CDD6F4"),
    "warning": Tone("warning", "#EBA0AC"),
    # core neutrals and accents from colorscheme
    "bg": Tone("bg", "#232627"),
    "mid_bg": Tone("mid_bg", "#2A2E2F"),
    "panel_bg": Tone("panel_bg", "#31363B"),
    "muted": Tone("muted", "#7F8C8D"),
    "comment": Tone("comment", "#9399B2"),
    "deep_teal": Tone("deep_teal", "#16A085"),
    "nontext": Tone("nontext", "#63686D"),
}

ANSI_0_15 = [
    "#232627",
    "#EBA0AC",
    "#CDD6F4",
    "#FAB387",
    "#3DAEE9",
    "#CBA6F7",
    "#1ABC9C",
    "#CDD6F4",
    "#7F8C8D",
    "#EBA0AC",
    "#CDD6F4",
    "#FAB387",
    "#EBA0AC",
    "#CBA6F7",
    "#16A085",
    "#CDD6F4",
]


def _hex_to_rgb(hex_code: str) -> tuple[int, int, int]:
    cleaned = hex_code.lstrip("#")
    return int(cleaned[0:2], 16), int(cleaned[2:4], 16), int(cleaned[4:6], 16)


def fg(hex_code: str) -> str:
    r, g, b = _hex_to_rgb(hex_code)
    return f"\033[38;2;{r};{g};{b}m"


def bg(hex_code: str) -> str:
    r, g, b = _hex_to_rgb(hex_code)
    return f"\033[48;2;{r};{g};{b}m"


def style(
    text: str,
    *,
    fg_hex: str | None = None,
    bg_hex: str | None = None,
    bold: bool = False,
    italic: bool = False,
    underline: bool = False,
    strike: bool = False,
    dim: bool = False,
) -> str:
    codes: list[str] = []
    if bold:
        codes.append("\033[1m")
    if dim:
        codes.append("\033[2m")
    if italic:
        codes.append("\033[3m")
    if underline:
        codes.append("\033[4m")
    if strike:
        codes.append("\033[9m")
    if fg_hex:
        codes.append(fg(fg_hex))
    if bg_hex:
        codes.append(bg(bg_hex))
    return "".join(codes) + text + RESET


class BreezeShowcase:
    def __init__(self) -> None:
        self.width = max(88, get_terminal_size((120, 40)).columns)
        self.hr = "=" * self.width

    def _line(self, text: str = "", fg_hex: str | None = None, bg_hex: str | None = None) -> None:
        payload = text[: self.width].ljust(self.width)
        print(style(payload, fg_hex=fg_hex, bg_hex=bg_hex))

    def _heading(self, title: str, subtitle: str) -> None:
        self._line(self.hr, fg_hex=PALETTE["muted"].hex_code, bg_hex=PALETTE["bg"].hex_code)
        banner = f"  {title}  "
        self._line(
            banner.center(self.width, " "),
            fg_hex=PALETTE["action_label"].hex_code,
            bg_hex=PALETTE["panel_bg"].hex_code,
        )
        self._line(
            subtitle.center(self.width, " "),
            fg_hex=PALETTE["comment"].hex_code,
            bg_hex=PALETTE["panel_bg"].hex_code,
        )
        self._line(self.hr, fg_hex=PALETTE["muted"].hex_code, bg_hex=PALETTE["bg"].hex_code)

    def intro(self) -> None:
        self._heading(
            "KONSOLE BREEZE ANSI - PYTHON VIBRANCE SHOWCASE",
            "Semantic palette, ANSI 0-15, syntax tones, diagnostics, diff, and styled prose",
        )
        self._line(
            "  Every section below is intentionally dense to flood the terminal with Breeze color language.",
            fg_hex=PALETTE["text"].hex_code,
            bg_hex=PALETTE["bg"].hex_code,
        )
        self._line(
            "  Use this script while tuning theme contrast, readability, and accent balance in live terminals.",
            fg_hex=PALETTE["text"].hex_code,
            bg_hex=PALETTE["bg"].hex_code,
        )
        self._line("", fg_hex=PALETTE["text"].hex_code, bg_hex=PALETTE["bg"].hex_code)

    def semantic_palette_section(self) -> None:
        self._heading("SEMANTIC PALETTE", "Primary Breeze identity tones")
        samples = [
            ("action_label", "deploy --region us-east --force"),
            ("info_blue", "refresh cache: stale entries reconciled in 018ms"),
            ("command_name", "breezectl render-palette --full-spectrum"),
            ("path", "/opt/breeze/themes/konsole/semantic/terminal.conf"),
            ("string", '"frosted mint string literal with high legibility"'),
            ("number", "314159  271828  161803  007  42"),
            ("text", "Core narrative body text for neutral long-form readability."),
            ("warning", "warning: saturation near threshold; inspect pink channel bleed"),
        ]
        for key, message in samples:
            tone = PALETTE[key]
            label = f"{tone.name:<13} {tone.hex_code:<9}"
            left = style(f"  {label}  ", fg_hex=tone.hex_code, bg_hex=PALETTE["mid_bg"].hex_code, bold=True)
            right = style(message, fg_hex=tone.hex_code, bg_hex=PALETTE["bg"].hex_code)
            print(left + " " + right)
        self._line("", fg_hex=PALETTE["text"].hex_code, bg_hex=PALETTE["bg"].hex_code)

    def ansi_strip_section(self) -> None:
        self._heading("ANSI 0-15", "Raw terminal palette entries exported by the Breeze scheme")
        chips: list[str] = []
        for idx, code in enumerate(ANSI_0_15):
            chip = style(f" {idx:>2}:{code.lower()} ", fg_hex=PALETTE["bg"].hex_code, bg_hex=code, bold=True)
            chips.append(chip)
        rows = [chips[i : i + 4] for i in range(0, len(chips), 4)]
        for row in rows:
            print("  " + " ".join(row))
        print()
        ramp = " ".join(style("##", bg_hex=c) for c in ANSI_0_15)
        print("  " + ramp)
        print()

    def syntax_theater_section(self) -> None:
        self._heading("SYNTAX THEATER", "Keyword, type, function, comment, string, number, operator, and punctuation")
        kw = PALETTE["action_label"].hex_code
        typ = PALETTE["command_name"].hex_code
        fun = PALETTE["command_name"].hex_code
        txt = PALETTE["text"].hex_code
        st = PALETTE["string"].hex_code
        num = PALETTE["number"].hex_code
        cmt = PALETTE["comment"].hex_code
        inf = PALETTE["info_blue"].hex_code

        mock_code = [
            f"{style('class', fg_hex=kw, bold=True)} {style('VibranceEngine', fg_hex=typ)}:",
            f"    {style('def', fg_hex=kw, bold=True)} {style('__init__', fg_hex=fun)}(self, {style('depth', fg_hex=txt)}={style('16', fg_hex=num)}):",
            f"        {style('# Initialize layered atmosphere', fg_hex=cmt, italic=True)}",
            f"        self.palette = {style('[', fg_hex=txt)}{style('\"breeze\"', fg_hex=st)}{style(',', fg_hex=txt)} {style('\"frost\"', fg_hex=st)}{style(']', fg_hex=txt)}",
            f"        self.intensity = {style('0.92', fg_hex=num)}",
            f"    {style('def', fg_hex=kw, bold=True)} {style('render', fg_hex=fun)}(self, {style('target', fg_hex=txt)}: {style('str', fg_hex=typ)}) -> {style('None', fg_hex=inf)}:",
            f"        {style('for', fg_hex=kw, bold=True)} layer {style('in', fg_hex=kw, bold=True)} range({style('8', fg_hex=num)}):",
            f"            print({style('f\"{target}: layer={layer:02d} glow={self.intensity}\"', fg_hex=st)})",
            f"        {style('if', fg_hex=kw, bold=True)} self.intensity {style('>=', fg_hex=txt)} {style('0.9', fg_hex=num)}:",
            f"            {style('return', fg_hex=kw, bold=True)} {style('None', fg_hex=inf)}",
        ]
        for line in mock_code:
            print("  " + line)
        print()

    def diagnostics_and_diff_section(self) -> None:
        self._heading("DIAGNOSTICS + DIFF", "Error, warning, info, hint, and patch contrast")
        rows = [
            ("ERROR", "#EBA0AC", "invalid token in blend profile at line 122"),
            ("WARN ", "#EBA0AC", "contrast ratio dropped below 4.5 in panel variant"),
            ("INFO ", "#EBA0AC", "semantic token pass completed for python and lua"),
            ("HINT ", "#16A085", "try reduced saturation for muted comments"),
        ]
        for sev, tone, msg in rows:
            sev_chip = style(f" {sev} ", fg_hex="#232627", bg_hex=tone, bold=True)
            body = style(msg, fg_hex=tone, bg_hex="#2A2E2F", italic=True)
            print("  " + sev_chip + " " + body)
        print()

        diff_lines = [
            ("+", "#CDD6F4", "set token.keyword = breeze_blue_bold"),
            ("~", "#FAB387", "refine virtual text background to #2A2E2F"),
            ("-", "#EBA0AC", "remove hardcoded fallback with poor readability"),
            (">", "#3DAEE9", "apply fresh accent map to command labels"),
        ]
        for marker, tone, text in diff_lines:
            badge = style(f" {marker} ", fg_hex="#232627", bg_hex=tone, bold=True)
            print("  " + badge + " " + style(text, fg_hex=tone))
        print()

    def prose_wall_section(self) -> None:
        self._heading("PROSE WALL", "A long mixed-style body to saturate the viewport")
        paragraphs = [
            (
                "Breeze palettes succeed when accents guide the eye without exhausting it, "
                "so this wall blends calm foreground text, mint strings, peach numbers, "
                "teal paths, and blue keywords into one sustained reading surface."
            ),
            (
                "The objective is not random color noise but rhythmic contrast: bright labels "
                "for navigation, lavender identifiers for symbol identity, and restrained neutrals "
                "for everything that should stay quietly legible under prolonged focus."
            ),
            (
                "Watch how comment tones recede while diagnostics step forward, how headings carry "
                "authority through bold cyan, and how underlines and italics can be introduced sparingly "
                "to signal intent without turning the terminal into visual static."
            ),
        ]

        cycle_colors = cycle(
            [
                PALETTE["text"].hex_code,
                PALETTE["string"].hex_code,
                PALETTE["number"].hex_code,
                PALETTE["path"].hex_code,
                PALETTE["command_name"].hex_code,
                PALETTE["info_blue"].hex_code,
                PALETTE["warning"].hex_code,
                PALETTE["comment"].hex_code,
            ]
        )

        for para in paragraphs:
            wrapped = wrap(para, width=self.width - 4)
            for line in wrapped:
                color = next(cycle_colors)
                self._line("  " + line, fg_hex=color, bg_hex=PALETTE["bg"].hex_code)
            self._line("", fg_hex=PALETTE["text"].hex_code, bg_hex=PALETTE["bg"].hex_code)

    def style_gallery_section(self) -> None:
        self._heading("STYLE GALLERY", "Bold, italic, underline, dim, and strike modifiers on Breeze tones")
        gallery = [
            ("bold action label", dict(fg_hex=PALETTE["action_label"].hex_code, bold=True)),
            ("italic comment drift", dict(fg_hex=PALETTE["comment"].hex_code, italic=True)),
            ("underlined info route", dict(fg_hex=PALETTE["info_blue"].hex_code, underline=True)),
            ("dim neutral body", dict(fg_hex=PALETTE["text"].hex_code, dim=True)),
            ("struck deprecated token", dict(fg_hex=PALETTE["warning"].hex_code, strike=True)),
            (
                "stacked style composite",
                dict(
                    fg_hex=PALETTE["command_name"].hex_code,
                    bg_hex=PALETTE["mid_bg"].hex_code,
                    bold=True,
                    italic=True,
                    underline=True,
                ),
            ),
        ]
        for label, kwargs in gallery:
            msg = f"  {label:<28} | visual treatment sample in Breeze context"
            print(style(msg, **kwargs))
        print()

    def outro(self) -> None:
        self._line(self.hr, fg_hex=PALETTE["muted"].hex_code, bg_hex=PALETTE["bg"].hex_code)
        self._line(
            "  End of Breeze vibrance pass. Re-run after terminal/font changes for consistent calibration.",
            fg_hex=PALETTE["text"].hex_code,
            bg_hex=PALETTE["panel_bg"].hex_code,
        )
        self._line(self.hr, fg_hex=PALETTE["muted"].hex_code, bg_hex=PALETTE["bg"].hex_code)
        print(RESET, end="")

    def run(self) -> None:
        self.intro()
        self.semantic_palette_section()
        self.ansi_strip_section()
        self.syntax_theater_section()
        self.diagnostics_and_diff_section()
        self.prose_wall_section()
        self.style_gallery_section()
        self.outro()


def main() -> None:
    BreezeShowcase().run()


if __name__ == "__main__":
    main()
