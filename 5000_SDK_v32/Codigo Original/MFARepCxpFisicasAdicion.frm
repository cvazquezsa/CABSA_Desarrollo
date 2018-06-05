
[Forma]
Clave=MFARepCxpFisicasAdicion
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=MFA - Personas Físicas Adicionar Movimientos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
PosicionInicialIzquierda=481
PosicionInicialArriba=168
PosicionInicialAlturaCliente=353
PosicionInicialAncho=404
ListaCarpetas=(Lista)
CarpetaPrincipal=Documentos
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




[Datos.Columnas]
Modulo=57
Mov=273

[Datos.ListaEnCaptura]
(Inicio)=MFARepCxpFisicasAdicion.Modulo
MFARepCxpFisicasAdicion.Modulo=MFARepCxpFisicasAdicion.Mov
MFARepCxpFisicasAdicion.Mov=(Fin)

[Documentos]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Documentos
Clave=Documentos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFARepCxpFisicasAdicion
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
[Documentos.ListaEnCaptura]
(Inicio)=MFARepCxpFisicasAdicion.Modulo
MFARepCxpFisicasAdicion.Modulo=MFARepCxpFisicasAdicion.Mov
MFARepCxpFisicasAdicion.Mov=(Fin)

[Documentos.MFARepCxpFisicasAdicion.Modulo]
Carpeta=Documentos
Clave=MFARepCxpFisicasAdicion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Documentos.MFARepCxpFisicasAdicion.Mov]
Carpeta=Documentos
Clave=MFARepCxpFisicasAdicion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Devoluciones]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Devoluciones
Clave=Devoluciones
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFARepCxpFisicasDevAdicion
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
ListaEnCaptura=MFARepCxpFisicasDevAdicion.Mov

CarpetaVisible=S



[Documentos.Columnas]
Modulo=74
Mov=262

[Devoluciones.Columnas]
Modulo=73
Mov=264


[Devoluciones.ListaEnCaptura]
(Inicio)=MFARepCxpFisicasDevAdicion.Modulo
MFARepCxpFisicasDevAdicion.Modulo=MFARepCxpFisicasDevAdicion.Mov
MFARepCxpFisicasDevAdicion.Mov=(Fin)


[Devoluciones.MFARepCxpFisicasDevAdicion.Mov]
Carpeta=Devoluciones
Clave=MFARepCxpFisicasDevAdicion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Pagos]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pagos
Clave=Pagos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFARepCxpFisicasPagoAdicion
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
ListaEnCaptura=MFARepCxpFisicasPagoAdicion.Mov

CarpetaVisible=S
[Pagos.ListaEnCaptura]
(Inicio)=MFARepCxpFisicasPagoAdicion.Modulo
MFARepCxpFisicasPagoAdicion.Modulo=MFARepCxpFisicasPagoAdicion.Mov
MFARepCxpFisicasPagoAdicion.Mov=(Fin)


[Pagos.MFARepCxpFisicasPagoAdicion.Mov]
Carpeta=Pagos
Clave=MFARepCxpFisicasPagoAdicion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Pagos.Columnas]
Modulo=74
Mov=263



[Forma.ListaCarpetas]
(Inicio)=Documentos
Documentos=Devoluciones
Devoluciones=Pagos
Pagos=(Fin)
