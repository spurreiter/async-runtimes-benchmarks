# results

## Hardware Apple M3

- macOS 15, Apple M3

## Versions

- dotnet: 9.0.100
- elixir: 1.17.3
- go: 1.23.3
- java: 23.0.1
- nodejs: 22.11.0
- python: 3.13.0
- rust: 1.83.0

## Results

Lower values are better.

| Implementation | 10k | 100k |    1M |
| -------------- | --: | ---: | ----: |
| dotnet         | 22M |  38M |  190M |
| elixir         | 95M | 446M | 3854M |
| go             | 29M | 261M | 2571M |
| java           | 93M | 170M | 1001M |
| nodejs         | 26M | 107M |  666M |
| bun            | 22M |  99M |  830M |
| deno           | 35M | 132M |  891M |
| python         | 27M | 139M | 1258M |
| rust_async_std |  8M |  53M |  501M |
| rust_futures   |  4M |  20M |  190M |
| rust_tokio     |  5M |  31M |  328M |
