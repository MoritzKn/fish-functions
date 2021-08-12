# Fish Functions

The [fish shell](https://fishshell.com/) is genuinely awesome, every single person I told about fish switched and was enthusiastic about it after the first day!

This repo contains functions and aliases I created for myself over the years.

## How to use

Copy the functions you would like to use to `~/.config/fish/functions/` or clone the repo
inside this directory.

## Config

You may also put this into you `~/.config/fish/config.fish`:

```fish
abbr "!" " do"

abbr "-" "prevd"
abbr "+" "nextd"

abbr "..." cd ../..
abbr "...." cd ../../..
abbr "....." cd ../../../..
```

## License

This project is licensed under the terms of the MIT license.
A copy of the license can be found in the root directory of
the project in the file [LICENSE](./LICENSE).
