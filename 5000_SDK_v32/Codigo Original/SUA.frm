
[Forma]
Clave=SUA
Icono=47
BarraHerramientas=S
Modulos=(Todos)
Nombre=SUA
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=SUA
PosicionInicialAlturaCliente=622
PosicionInicialAncho=1215
PosicionInicialIzquierda=75
PosicionInicialArriba=33
PosicionSec1=295
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaColor=Plata
ListaAcciones=(Lista)
Comentarios=Lista(Info.Reporte,Info.Ejercicio,Info.Periodo)
MovModulo=(Todos)
[SUA]
Estilo=Hoja
Clave=SUA
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SUA
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=SUA.Nombre<TAB>(Acendente)
CarpetaVisible=S

[SUA.SUA.Personal]
Carpeta=SUA
Clave=SUA.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SUA.SUA.NSS]
Carpeta=SUA
Clave=SUA.NSS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUA.SUA.Nombre]
Carpeta=SUA
Clave=SUA.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[SUA.SUA.Origen]
Carpeta=SUA
Clave=SUA.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUA.SUA.Tipo]
Carpeta=SUA
Clave=SUA.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUA.SUA.Fecha]
Carpeta=SUA
Clave=SUA.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUA.SUA.Dias]
Carpeta=SUA
Clave=SUA.Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUA.SUA.SDI]
Carpeta=SUA
Clave=SUA.SDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUA.SUA.TipoDescuento]
Carpeta=SUA
Clave=SUA.TipoDescuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SUA.SUA.ValorDescuento]
Carpeta=SUA
Clave=SUA.ValorDescuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUA.SUA.Credito]
Carpeta=SUA
Clave=SUA.Credito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SUA.Columnas]
NSS=146
Nombre=201
Origen=110
Tipo=98
Fecha=107
Dias=64
SDI=66
TipoDescuento=93
ValorDescuento=97
Credito=124

[SUA.ListaEnCaptura]
(Inicio)=SUA.Personal
SUA.Personal=SUA.NSS
SUA.NSS=SUA.Nombre
SUA.Nombre=SUA.Origen
SUA.Origen=SUA.Tipo
SUA.Tipo=SUA.Fecha
SUA.Fecha=SUA.Dias
SUA.Dias=SUA.SDI
SUA.SDI=SUA.TipoDescuento
SUA.TipoDescuento=SUA.ValorDescuento
SUA.ValorDescuento=SUA.Credito
SUA.Credito=(Fin)

[SUAImportacion]
Estilo=Hoja
Clave=SUAImportacion
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=SUAImportacion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaOrden=SUAImportacion.NSS<TAB>(Acendente)
CarpetaVisible=S

[SUAImportacion.SUAImportacion.NSS]
Carpeta=SUAImportacion
Clave=SUAImportacion.NSS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[SUAImportacion.SUAImportacion.Nombre]
Carpeta=SUAImportacion
Clave=SUAImportacion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[SUAImportacion.SUAImportacion.Origen]
Carpeta=SUAImportacion
Clave=SUAImportacion.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAImportacion.SUAImportacion.Tipo]
Carpeta=SUAImportacion
Clave=SUAImportacion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAImportacion.SUAImportacion.Fecha]
Carpeta=SUAImportacion
Clave=SUAImportacion.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAImportacion.SUAImportacion.Dias]
Carpeta=SUAImportacion
Clave=SUAImportacion.Dias
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAImportacion.SUAImportacion.SDI]
Carpeta=SUAImportacion
Clave=SUAImportacion.SDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAImportacion.SUAImportacion.TipoDescuento]
Carpeta=SUAImportacion
Clave=SUAImportacion.TipoDescuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SUAImportacion.SUAImportacion.ValorDescuento]
Carpeta=SUAImportacion
Clave=SUAImportacion.ValorDescuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[SUAImportacion.SUAImportacion.Credito]
Carpeta=SUAImportacion
Clave=SUAImportacion.Credito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[SUAImportacion.Columnas]
NSS=184
Nombre=199
Origen=110
Tipo=98
Fecha=107
Dias=64
SDI=66
TipoDescuento=93
ValorDescuento=97
Credito=124

[SUAImportacion.ListaEnCaptura]
(Inicio)=SUAImportacion.NSS
SUAImportacion.NSS=SUAImportacion.Nombre
SUAImportacion.Nombre=SUAImportacion.Origen
SUAImportacion.Origen=SUAImportacion.Tipo
SUAImportacion.Tipo=SUAImportacion.Fecha
SUAImportacion.Fecha=SUAImportacion.Dias
SUAImportacion.Dias=SUAImportacion.SDI
SUAImportacion.SDI=SUAImportacion.TipoDescuento
SUAImportacion.TipoDescuento=SUAImportacion.ValorDescuento
SUAImportacion.ValorDescuento=SUAImportacion.Credito
SUAImportacion.Credito=(Fin)
















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


















[Acciones.Importar.Importar]
Nombre=Importar
Boton=0
Carpeta=SUAImportacion
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Acciones.Importar.Guardar]
Nombre=Guardar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Importar]
Nombre=Importar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Importar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S

[Acciones.Comparar]
Nombre=Comparar
Boton=54
NombreEnBoton=S
NombreDesplegar=C&omparar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>EXEC spSUAComparacion<T>)<BR>Forma(<T>SUAComparacion<T>)
[SUAComparacion.Columnas]
NSS=77
Nombre=194
Origen=38
Tipo=25
Fecha=65
Dias=29
SDI=51
TipoDescuento=58
ValorDescuento=46
Credito=95

OrigenDatos=64

[Acciones.Calcular]
Nombre=Calcular
Boton=20
NombreEnBoton=S
NombreDesplegar=C&alcular
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Forma(<T>VarReporteSUA<T>)<BR>ActualizarVista<BR>ActualizarForma

[Acciones.Importar.ListaAccionesMultiples]
(Inicio)=Importar
Importar=Guardar
Guardar=(Fin)









[Acciones.Comparar.ListaAccionesMultiples]
(Inicio)=Cerrar
Cerrar=Expresion
Expresion=(Fin)































[Forma.ListaCarpetas]
(Inicio)=SUA
SUA=SUAImportacion
SUAImportacion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Calcular
Calcular=Importar
Importar=Comparar
Comparar=(Fin)
