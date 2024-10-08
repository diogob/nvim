This nvim configuration does not use any plugin manager. I took some code and ideas from [https://github.com/echasnovski/nvim](https://github.com/echasnovski/nvim)

## Adding plugins

```sh
./add-plugin.sh https://github.com/<plugin-path> <plugin-name-no-extension>
```

Then edit [lua/plugins.lua](./lua/plugins.lua) and add the code to load:

```lua
packadd_defer('<plugin-name-no-extension>')
vim.schedule(function()
  <setup code from plugin docs>
end)
```

If the deferred loading does not work try using `packadd` instead of `packadd_defer`.

## Updating plugins 

```sh
./update-plugins.sh
```

## Removing plugins

```sh
git submodule deinit pack/plugins/<path-to-plugin>
```
