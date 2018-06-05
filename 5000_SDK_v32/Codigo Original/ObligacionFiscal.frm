[Forma]
Clave=ObligacionFiscal
Nombre=Obligaciones Fiscales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=264
PosicionInicialArriba=233
PosicionInicialAlturaCliente=396
PosicionInicialAncho=911
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
Vista=ObligacionFiscal
Fuente={Tahoma, 8, Negro, []}
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
ListaOrden=ObligacionFiscal.Orden<TAB>(Acendente)
HojaTitulos=S
HojaMostrarColumnas=S
ValidarCampos=S
ListaCamposAValidar=Acreedor.Nombre

[Lista.ObligacionFiscal.ObligacionFiscal]
Carpeta=Lista
Clave=ObligacionFiscal.ObligacionFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco

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
ObligacionFiscal=241
Tipo=68
Orden=35
Estatus=65
Cuenta=104
ContraCuenta=124
Cuenta2=103
Acreedor=84
Deudor=90
Condicion=80
GenerarEn=72
FechaD=94
FechaA=94

Regimen=96
[Lista.ObligacionFiscal.Tipo]
Carpeta=Lista
Clave=ObligacionFiscal.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ObligacionFiscal.Orden]
Carpeta=Lista
Clave=ObligacionFiscal.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ObligacionFiscal.Acreedor]
Carpeta=Lista
Clave=ObligacionFiscal.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.ObligacionFiscal.Condicion]
Carpeta=Lista
Clave=ObligacionFiscal.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ObligacionFiscal.GenerarEn]
Carpeta=Lista
Clave=ObligacionFiscal.GenerarEn
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ObligacionFiscal.FechaD]
Carpeta=Lista
Clave=ObligacionFiscal.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ObligacionFiscal.FechaA]
Carpeta=Lista
Clave=ObligacionFiscal.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.ObligacionFiscal.Regimen]
Carpeta=Lista
Clave=ObligacionFiscal.Regimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=ObligacionFiscal.ObligacionFiscal
ObligacionFiscal.ObligacionFiscal=ObligacionFiscal.Tipo
ObligacionFiscal.Tipo=ObligacionFiscal.GenerarEn
ObligacionFiscal.GenerarEn=ObligacionFiscal.FechaD
ObligacionFiscal.FechaD=ObligacionFiscal.FechaA
ObligacionFiscal.FechaA=ObligacionFiscal.Acreedor
ObligacionFiscal.Acreedor=ObligacionFiscal.Condicion
ObligacionFiscal.Condicion=ObligacionFiscal.Orden
ObligacionFiscal.Orden=ObligacionFiscal.Regimen
ObligacionFiscal.Regimen=(Fin)
