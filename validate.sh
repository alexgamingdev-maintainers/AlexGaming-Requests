name: Alex Gaming Gatekeeper

on:
  pull_request:
    branches: [ main ]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Make Script Executable
        run: chmod +x validate.sh

      - name: Run Alex Gaming Validator
        run: ./validate.sh
