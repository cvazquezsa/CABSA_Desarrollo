
[Forma]
Clave=MovTipoMFATipoIetu
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Tipos Movimientos IETU
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=440
PosicionInicialArriba=143
PosicionInicialAlturaCliente=403
PosicionInicialAncho=486
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFATipoIetu
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

ListaOrden=MovTipoMFATipoIetu.Tipo<TAB>(Acendente)
CarpetaVisible=S

[Lista.MovTipoMFATipoIetu.Tipo]
Carpeta=Lista
Clave=MovTipoMFATipoIetu.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=150
ColorFondo=Blanco

[Lista.MovTipoMFATipoIetu.Descripcion]
Carpeta=Lista
Clave=MovTipoMFATipoIetu.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=150
ColorFondo=Blanco

[Lista.Columnas]
Tipo=72
Descripcion=316

[Lista.ListaEnCaptura]
(Inicio)=MovTipoMFATipoIetu.Tipo
MovTipoMFATipoIetu.Tipo=MovTipoMFATipoIetu.Descripcion
MovTipoMFATipoIetu.Descripcion=(Fin)

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=&Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S








[Acciones.SubTipos]
Nombre=SubTipos
Boton=55
NombreEnBoton=S
NombreDesplegar=&Sub Tipos
EnBarraHerramientas=S
TipoAccion=Formas
Activo=S
Visible=S



EspacioPrevio=S








ClaveAccion=MovTipoMFASubTipoIetu












Antes=S




















AntesExpresiones=Asigna(Info.ID, MovTipoMFATipoIetu:MovTipoMFATipoIetu.Tipo)






















[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Excel
Excel=SubTipos
SubTipos=(Fin)
