#! /usr/bin/env python3

import json

from rich import box
from rich.console import Console
from rich.table import Column, Table

with open('./cernjobs.json') as jobsfile:
    job_list = json.load(jobsfile)


console = Console()

table = Table(show_header=True, box=box.SIMPLE_HEAD, pad_edge=False)
# row_styles=["none", "dim"])

table.add_column("#️⃣ Code", header_style="bold blue", style="blue")
table.add_column("⌛ Date", header_style="bold green", style="green", width=10)
table.add_column("💻 Job title", header_style="bold red", style="red",
                 no_wrap=True, overflow="ellipsis", max_width=80)
table.add_column("🌎 Url", header_style="bold cyan", style="cyan")

for job in job_list:
    job_code = "[bold yellow]IT[/bold yellow]" if "IT" in job["code"] else job["code"]

    table.add_row(job_code, job["date"], job["name"], job["url"])

console.print(table)
