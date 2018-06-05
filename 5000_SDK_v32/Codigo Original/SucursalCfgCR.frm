[Forma]
Clave=SucursalCfgCR
Nombre=Plantilla - Cajas Registradoras
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Sucursal, Info.Nombre)
PosicionInicialIzquierda=214
PosicionInicialArriba=143
PosicionInicialAlturaCliente=353
PosicionInicialAncho=525
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SucursalCfgCR
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=SucursalCfgCR.Sucursal={Info.Sucursal}

[Lista.SucursalCfgCR.Agente]
Carpeta=Lista
Clave=SucursalCfgCR.Agente
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
Editar=S

[Lista.Agente.Nombre]
Carpeta=Lista
Clave=Agente.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Agente.Tipo]
Carpeta=Lista
Clave=Agente.Tipo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Gris

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

[Lista.Columnas]
Agente=96
Nombre=304
Tipo=94

[Lista.ListaEnCaptura]
(Inicio)=SucursalCfgCR.Agente
SucursalCfgCR.Agente=Agente.Nombre
Agente.Nombre=Agente.Tipo
Agente.Tipo=(Fin)
