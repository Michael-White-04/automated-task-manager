
#!/bin/bash
set -euo pipefail

python3 - "$1" "$2" <<'PY'
import sys
import re
import html
from pathlib import Path

tasks = Path(sys.argv[1]).read_text()
tests = Path(sys.argv[2]).read_text()

pending, completed = tasks.split("Done Tasks:", 1)

pending = pending.replace("ToDo Tasks:", "", 1).strip()
completed = completed.strip()

index = Path("index.html")
content = index.read_text()

sections = {
    "pending": pending,
    "completed": completed,
    "unittest": tests.strip(),
}

for section, value in sections.items():
    pattern = rf'<pre id="{section}">.*?</pre>'

    replacement = (
        f'<pre id="{section}">'
        f'{html.escape(value)}</pre>'
    )

    content = re.sub(
        pattern,
        lambda _: replacement,
        content,
        flags=re.DOTALL
    )

index.write_text(content)

print("HTML report updated successfully.")
PY
