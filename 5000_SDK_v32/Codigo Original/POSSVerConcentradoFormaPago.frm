
[Forma]
Clave=POSSVerConcentradoFormaPago
Icono=0
Modulos=(Todos)
Nombre=Concentrado Formas de Pago

ListaCarpetas=Campos
CarpetaPrincipal=Campos
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=336
PosicionInicialAncho=625
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=370
PosicionInicialArriba=198
[Campos]
Estilo=Iconos
Clave=Campos
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSSVerConcentradoFormaPago
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Caja<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Formas de Pago

AutoRefrescar=S
TiempoRefrescar=00:30
IconosNombre=POSSVerConcentradoFormaPago:CtaDinero
[Campos.FormaPago]
Carpeta=Campos
Clave=FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Campos.Importe]
Carpeta=Campos
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
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

[Campos.Columnas]
0=107
1=163
2=97














3=-2
4=-2
5=97
6=-2
[Acciones.Generar Incidencia Nómina]
Nombre=Generar Incidencia Nómina
Boton=61
NombreEnBoton=S
NombreDesplegar=Generar Incidencia Nómina
EnBarraHerramientas=S
Activo=S
Visible=S



EspacioPrevio=S











[Campos.ComisionPorcentaje]
Carpeta=Campos
Clave=ComisionPorcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.Comision]
Carpeta=Campos
Clave=Comision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.IVA]
Carpeta=Campos
Clave=IVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Campos.ListaEnCaptura]
(Inicio)=FormaPago
FormaPago=Importe
Importe=ComisionPorcentaje
ComisionPorcentaje=Comision
Comision=IVA
IVA=(Fin)



























[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Generar Incidencia Nómina
Generar Incidencia Nómina=(Fin)
