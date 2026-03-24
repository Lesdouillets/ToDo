#!/usr/bin/env bash
# Launch the ToDo app on a local HTTP server

PORT="${PORT:-8080}"

echo "Starting ToDo app at http://localhost:$PORT/todos.html"
echo "Press Ctrl+C to stop."

# Try to open the browser automatically
if command -v xdg-open &>/dev/null; then
  (sleep 1 && xdg-open "http://localhost:$PORT/todos.html") &
elif command -v open &>/dev/null; then
  (sleep 1 && open "http://localhost:$PORT/todos.html") &
fi

python3 -m http.server "$PORT"
