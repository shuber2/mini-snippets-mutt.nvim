Provides code snippets generated from [mutt](http://www.mutt.org/) or
[neomutt](https://neomutt.org/) configurations for the snippet engine
[mini.snippets](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-snippets.md)
of the great [mini.nvim](https://github.com/echasnovski/mini.nvim) library for
[Neovim](https://github.com/neovim/neovim).


Two types of snippets are supported:

* **Signature snippets** for [email
  signatures](https://en.wikipedia.org/wiki/Signature_block) with the [standard
  delimiter](https://en.wikipedia.org/wiki/Signature_block#Standard_delimiter).

* **From-address snippets** for the [from
  header](https://en.wikipedia.org/wiki/Email#Header_fields).


Only the from-address signatures are depending on muttrc syntax, but the
signature-snippets are actually independent of mutt and could also be used by
non-mutt users.


## Quickstart

The follow code installed this package by means of
[mini.deps](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-deps.md).


```lua
local add = MiniDeps.add
add({ source = 'shuber2/mini-snippets-mutt.nvim' })
require("mini-snippets-mutt").setup()
```

And this is the default configuration:
```lua
require("mini-snippets-mutt").setup({
  -- List of signature files
  signature_files = {
      os.getenv("HOME") .. "/.*mutt/signatures/*",
  },
  -- The standard delimitor as signature prefix
  signature_prefix = "-- \n",
  -- List of muttrc files to parse
  muttrc_files = {
    os.getenv("HOME") .. "/.*muttrc",
    os.getenv("HOME") .. "/.*mutt/*muttrc",
  },
})
```


## Details

The implementation uses the `mini.snippets` feature of Lua-based snippets, so
this is quite tied to this snippet engine. It works as follows:

* For each `${signaturefile}`, a signature snippet is created based on the
  filename containing the signature content. The extension of the file is
  stripped. For the default configuration, `~/.mutt/signatures/private.eml`
  creates a snippet `sig-private` that populates to the content of this file.

* Each `${muttrcfile}` is parsed and for each line of the form `set from
  "${ADDRESS}"` a snippet is created based on the domain of the mail address.
  In the default configuration, `set from John Smith <jsmith@example.org>` in
  `~/.mutt/foo.muttrc` creates a snippet `from-example.org` that populates to
  `John Smith <jsmith@example.org>`.


## Related plugins

- [vim-mail](https://gitlab.com/dbeniamine/vim-mail) - A plugin for composing
  emails in Vim
