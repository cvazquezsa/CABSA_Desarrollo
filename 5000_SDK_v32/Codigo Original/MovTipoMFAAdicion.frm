
[Forma]
Clave=MovTipoMFAAdicion
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=MFA - Movimientos adicionales
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
ListaCarpetas=(Lista)
CarpetaPrincipal=Documento
PosicionInicialAlturaCliente=367
PosicionInicialAncho=579
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=393
PosicionInicialArriba=161
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
PestanaNombre=Documentos
Clave=Documento
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFADocAdicion
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
(Inicio)=MovTipoMFADocAdicion.Modulo
MovTipoMFADocAdicion.Modulo=MovTipoMFADocAdicion.Mov
MovTipoMFADocAdicion.Mov=MovTipoMFADocAdicion.DocumentoTipo
MovTipoMFADocAdicion.DocumentoTipo=(Fin)

[Documento.MovTipoMFADocAdicion.Modulo]
Carpeta=Documento
Clave=MovTipoMFADocAdicion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Documento.MovTipoMFADocAdicion.Mov]
Carpeta=Documento
Clave=MovTipoMFADocAdicion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Documento.MovTipoMFADocAdicion.DocumentoTipo]
Carpeta=Documento
Clave=MovTipoMFADocAdicion.DocumentoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Documento.Columnas]
Modulo=66
Mov=150
DocumentoTipo=151

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
Vista=MovTipoMFAAplicaAdicion
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

[Aplicacion.MovTipoMFAAplicaAdicion.Modulo]
Carpeta=Aplicacion
Clave=MovTipoMFAAplicaAdicion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Aplicacion.MovTipoMFAAplicaAdicion.Mov]
Carpeta=Aplicacion
Clave=MovTipoMFAAplicaAdicion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Aplicacion.MovTipoMFAAplicaAdicion.OrigenTipo]
Carpeta=Aplicacion
Clave=MovTipoMFAAplicaAdicion.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Aplicacion.MovTipoMFAAplicaAdicion.Origen]
Carpeta=Aplicacion
Clave=MovTipoMFAAplicaAdicion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Aplicacion.Columnas]
Modulo=65
Mov=124
OrigenTipo=73
Origen=124










tipo_documento=122
[Cobro]
Estilo=Hoja
Pestana=S
Clave=Cobro
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFACobroAdicion
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
PestanaOtroNombre=S
PestanaNombre=Cobro

[Cobro.MovTipoMFACobroAdicion.Modulo]
Carpeta=Cobro
Clave=MovTipoMFACobroAdicion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Cobro.MovTipoMFACobroAdicion.Mov]
Carpeta=Cobro
Clave=MovTipoMFACobroAdicion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Cobro.MovTipoMFACobroAdicion.OrigenTipo]
Carpeta=Cobro
Clave=MovTipoMFACobroAdicion.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Cobro.MovTipoMFACobroAdicion.Origen]
Carpeta=Cobro
Clave=MovTipoMFACobroAdicion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Pago]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Pago
Clave=Pago
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFAPagoAdicion
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

[Pago.MovTipoMFAPagoAdicion.Modulo]
Carpeta=Pago
Clave=MovTipoMFAPagoAdicion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Pago.MovTipoMFAPagoAdicion.Mov]
Carpeta=Pago
Clave=MovTipoMFAPagoAdicion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Pago.MovTipoMFAPagoAdicion.OrigenTipo]
Carpeta=Pago
Clave=MovTipoMFAPagoAdicion.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Pago.MovTipoMFAPagoAdicion.Origen]
Carpeta=Pago
Clave=MovTipoMFAPagoAdicion.Origen
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
Vista=MovTipoMFARedocAdicion
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

[Redocumentacion.MovTipoMFARedocAdicion.Modulo]
Carpeta=Redocumentacion
Clave=MovTipoMFARedocAdicion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Redocumentacion.MovTipoMFARedocAdicion.Mov]
Carpeta=Redocumentacion
Clave=MovTipoMFARedocAdicion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Redocumentacion.MovTipoMFARedocAdicion.OrigenTipo]
Carpeta=Redocumentacion
Clave=MovTipoMFARedocAdicion.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Redocumentacion.MovTipoMFARedocAdicion.Origen]
Carpeta=Redocumentacion
Clave=MovTipoMFARedocAdicion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


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
Vista=MovTipoMFAEndosoAdicion
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

[Endoso.MovTipoMFAEndosoAdicion.Modulo]
Carpeta=Endoso
Clave=MovTipoMFAEndosoAdicion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Endoso.MovTipoMFAEndosoAdicion.Mov]
Carpeta=Endoso
Clave=MovTipoMFAEndosoAdicion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Endoso.MovTipoMFAEndosoAdicion.OrigenTipo]
Carpeta=Endoso
Clave=MovTipoMFAEndosoAdicion.OrigenTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Endoso.MovTipoMFAEndosoAdicion.Origen]
Carpeta=Endoso
Clave=MovTipoMFAEndosoAdicion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Cobro.Columnas]
Modulo=38
Mov=124
OrigenTipo=73
Origen=124

tipo_documento=145
[Pago.Columnas]
Modulo=38
Mov=124
OrigenTipo=73
Origen=124

tipo_documento=147
[Redocumentacion.Columnas]
Modulo=38
Mov=124
OrigenTipo=73
Origen=124

tipo_documento=144
[Endoso.Columnas]
Modulo=38
Mov=124
OrigenTipo=73
Origen=124


































tipo_documento=144
[Comprobante]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comprobante
Clave=Comprobante
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFACompDocAdicion
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
CarpetaVisible=S
ListaEnCaptura=(Lista)

PermiteEditar=S

[Comprobante.MovTipoMFACompDocAdicion.Modulo]
Carpeta=Comprobante
Clave=MovTipoMFACompDocAdicion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Comprobante.MovTipoMFACompDocAdicion.Mov]
Carpeta=Comprobante
Clave=MovTipoMFACompDocAdicion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Comprobante.MovTipoMFACompDocAdicion.DocumentoTipo]
Carpeta=Comprobante
Clave=MovTipoMFACompDocAdicion.DocumentoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Comprobante.Columnas]
Modulo=65
Mov=124
DocumentoTipo=177


[Comprobante.ListaEnCaptura]
(Inicio)=MovTipoMFACompDocAdicion.Modulo
MovTipoMFACompDocAdicion.Modulo=MovTipoMFACompDocAdicion.Mov
MovTipoMFACompDocAdicion.Mov=MovTipoMFACompDocAdicion.DocumentoTipo
MovTipoMFACompDocAdicion.DocumentoTipo=(Fin)












[Aplicacion.ListaEnCaptura]
(Inicio)=MovTipoMFAAplicaAdicion.Modulo
MovTipoMFAAplicaAdicion.Modulo=MovTipoMFAAplicaAdicion.Mov
MovTipoMFAAplicaAdicion.Mov=MovTipoMFAAplicaAdicion.OrigenTipo
MovTipoMFAAplicaAdicion.OrigenTipo=MovTipoMFAAplicaAdicion.Origen
MovTipoMFAAplicaAdicion.Origen=MovTipoMFAAplicaAdicion.tipo_documento
MovTipoMFAAplicaAdicion.tipo_documento=(Fin)

[Aplicacion.MovTipoMFAAplicaAdicion.tipo_documento]
Carpeta=Aplicacion
Clave=MovTipoMFAAplicaAdicion.tipo_documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco






[Endoso.ListaEnCaptura]
(Inicio)=MovTipoMFAEndosoAdicion.Modulo
MovTipoMFAEndosoAdicion.Modulo=MovTipoMFAEndosoAdicion.Mov
MovTipoMFAEndosoAdicion.Mov=MovTipoMFAEndosoAdicion.OrigenTipo
MovTipoMFAEndosoAdicion.OrigenTipo=MovTipoMFAEndosoAdicion.Origen
MovTipoMFAEndosoAdicion.Origen=MovTipoMFAEndosoAdicion.tipo_documento
MovTipoMFAEndosoAdicion.tipo_documento=(Fin)

[Endoso.MovTipoMFAEndosoAdicion.tipo_documento]
Carpeta=Endoso
Clave=MovTipoMFAEndosoAdicion.tipo_documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[Cobro.ListaEnCaptura]
(Inicio)=MovTipoMFACobroAdicion.Modulo
MovTipoMFACobroAdicion.Modulo=MovTipoMFACobroAdicion.Mov
MovTipoMFACobroAdicion.Mov=MovTipoMFACobroAdicion.OrigenTipo
MovTipoMFACobroAdicion.OrigenTipo=MovTipoMFACobroAdicion.Origen
MovTipoMFACobroAdicion.Origen=MovTipoMFACobroAdicion.tipo_documento
MovTipoMFACobroAdicion.tipo_documento=(Fin)

[Cobro.MovTipoMFACobroAdicion.tipo_documento]
Carpeta=Cobro
Clave=MovTipoMFACobroAdicion.tipo_documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[Pago.ListaEnCaptura]
(Inicio)=MovTipoMFAPagoAdicion.Modulo
MovTipoMFAPagoAdicion.Modulo=MovTipoMFAPagoAdicion.Mov
MovTipoMFAPagoAdicion.Mov=MovTipoMFAPagoAdicion.OrigenTipo
MovTipoMFAPagoAdicion.OrigenTipo=MovTipoMFAPagoAdicion.Origen
MovTipoMFAPagoAdicion.Origen=MovTipoMFAPagoAdicion.tipo_documento
MovTipoMFAPagoAdicion.tipo_documento=(Fin)

[Pago.MovTipoMFAPagoAdicion.tipo_documento]
Carpeta=Pago
Clave=MovTipoMFAPagoAdicion.tipo_documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




[Redocumentacion.ListaEnCaptura]
(Inicio)=MovTipoMFARedocAdicion.Modulo
MovTipoMFARedocAdicion.Modulo=MovTipoMFARedocAdicion.Mov
MovTipoMFARedocAdicion.Mov=MovTipoMFARedocAdicion.OrigenTipo
MovTipoMFARedocAdicion.OrigenTipo=MovTipoMFARedocAdicion.Origen
MovTipoMFARedocAdicion.Origen=MovTipoMFARedocAdicion.tipo_documento
MovTipoMFARedocAdicion.tipo_documento=(Fin)

[Redocumentacion.MovTipoMFARedocAdicion.tipo_documento]
Carpeta=Redocumentacion
Clave=MovTipoMFARedocAdicion.tipo_documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco











[Forma.ListaCarpetas]
(Inicio)=Documento
Documento=Aplicacion
Aplicacion=Cobro
Cobro=Pago
Pago=Redocumentacion
Redocumentacion=Endoso
Endoso=Comprobante
Comprobante=(Fin)
