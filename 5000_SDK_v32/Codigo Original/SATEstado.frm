[Forma]
Clave=SATEstado
Nombre=Catálogo de Entidades o Estados
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=432
PosicionInicialArriba=134
PosicionInicialAltura=346
PosicionInicialAncho=501
PosicionInicialAlturaCliente=421

ListaAcciones=Cerrar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATEstado
Fuente={MS Sans Serif, 8, Negro, []}
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
OtroOrden=S
ListaOrden=(Lista)






[Lista.Columnas]
LimiteInferior=102
LimiteSuperior=98
Cuota=87
Porcentaje=59
TablaImpuesto=96
PeriodoTipo=82
Fecha=111

ClaveEstado=105
ClavePais=112
Descripcion=211

[Lista.SATEstado.ClaveEstado]
Carpeta=Lista
Clave=SATEstado.ClaveEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.SATEstado.ClavePais]
Carpeta=Lista
Clave=SATEstado.ClavePais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[Lista.SATEstado.Descripcion]
Carpeta=Lista
Clave=SATEstado.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco













[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=SATEstado.ClaveEstado
SATEstado.ClaveEstado=SATEstado.ClavePais
SATEstado.ClavePais=SATEstado.Descripcion
SATEstado.Descripcion=(Fin)

[Lista.ListaOrden]
(Inicio)=SATEstado.ClavePais	(Acendente)
SATEstado.ClavePais	(Acendente)=SATEstado.ClaveEstado	(Acendente)
SATEstado.ClaveEstado	(Acendente)=(Fin)
