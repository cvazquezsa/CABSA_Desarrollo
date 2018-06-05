[Forma]
Clave=ChryslerTBC
Nombre=Tabla Bonificacion Contratos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=449
PosicionInicialArriba=288
PosicionInicialAlturaCliente=413
PosicionInicialAncho=382
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ChryslerTBC
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

[Lista.ChryslerTBC.Contrato]
Carpeta=Lista
Clave=ChryslerTBC.Contrato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ChryslerTBC.Unidades]
Carpeta=Lista
Clave=ChryslerTBC.Unidades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ChryslerTBC.ImporteTotal]
Carpeta=Lista
Clave=ChryslerTBC.ImporteTotal
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
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Contrato=150
Unidades=64
ImporteTotal=137

[Lista.ListaEnCaptura]
(Inicio)=ChryslerTBC.Contrato
ChryslerTBC.Contrato=ChryslerTBC.Unidades
ChryslerTBC.Unidades=ChryslerTBC.ImporteTotal
ChryslerTBC.ImporteTotal=(Fin)
