[Forma]
Clave=CteEnviarALimite
Nombre=Limite Venta
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Cliente, Info.EnviarA, Info.Descripcion)
PosicionInicialIzquierda=281
PosicionInicialArriba=188
PosicionInicialAlturaCliente=358
PosicionInicialAncho=462
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteEnviarALimite
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=CteEnviarALimite.Cliente=<T>{Info.Cliente}<T> AND<BR>CteEnviarALimite.EnviarA={Info.EnviarA}
FiltroRespetar=S
FiltroTipo=General

[Lista.CteEnviarALimite.Limite]
Carpeta=Lista
Clave=CteEnviarALimite.Limite
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteEnviarALimite.Moneda]
Carpeta=Lista
Clave=CteEnviarALimite.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteEnviarALimite.Desde]
Carpeta=Lista
Clave=CteEnviarALimite.Desde
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteEnviarALimite.Hasta]
Carpeta=Lista
Clave=CteEnviarALimite.Hasta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Limite=153
Moneda=88
Desde=95
Hasta=94

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

[Lista.ListaEnCaptura]
(Inicio)=CteEnviarALimite.Limite
CteEnviarALimite.Limite=CteEnviarALimite.Moneda
CteEnviarALimite.Moneda=CteEnviarALimite.Desde
CteEnviarALimite.Desde=CteEnviarALimite.Hasta
CteEnviarALimite.Hasta=(Fin)
