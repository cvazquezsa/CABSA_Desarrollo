[Forma]
Clave=ArtCosto
Nombre=Costos del Artículo
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=337
PosicionInicialArriba=281
PosicionInicialAltura=195
PosicionInicialAncho=350
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
Comentarios=Info.Articulo
VentanaExclusiva=S
PosicionInicialAlturaCliente=172

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtConCosto
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
CondicionEdicion=no General.PC
FiltroGeneral=Art.Articulo=<T>{Info.Articulo}<T>

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Ficha.Art.CostoEstandar]
Carpeta=Ficha
Clave=Art.CostoEstandar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Art.CostoReposicion]
Carpeta=Ficha
Clave=Art.CostoReposicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ArtCostoEmpresa.CostoPromedio]
Carpeta=Ficha
Clave=ArtCostoEmpresa.CostoPromedio
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.ArtCostoEmpresa.UltimoCosto]
Carpeta=Ficha
Clave=ArtCostoEmpresa.UltimoCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.ArtCostoEmpresa.UltimoCostoSinGastos]
Carpeta=Ficha
Clave=ArtCostoEmpresa.UltimoCostoSinGastos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.NivelSucursal]
Nombre=NivelSucursal
Boton=47
NombreEnBoton=S
NombreDesplegar=Nivel &Sucursal
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtCostoSucursal
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=NivelSucursal
NivelSucursal=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Art.CostoEstandar
Art.CostoEstandar=Art.CostoReposicion
Art.CostoReposicion=ArtCostoEmpresa.CostoPromedio
ArtCostoEmpresa.CostoPromedio=ArtCostoEmpresa.UltimoCosto
ArtCostoEmpresa.UltimoCosto=ArtCostoEmpresa.UltimoCostoSinGastos
ArtCostoEmpresa.UltimoCostoSinGastos=(Fin)
