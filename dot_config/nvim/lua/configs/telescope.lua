return {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "-i", -- case-insensitive
    },
    case_sensitive = false,
  },
  pickers = {
    live_grep = { case_sensitive = false },
    grep_string = { case_sensitive = false },
    find_files = {
      find_command = { "fd", "--type", "f", "--ignore-case" },
    },
  },
}
