
[Forma]
Clave=MovTipoMFAExcepcion
Icono=0
Modulos=(Todos)
Nombre=MFA - Excepciones Movimientos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
ListaCarpetas=(Lista)
CarpetaPrincipal=Documento
PosicionInicialIzquierda=384
PosicionInicialArriba=100
PosicionInicialAlturaCliente=489
PosicionInicialAncho=598
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

[Documento]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Documento
Clave=Documento
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFADocExcepcion
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
[Documento.ListaEnCaptura]
(Inicio)=MovTipoMFADocExcepcion.Modulo
MovTipoMFADocExcepcion.Modulo=MovTipoMFADocExcepcion.Mov
MovTipoMFADocExcepcion.Mov=(Fin)

[Documento.MovTipoMFADocExcepcion.Modulo]
Carpeta=Documento
Clave=MovTipoMFADocExcepcion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Documento.MovTipoMFADocExcepcion.Mov]
Carpeta=Documento
Clave=MovTipoMFADocExcepcion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Aplicacion]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Aplicación
Clave=Aplicacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFAAplicaExcepcion
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

[Aplicacion.MovTipoMFAAplicaExcepcion.Modulo]
Carpeta=Aplicacion
Clave=MovTipoMFAAplicaExcepcion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Aplicacion.MovTipoMFAAplicaExcepcion.Mov]
Carpeta=Aplicacion
Clave=MovTipoMFAAplicaExcepcion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[CobroPago]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cobro / Pago
Clave=CobroPago
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFACobroPagoExcepcion
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

[CobroPago.MovTipoMFACobroPagoExcepcion.Modulo]
Carpeta=CobroPago
Clave=MovTipoMFACobroPagoExcepcion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[CobroPago.MovTipoMFACobroPagoExcepcion.Mov]
Carpeta=CobroPago
Clave=MovTipoMFACobroPagoExcepcion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Redocumentacion]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Redocumentación
Clave=Redocumentacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFARedocExcepcion
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

[Redocumentacion.MovTipoMFARedocExcepcion.Modulo]
Carpeta=Redocumentacion
Clave=MovTipoMFARedocExcepcion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Redocumentacion.MovTipoMFARedocExcepcion.Mov]
Carpeta=Redocumentacion
Clave=MovTipoMFARedocExcepcion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Documento.Columnas]
Modulo=62
Mov=209

[Aplicacion.Columnas]
Modulo=60
Mov=138

OrigenTipo=102
Origen=156
[CobroPago.Columnas]
Modulo=60
Mov=145

OrigenTipo=97
Origen=169
[Redocumentacion.Columnas]
Modulo=62
Mov=172












































OrigenTipo=91
Origen=144
[Aplicacion.ListaEnCaptura]
(Inicio)=MovTipoMFAAplicaExcepcion.Modulo
MovTipoMFAAplicaExcepcion.Modulo=MovTipoMFAAplicaExcepcion.Mov
MovTipoMFAAplicaExcepcion.Mov=MovTipoMFAAplicaExcepcion.OrigenTipo
MovTipoMFAAplicaExcepcion.OrigenTipo=MovTipoMFAAplicaExcepcion.Origen
MovTipoMFAAplicaExcepcion.Origen=(Fin)

[Aplicacion.MovTipoMFAAplicaExcepcion.OrigenTipo]
Carpeta=Aplicacion
Clave=MovTipoMFAAplicaExcepcion.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Aplicacion.MovTipoMFAAplicaExcepcion.Origen]
Carpeta=Aplicacion
Clave=MovTipoMFAAplicaExcepcion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CobroPago.ListaEnCaptura]
(Inicio)=MovTipoMFACobroPagoExcepcion.Modulo
MovTipoMFACobroPagoExcepcion.Modulo=MovTipoMFACobroPagoExcepcion.Mov
MovTipoMFACobroPagoExcepcion.Mov=MovTipoMFACobroPagoExcepcion.OrigenTipo
MovTipoMFACobroPagoExcepcion.OrigenTipo=MovTipoMFACobroPagoExcepcion.Origen
MovTipoMFACobroPagoExcepcion.Origen=(Fin)

[CobroPago.MovTipoMFACobroPagoExcepcion.OrigenTipo]
Carpeta=CobroPago
Clave=MovTipoMFACobroPagoExcepcion.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[CobroPago.MovTipoMFACobroPagoExcepcion.Origen]
Carpeta=CobroPago
Clave=MovTipoMFACobroPagoExcepcion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Redocumentacion.ListaEnCaptura]
(Inicio)=MovTipoMFARedocExcepcion.Modulo
MovTipoMFARedocExcepcion.Modulo=MovTipoMFARedocExcepcion.Mov
MovTipoMFARedocExcepcion.Mov=MovTipoMFARedocExcepcion.OrigenTipo
MovTipoMFARedocExcepcion.OrigenTipo=MovTipoMFARedocExcepcion.Origen
MovTipoMFARedocExcepcion.Origen=(Fin)

[Redocumentacion.MovTipoMFARedocExcepcion.OrigenTipo]
Carpeta=Redocumentacion
Clave=MovTipoMFARedocExcepcion.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Redocumentacion.MovTipoMFARedocExcepcion.Origen]
Carpeta=Redocumentacion
Clave=MovTipoMFARedocExcepcion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco














[Reporte]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Reporte
Clave=Reporte
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFAAplicaReporteExcepcion
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

[Reporte.MovTipoMFAAplicaReporteExcepcion.Modulo]
Carpeta=Reporte
Clave=MovTipoMFAAplicaReporteExcepcion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Reporte.MovTipoMFAAplicaReporteExcepcion.Mov]
Carpeta=Reporte
Clave=MovTipoMFAAplicaReporteExcepcion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Reporte.MovTipoMFAAplicaReporteExcepcion.OrigenTipo]
Carpeta=Reporte
Clave=MovTipoMFAAplicaReporteExcepcion.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Reporte.MovTipoMFAAplicaReporteExcepcion.Origen]
Carpeta=Reporte
Clave=MovTipoMFAAplicaReporteExcepcion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Reporte.MovTipoMFAAplicaReporteExcepcion.AplicaIeps]
Carpeta=Reporte
Clave=MovTipoMFAAplicaReporteExcepcion.AplicaIeps
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Reporte.MovTipoMFAAplicaReporteExcepcion.AplicaIVA]
Carpeta=Reporte
Clave=MovTipoMFAAplicaReporteExcepcion.AplicaIVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco


[Reporte.Columnas]
Modulo=38
Mov=111
OrigenTipo=78
Origen=124
AplicaIetu=58
AplicaIeps=57
AplicaIVA=52






[Endoso]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Endoso
Clave=Endoso
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFAEndosoExcepcion
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

[Endoso.MovTipoMFAEndosoExcepcion.Modulo]
Carpeta=Endoso
Clave=MovTipoMFAEndosoExcepcion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Endoso.MovTipoMFAEndosoExcepcion.Mov]
Carpeta=Endoso
Clave=MovTipoMFAEndosoExcepcion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Endoso.MovTipoMFAEndosoExcepcion.OrigenTipo]
Carpeta=Endoso
Clave=MovTipoMFAEndosoExcepcion.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Endoso.MovTipoMFAEndosoExcepcion.Origen]
Carpeta=Endoso
Clave=MovTipoMFAEndosoExcepcion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Endoso.Columnas]
Modulo=56
Mov=124
OrigenTipo=77
Origen=121


[Endoso.ListaEnCaptura]
(Inicio)=MovTipoMFAEndosoExcepcion.Modulo
MovTipoMFAEndosoExcepcion.Modulo=MovTipoMFAEndosoExcepcion.Mov
MovTipoMFAEndosoExcepcion.Mov=MovTipoMFAEndosoExcepcion.OrigenTipo
MovTipoMFAEndosoExcepcion.OrigenTipo=MovTipoMFAEndosoExcepcion.Origen
MovTipoMFAEndosoExcepcion.Origen=(Fin)








[Comprobante]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comprobante
Clave=Comprobante
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFACompDocExcepcion
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
[Comprobante.ListaEnCaptura]
(Inicio)=MovTipoMFACompDocExcepcion.Modulo
MovTipoMFACompDocExcepcion.Modulo=MovTipoMFACompDocExcepcion.Mov
MovTipoMFACompDocExcepcion.Mov=(Fin)

[Comprobante.MovTipoMFACompDocExcepcion.Modulo]
Carpeta=Comprobante
Clave=MovTipoMFACompDocExcepcion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Comprobante.MovTipoMFACompDocExcepcion.Mov]
Carpeta=Comprobante
Clave=MovTipoMFACompDocExcepcion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Comprobante.Columnas]
Modulo=59
Mov=178














[Concepto]
Estilo=Hoja
Pestana=S
Clave=Concepto
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFAConceptoExcepcion
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Concepto
PermiteEditar=S
ListaEnCaptura=(Lista)

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

[Concepto.MovTipoMFAConceptoExcepcion.Concepto]
Carpeta=Concepto
Clave=MovTipoMFAConceptoExcepcion.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Concepto.MovTipoMFAConceptoExcepcion.AplicaIetu]
Carpeta=Concepto
Clave=MovTipoMFAConceptoExcepcion.AplicaIetu
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Concepto.MovTipoMFAConceptoExcepcion.AplicaIeps]
Carpeta=Concepto
Clave=MovTipoMFAConceptoExcepcion.AplicaIeps
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco

[Concepto.MovTipoMFAConceptoExcepcion.AplicaIVA]
Carpeta=Concepto
Clave=MovTipoMFAConceptoExcepcion.AplicaIVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco



[Concepto.Columnas]
Concepto=336
AplicaIetu=60
AplicaIeps=57
AplicaIVA=52


[Concepto.ListaEnCaptura]
(Inicio)=MovTipoMFAConceptoExcepcion.Concepto
MovTipoMFAConceptoExcepcion.Concepto=MovTipoMFAConceptoExcepcion.AplicaIetu
MovTipoMFAConceptoExcepcion.AplicaIetu=MovTipoMFAConceptoExcepcion.AplicaIeps
MovTipoMFAConceptoExcepcion.AplicaIeps=MovTipoMFAConceptoExcepcion.AplicaIVA
MovTipoMFAConceptoExcepcion.AplicaIVA=(Fin)








[Lista.Columnas]
0=79
1=303
2=-2


















[Reporte.ListaEnCaptura]
(Inicio)=MovTipoMFAAplicaReporteExcepcion.Modulo
MovTipoMFAAplicaReporteExcepcion.Modulo=MovTipoMFAAplicaReporteExcepcion.Mov
MovTipoMFAAplicaReporteExcepcion.Mov=MovTipoMFAAplicaReporteExcepcion.OrigenTipo
MovTipoMFAAplicaReporteExcepcion.OrigenTipo=MovTipoMFAAplicaReporteExcepcion.Origen
MovTipoMFAAplicaReporteExcepcion.Origen=MovTipoMFAAplicaReporteExcepcion.AplicaIeps
MovTipoMFAAplicaReporteExcepcion.AplicaIeps=MovTipoMFAAplicaReporteExcepcion.AplicaIVA
MovTipoMFAAplicaReporteExcepcion.AplicaIVA=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Documento
Documento=Aplicacion
Aplicacion=CobroPago
CobroPago=Redocumentacion
Redocumentacion=Reporte
Reporte=Endoso
Endoso=Comprobante
Comprobante=Concepto
Concepto=(Fin)
