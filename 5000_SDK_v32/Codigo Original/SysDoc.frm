[Forma]
Clave=SysDoc
Nombre=Documentación
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=199
PosicionInicialArriba=315
PosicionInicialAltura=393
PosicionInicialAncho=881
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=40
PosicionInicialAlturaCliente=370
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista.Columnas]
ID=64
Objeto=52
Modulo=45
SysTabla=95
Referencia=175
Descripcion=191
UltimoCambio=94
Nombre=123

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=SysDoc
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Ficha.SysDoc.Modulo]
Carpeta=Ficha
Clave=SysDoc.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.SysDoc.SysTabla]
Carpeta=Ficha
Clave=SysDoc.SysTabla
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.SysDoc.Objeto]
Carpeta=Ficha
Clave=SysDoc.Objeto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.SysDoc.Descripcion]
Carpeta=Ficha
Clave=SysDoc.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=72x15
ColorFondo=Blanco
ColorFuente=Negro
ConScroll=S

[Ficha.SysDoc.UltimoCambio]
Carpeta=Ficha
Clave=SysDoc.UltimoCambio
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.SysDoc.Nombre]
Carpeta=Ficha
Clave=SysDoc.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SysDoc
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S

[Lista.SysDoc.Objeto]
Carpeta=Lista
Clave=SysDoc.Objeto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SysDoc.Modulo]
Carpeta=Lista
Clave=SysDoc.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SysDoc.SysTabla]
Carpeta=Lista
Clave=SysDoc.SysTabla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SysDoc.Nombre]
Carpeta=Lista
Clave=SysDoc.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=SysDoc.Objeto
SysDoc.Objeto=SysDoc.Nombre
SysDoc.Nombre=SysDoc.UltimoCambio
SysDoc.UltimoCambio=SysDoc.Modulo
SysDoc.Modulo=SysDoc.SysTabla
SysDoc.SysTabla=SysDoc.Descripcion
SysDoc.Descripcion=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SysDoc.Objeto
SysDoc.Objeto=SysDoc.Modulo
SysDoc.Modulo=SysDoc.SysTabla
SysDoc.SysTabla=SysDoc.Nombre
SysDoc.Nombre=(Fin)
