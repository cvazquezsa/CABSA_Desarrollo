[Forma]
Clave=AgenteComisionTipoFactura
Nombre=Comisiones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Agente
PosicionInicialIzquierda=316
PosicionInicialArriba=188
PosicionInicialAlturaCliente=357
PosicionInicialAncho=392
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
Vista=AgenteComisionTipoFactura
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
FiltroGeneral=AgenteComisionTipoFactura.Agente=<T>{Info.Agente}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.AgenteComisionTipoFactura.Mov]
Carpeta=Lista
Clave=AgenteComisionTipoFactura.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AgenteComisionTipoFactura.Porcentaje]
Carpeta=Lista
Clave=AgenteComisionTipoFactura.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AgenteComisionTipoFactura.Importe]
Carpeta=Lista
Clave=AgenteComisionTipoFactura.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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

[Lista.Columnas]
Mov=175
Porcentaje=45
Importe=141

[Lista.ListaEnCaptura]
(Inicio)=AgenteComisionTipoFactura.Mov
AgenteComisionTipoFactura.Mov=AgenteComisionTipoFactura.Porcentaje
AgenteComisionTipoFactura.Porcentaje=AgenteComisionTipoFactura.Importe
AgenteComisionTipoFactura.Importe=(Fin)
