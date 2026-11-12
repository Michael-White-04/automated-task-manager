
#!/bin/bash
set -euo pipefail

echo "Executing task manager..."

python3 /app/scripts/todo.py \
    | tee /tmp/todo_output.txt

echo "Executing unit tests..."

python3 /app/scripts/todo-test.py 2>&1 \
    | tee /tmp/test_output.txt

echo "Updating HTML report..."

bash /app/scripts/update_index.sh \
    /tmp/todo_output.txt \
    /tmp/test_output.txt

echo "Pipeline completed successfully."
