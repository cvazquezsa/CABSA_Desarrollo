[Forma]
Clave=SysTablaLista
Nombre=Tablas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=435
PosicionInicialArriba=312
PosicionInicialAltura=400
PosicionInicialAncho=410
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=373

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SysTabla
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tabla<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Tablas
IconosNombre=SysTabla:SysTabla.SysTabla

[Lista.SysTabla.Descripcion]
Carpeta=Lista
Clave=SysTabla.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.Columnas]
SysTabla=128
Descripcion=251
0=133
1=128

[Lista.SysTabla.Tipo]
Carpeta=Lista
Clave=SysTabla.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Campos
Campos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SysTabla.Descripcion
SysTabla.Descripcion=SysTabla.Tipo
SysTabla.Tipo=(Fin)

[Lista.ListaOrden]
(Inicio)=SysTabla.SincroOrden<TAB>(Acendente)
SysTabla.SincroOrden<TAB>(Acendente)=SysTabla.SysTabla<TAB>(Acendente)
SysTabla.SysTabla<TAB>(Acendente)=(Fin)
