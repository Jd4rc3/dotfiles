" -----------------------------
" CONFIGURACIONES BÁSICAS
" -----------------------------

" Usa UTF-8
set encoding=utf-8
set fileencoding=utf-8

" Número de línea absoluto + relativo
set number
set relativenumber

" Usa el portapapeles del sistema si está disponible
set clipboard=unnamedplus

" Habilita el mouse
"set mouse=a

" Indentación automática y uso de espacios
set tabstop=4       " Tamaño de tabulador
set shiftwidth=4    " Nivel de indentación
set expandtab       " Usa espacios en vez de tabs
set smartindent     " Indentación inteligente

" Deshabilita los sonidos (campanas)
set noerrorbells
set visualbell
set t_vb=

" Muestra línea de estado siempre
set laststatus=2

" Activa búsqueda incremental e ignora mayúsculas a menos que haya una
set incsearch
set ignorecase
set smartcase
set hlsearch         " Resalta coincidencias

" Muestra coincidencias mientras escribes
set showmatch
set matchtime=2

" Muestra comandos en la parte inferior
set showcmd

" Guarda el historial de comandos
set history=1000

" Evita archivos de backup y swap
set nobackup
set nowritebackup
set noswapfile

" Mantén el cursor centrado
set scrolloff=8
set sidescrolloff=8

" Tiempo de espera más corto
set timeoutlen=500
set updatetime=300

" Desactiva modo compatible (modo de compatibilidad con vi)
set nocompatible

" Mejores colores si están disponibles
syntax on
set termguicolors

" Evita que se corte la línea
set nowrap

" Línea de columna guía opcional
set colorcolumn=80

" Cursorline (línea donde está el cursor resaltada)
set cursorline

" Completar con tabulación
set wildmenu
set wildmode=longest:full,full

" -----------------------------
" MAPEOS ÚTILES
" -----------------------------

" Usa espacio como tecla líder
let mapleader=" "

" Quitar el resaltado de búsqueda con <leader><space>
nnoremap <leader><space> :nohlsearch<CR>

" Guarda rápido con Ctrl-s
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Salida rápida con Ctrl-q
nnoremap <C-q> :q<CR>

" Navegar entre ventanas con Ctrl-h/j/k/l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Abre el explorador de archivos nativo
nnoremap <leader>e :Explore<CR>

" Ajusta texto con 'gq' sobre selección visual o línea actual
vnoremap Q gq

" Mueve líneas visualmente
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Usa wl-copy para integración con clipboard
if executable("wl-copy")
  let g:clipboard = {
        \   'name': 'wl-clipboard',
        \   'copy': {
        \      '+': ['wl-copy', '--foreground', '--type', 'text/plain'],
        \      '*': ['wl-copy', '--foreground', '--type', 'text/plain'],
        \    },
        \   'paste': {
        \      '+': ['wl-paste', '--no-newline'],
        \      '*': ['wl-paste', '--no-newline'],
        \   },
        \   'cache_enabled': 1,
        \ }
endif

" En modo visual, copia al clipboard con <leader>y
vnoremap <leader>y "+y

" En modo normal, copia una línea al clipboard con <leader>y
nnoremap <leader>y "+yy

colorscheme elflord
