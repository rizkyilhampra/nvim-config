local M = {}
local lspconfig = require("lspconfig")

M.filetypes = {
	"aspnetcorerazor",
	"astro",
	"astro-markdown",
	"blade",
	"clojure",
	"django-html",
	"htmldjango",
	"edge",
	"eelixir",
	"elixir",
	"ejs",
	"erb",
	"eruby",
	"gohtml",
	"gohtmltmpl",
	"haml",
	"handlebars",
	"hbs",
	"html",
	"htmlangular",
	"html-eex",
	"heex",
	"jade",
	"leaf",
	"liquid",
	"markdown",
	"mdx",
	"mustache",
	"njk",
	"nunjucks",
	"razor",
	"slim",
	"twig",
	"css",
	"less",
	"postcss",
	"sass",
	"scss",
	"stylus",
	"sugarss",
	"javascript",
	"javascriptreact",
	"reason",
	"rescript",
	"typescript",
	"typescriptreact",
	"vue",
	"svelte",
	"templ",
}

M.root_dir = function(fname)
	return lspconfig.util.root_pattern("tailwind.config.js")(fname)
end

return M