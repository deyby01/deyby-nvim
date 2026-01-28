## Configuración actual e instalacion de mi nvim o neovim

### Verificar que tienes git, y si no instalarlo.
```bash
git --version

# Si no se instala con sudo
sudo apt install git
```

## Actualizar el sistema.
```bash
sudo apt update
sudo apt upgrade -y
```

## Instalar ultima version de neovim
```bash
sudo apt install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim 
```

**Verificar instalacion viendo la version**
```bash
nvim --version
```

## Instalar ripgrep (para busqueda de contenido)
```bash
sudo apt install ripgrep

# Verificamos version
rg --version
```

## Instalar fd (para busqueda de archivos)
```bash
sudo apt install fd-find

# Creamos un alias para que funcione
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd

# Despues verificamos la version.
fd --version
```

## Instalar lazydocker para el panel de docker.
```bash
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
```

### (Opcional) Instalar ctags
```bash
sudo apt install universal-ctags
```

## Instalamos las fuentes para los iconos y folders
```bash
# Crear carpeta para fuentes si no existe
mkdir -p ~/.local/share/fonts

# Descargar JetBrainsMono Nerd Font (recomendada)
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip

# Descomprimir
unzip JetBrainsMono.zip -d JetBrainsMono
rm JetBrainsMono.zip

# Actualizar caché de fuentes
fc-cache -fv
```
### Para activarlas
* Abrimos una terminal nueva 
* Vamos a Preferencias
* Entramos en perfiles
* Si ya existe un perfil solo lo editamos sino creamos uno con +
* Marcamos fuente personalizada o custom font 
* Elegimos JetBrainsMono Nerd Font 
* Tamaño 12 esta bien(opcional aumentarle)

### Verificar que funciona
**Si quieres verificar ejecuta el siguiente comando, deberias ver iconos en vez de texto o cuadros.**
```bash
echo -e "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"
```

## Alternativas de fuentes:
```bash
# FiraCode Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip

# Hack Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip

# CascadiaCode Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaCode.zip
```

## Crear estructura de Configuración
**Si no existe la carpeta la creamos**
```bash
mkdir -p ~/.config/nvim 

# Verificamos que se creamos
ls -la ~/.config/nvim/ 

# Ingresamos
cd ~/.config/nvim 
```

## Creamos el archivo de configuracion dentro de la carpeta
```bash
# Crear archivo de conf.
touch init.lua

# Verificamos que se creó
ls -la init.lua 
```

### Ingresamos al archivo con `nvim`
```bash
# Si estamos dentro de la carpeta nvim/
nvim init.lua

# sino usar
nvim ~/.config/nvim/init.lua
```

### Para empezar a escribir presionamos la tecla `i`
* Pegamos el contenido que esta en este repo en el archivo `init.lua` o mas facil cortarlo y pegarlo dentro de nvim/
* Presionamos `esc`para salir del modo editar.
* Guardamos y salimos escribiendo `:wq` y luego presionamos enter.
* Volvemos a ingresar a init.lua
* Deberia empezar un proceso de descarga, esperar a que termine...
* Por ultimo ya estaria toda la config agregada y lista para su uso.
