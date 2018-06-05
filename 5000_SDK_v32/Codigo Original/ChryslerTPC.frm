[Forma]
Clave=ChryslerTPC
Nombre=Tabla Porcentaje Cumplimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=262
PosicionInicialArriba=180
PosicionInicialAlturaCliente=323
PosicionInicialAncho=327

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ChryslerTPC
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

[Lista.ChryslerTPC.CumplimientoD]
Carpeta=Lista
Clave=ChryslerTPC.CumplimientoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ChryslerTPC.CumplimientoA]
Carpeta=Lista
Clave=ChryslerTPC.CumplimientoA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ChryslerTPC.Bonificacion]
Carpeta=Lista
Clave=ChryslerTPC.Bonificacion
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
CumplimientoD=108
CumplimientoA=96
Bonificacion=90

[Lista.ListaEnCaptura]
(Inicio)=ChryslerTPC.CumplimientoD
ChryslerTPC.CumplimientoD=ChryslerTPC.CumplimientoA
ChryslerTPC.CumplimientoA=ChryslerTPC.Bonificacion
ChryslerTPC.Bonificacion=(Fin)
