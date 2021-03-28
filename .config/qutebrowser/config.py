config.load_autoconfig()
# User Config
# Start pages and search engines
c.url.start_pages = ["https://www.google.com/"]
c.url.searchengines = {'DEFAULT': 'https://www.google.com/search?hl=en&q={}','aw': 'https://wiki.archlinux.org/?search={}', 'yt': 'https://youtube.com/results?search_query={}', 'w': 'https://en.wikipedia.org/?search={}','so': 'https://stackoverflow.com/?search={}', 'au': 'https://askubuntu.com/?search={}'}

# HINTS
c.hints.chars = 'asdfghjklweroiumvcp'
c.hints.uppercase = True
c.keyhint.delay = 0

# Tabs related
c.tabs.new_position.unrelated = "next"
c.tabs.background = True
config.bind('L', 'tab-next', mode='normal')
config.bind('H', 'tab-prev', mode='normal')
config.bind('J', 'back', mode='normal')
config.bind('K', 'forward', mode='normal')

# Settings
c.confirm_quit = ["always"]
# c.content.developer_extras = True
c.scrolling.smooth = True
c.content.user_stylesheets = "/home/sols/Source/darculized-everything-css/css/darculized/darculized-all-sites.css"

# Fonts
# c.fonts.monospace = "monospace"
c.fonts.completion.entry = "FiraCode Nerd Font Mono"
c.fonts.completion.category = "FiraCode Nerd Font Mono"
c.fonts.debug_console = "FiraCode Nerd Font Mono"
c.fonts.downloads = "FiraCode Nerd Font Mono"
c.fonts.hints = "FiraCode Nerd Font Mono"
c.fonts.keyhint = "FiraCode Nerd Font Mono"
c.fonts.messages.error = "FiraCode Nerd Font Mono"
c.fonts.messages.info = "FiraCode Nerd Font Mono"
c.fonts.messages.warning = "FiraCode Nerd Font Mono"
c.fonts.prompts = "FiraCode Nerd Font Mono"
c.fonts.statusbar = "FiraCode Nerd Font Mono"
# c.fonts.tabs = "monospace"

c.fonts.web.family.cursive = "Misc Tamsyn"
c.fonts.web.family.fantasy = "Misc Tamsyn"
c.fonts.web.family.fixed = "Misc Tamsyn"
c.fonts.web.family.sans_serif = "Misc Tamsyn"
c.fonts.web.family.serif = "Misc Tamsyn"
c.fonts.web.family.standard = "Misc Tamsyn"
