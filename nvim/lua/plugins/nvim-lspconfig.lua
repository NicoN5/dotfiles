return {
  "neovim/nvim-lspconfig",
  opts = {
    -- ■ サーバー設定
    servers = {
      tailwindcss = {
        -- exclude a filetype from the default_config
        filetypes_exclude = { "markdown" },
        -- add additional filetypes to the default_config
        filetypes_include = {},
        -- to fully override the default_config, change the below
        -- filetypes = {}

        -- additional settings for the server, e.g:
        -- tailwindCSS = { includeLanguages = { someLang = "html" } }
        -- can be addeded to the settings table and will be merged with
        -- this defaults for Phoenix projects
        settings = {
          tailwindCSS = {
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
            },
          },
        },
      },
      svelte = {
        keys = {
          {
            "<leader>co",
            LazyVim.lsp.action["source.organizeImports"],
            desc = "Organize Imports",
          },
        },
      },
      -- TypeScript / JS
      tsserver = { enabled = false },
      ts_ls = { enabled = false },
      vtsls = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              maxInlayHintLength = 30,
              completion = { enableServerSideFuzzyMatch = true },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = { completeFunctionCalls = true },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
        keys = {
          {
            "gD",
            function()
              local win = vim.api.nvim_get_current_win()
              local params = vim.lsp.util.make_position_params(win, "utf-16")
              LazyVim.lsp.execute({
                command = "typescript.goToSourceDefinition",
                arguments = { params.textDocument.uri, params.position },
                open = true,
              })
            end,
            desc = "Goto Source Definition",
          },
          {
            "gR",
            function()
              LazyVim.lsp.execute({
                command = "typescript.findAllFileReferences",
                arguments = { vim.uri_from_bufnr(0) },
                open = true,
              })
            end,
            desc = "File References",
          },
          { "<leader>co", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
          { "<leader>cM", LazyVim.lsp.action["source.addMissingImports.ts"], desc = "Add missing imports" },
          { "<leader>cu", LazyVim.lsp.action["source.removeUnused.ts"], desc = "Remove unused imports" },
          { "<leader>cD", LazyVim.lsp.action["source.fixAll.ts"], desc = "Fix all diagnostics" },
          {
            "<leader>cV",
            function()
              LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
            end,
            desc = "Select TS workspace version",
          },
        },
      },

      -- Python
      pyright = {},
      ruff = {
        cmd_env = { RUFF_TRACE = "messages" },
        init_options = { settings = { logLevel = "error" } },
        keys = {
          { "<leader>co", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
        },
      },
      ruff_lsp = {
        keys = {
          { "<leader>co", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
        },
      },
    },

    -- ■ サーバーセットアップ
    setup = {
      tailwindcss = function(_, opts)
        opts.filetypes = opts.filetypes or {}

        -- Add default filetypes
        vim.list_extend(opts.filetypes, vim.lsp.config.tailwindcss.filetypes)

        -- Remove excluded filetypes
        --- @param ft string
        opts.filetypes = vim.tbl_filter(function(ft)
          return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
        end, opts.filetypes)

        -- Add additional filetypes
        vim.list_extend(opts.filetypes, opts.filetypes_include or {})
      end,
      -- TypeScript / JS
      tsserver = function()
        return true
      end,
      ts_ls = function()
        return true
      end,
      vtsls = function(_, opts)
        if vim.lsp.config.denols and vim.lsp.config.vtsls then
          local resolve = function(server)
            local markers, root_dir = vim.lsp.config[server].root_markers, vim.lsp.config[server].root_dir
            vim.lsp.config(server, {
              root_dir = function(bufnr, on_dir)
                local is_deno = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) ~= nil
                if is_deno == (server == "denols") then
                  if root_dir then
                    return root_dir(bufnr, on_dir)
                  elseif type(markers) == "table" then
                    local root = vim.fs.root(bufnr, markers)
                    return root and on_dir(root)
                  end
                end
              end,
            })
          end
          resolve("denols")
          resolve("vtsls")
        end

        Snacks.util.lsp.on({ name = "vtsls" }, function(buffer, client)
          client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
            local action, uri, range = unpack(command.arguments)
            local function move(newf)
              client:request("workspace/executeCommand", {
                command = command.command,
                arguments = { action, uri, range, newf },
              })
            end
            local fname = vim.uri_to_fname(uri)
            client:request("workspace/executeCommand", {
              command = "typescript.tsserverRequest",
              arguments = {
                "getMoveToRefactoringFileSuggestions",
                {
                  file = fname,
                  startLine = range.start.line + 1,
                  startOffset = range.start.character + 1,
                  endLine = range["end"].line + 1,
                  endOffset = range["end"].character + 1,
                },
              },
            }, function(_, result)
              local files = result.body.files
              table.insert(files, 1, "Enter new path...")
              vim.ui.select(files, {
                prompt = "Select move destination:",
                format_item = function(f)
                  return vim.fn.fnamemodify(f, ":~:.")
                end,
              }, function(f)
                if f and f:find("^Enter new path") then
                  vim.ui.input({
                    prompt = "Enter move destination:",
                    default = vim.fn.fnamemodify(fname, ":h") .. "/",
                    completion = "file",
                  }, function(newf)
                    return newf and move(newf)
                  end)
                elseif f then
                  move(f)
                end
              end)
            end)
          end
        end)
        -- Copy TypeScript settings to JavaScript
        opts.settings.javascript =
          vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
      end,

      -- Python: ruff hover無効化
      ruff = function()
        Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
          client.server_capabilities.hoverProvider = false
        end)
      end,
      ruff_lsp = function()
        Snacks.util.lsp.on({ name = "ruff_lsp" }, function(_, client)
          client.server_capabilities.hoverProvider = false
        end)
      end,
    },
  },
}
