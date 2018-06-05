[Forma]
Clave=ProvCredito
Nombre=Línea de Crédito
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Proveedor
PosicionInicialIzquierda=349
PosicionInicialArriba=256
PosicionInicialAltura=143
PosicionInicialAncho=286
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
VentanaExclusiva=S
VentanaEscCerrar=
PosicionInicialAlturaCliente=221

[Ficha]
Estilo=Hoja
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProvCredito
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=ProvCredito.Proveedor = <T>{Info.Proveedor}<T>

[Ficha.ProvCredito.Empresa]
Carpeta=Ficha
Clave=ProvCredito.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProvCredito.LineaCredito]
Carpeta=Ficha
Clave=ProvCredito.LineaCredito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

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

[Ficha.ProvCredito.Moneda]
Carpeta=Ficha
Clave=ProvCredito.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Columnas]
Empresa=53
LineaCredito=138
Moneda=64

[Ficha.ListaEnCaptura]
(Inicio)=ProvCredito.Empresa
ProvCredito.Empresa=ProvCredito.LineaCredito
ProvCredito.LineaCredito=ProvCredito.Moneda
ProvCredito.Moneda=(Fin)
