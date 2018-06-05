[Forma]
Clave=POSCxcAnticipoTemp2
Nombre=Anticipos Facturados Pendientes
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=1839
PosicionInicialArriba=283
PosicionInicialAlturaCliente=419
PosicionInicialAncho=802
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Cliente, Info.Nombre)
VentanaExclusiva=S

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSInsertarCxcAnticipoAplicarTemp  :nEstacion, :tID<T>,EstacionTrabajo, Info.IDTexto)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcAnticipoPendienteTemp
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
MenuLocal=S
ListaAcciones=Copiar

Pestana=S
PestanaOtroNombre=S
PestanaNombre=Anticipos Referenciados





FiltroGeneral=CxcAnticipoPendienteTemp.Estacion = {EstacionTrabajo}
[Lista.Columnas]
Mov=124
MovID=64
FechaEmision=74
Concepto=94
AnticipoSaldo=96
AnticipoAplicar=91
Referencia=96

Importe=64
Impuestos=64
Retencion=64
Moneda=64

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S

ConCondicion=S
EjecucionCondicion=(Suma(CxcAnticipoPendienteTemp:CxcAnticipoPendienteTemp.AnticipoAplicar)+Suma(CxcAnticipoPendienteTemp2:CxcAnticipoPendienteTemp2.AnticipoAplicar))<=Info.Importe
AntesExpresiones=GuardarCambios<BR>EjecutarSQL(<T>spPOSActualizarCxcAnticipoAplicar :nEstacion, :tID<T>, EstacionTrabajo, Info.IDTexto)
[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Copiar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(CxcAnticipoPendienteTemp:CxcAnticipoPendienteTemp.AnticipoAplicar,CxcAnticipoPendienteTemp:CxcAnticipoPendienteTemp.AnticipoSaldo)
[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S














[Lista2]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Anticipos Sin Referencia
Clave=Lista2
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcAnticipoPendienteTemp2
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S



MenuLocal=S
ListaAcciones=Copiar2

ListaEnCaptura=(Lista)
FiltroGeneral=CxcAnticipoPendienteTemp2.Estacion = {EstacionTrabajo}
[Acciones.Copiar2]
Nombre=Copiar2
Boton=0
NombreDesplegar=Copiar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S

UsaTeclaRapida=S
TeclaRapida=F5










Expresion=Asigna(CxcAnticipoPendienteTemp2:CxcAnticipoPendienteTemp2.AnticipoAplicar,CxcAnticipoPendienteTemp2:CxcAnticipoPendienteTemp2.AnticipoSaldo)
[Lista2.Columnas]
Mov=124
MovID=64
FechaEmision=75
Referencia=99
Concepto=84
AnticipoSaldo=71
Moneda=64
AnticipoAplicar=99


















[Lista.CxcAnticipoPendienteTemp.Mov]
Carpeta=Lista
Clave=CxcAnticipoPendienteTemp.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CxcAnticipoPendienteTemp.MovID]
Carpeta=Lista
Clave=CxcAnticipoPendienteTemp.MovID
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CxcAnticipoPendienteTemp.FechaEmision]
Carpeta=Lista
Clave=CxcAnticipoPendienteTemp.FechaEmision
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CxcAnticipoPendienteTemp.Referencia]
Carpeta=Lista
Clave=CxcAnticipoPendienteTemp.Referencia
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CxcAnticipoPendienteTemp.Concepto]
Carpeta=Lista
Clave=CxcAnticipoPendienteTemp.Concepto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.CxcAnticipoPendienteTemp.AnticipoSaldo]
Carpeta=Lista
Clave=CxcAnticipoPendienteTemp.AnticipoSaldo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CxcAnticipoPendienteTemp.Moneda]
Carpeta=Lista
Clave=CxcAnticipoPendienteTemp.Moneda
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CxcAnticipoPendienteTemp.AnticipoAplicar]
Carpeta=Lista
Clave=CxcAnticipoPendienteTemp.AnticipoAplicar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista2.CxcAnticipoPendienteTemp2.Mov]
Carpeta=Lista2
Clave=CxcAnticipoPendienteTemp2.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista2.CxcAnticipoPendienteTemp2.MovID]
Carpeta=Lista2
Clave=CxcAnticipoPendienteTemp2.MovID
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista2.CxcAnticipoPendienteTemp2.FechaEmision]
Carpeta=Lista2
Clave=CxcAnticipoPendienteTemp2.FechaEmision
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista2.CxcAnticipoPendienteTemp2.Referencia]
Carpeta=Lista2
Clave=CxcAnticipoPendienteTemp2.Referencia
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista2.CxcAnticipoPendienteTemp2.Concepto]
Carpeta=Lista2
Clave=CxcAnticipoPendienteTemp2.Concepto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista2.CxcAnticipoPendienteTemp2.AnticipoSaldo]
Carpeta=Lista2
Clave=CxcAnticipoPendienteTemp2.AnticipoSaldo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista2.CxcAnticipoPendienteTemp2.Moneda]
Carpeta=Lista2
Clave=CxcAnticipoPendienteTemp2.Moneda
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista2.CxcAnticipoPendienteTemp2.AnticipoAplicar]
Carpeta=Lista2
Clave=CxcAnticipoPendienteTemp2.AnticipoAplicar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco











[Lista2.ListaEnCaptura]
(Inicio)=CxcAnticipoPendienteTemp2.Mov
CxcAnticipoPendienteTemp2.Mov=CxcAnticipoPendienteTemp2.MovID
CxcAnticipoPendienteTemp2.MovID=CxcAnticipoPendienteTemp2.FechaEmision
CxcAnticipoPendienteTemp2.FechaEmision=CxcAnticipoPendienteTemp2.Referencia
CxcAnticipoPendienteTemp2.Referencia=CxcAnticipoPendienteTemp2.Concepto
CxcAnticipoPendienteTemp2.Concepto=CxcAnticipoPendienteTemp2.AnticipoSaldo
CxcAnticipoPendienteTemp2.AnticipoSaldo=CxcAnticipoPendienteTemp2.Moneda
CxcAnticipoPendienteTemp2.Moneda=CxcAnticipoPendienteTemp2.AnticipoAplicar
CxcAnticipoPendienteTemp2.AnticipoAplicar=(Fin)








[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cancelar
Cancelar=(Fin)



[Lista.ListaEnCaptura]
(Inicio)=CxcAnticipoPendienteTemp.Mov
CxcAnticipoPendienteTemp.Mov=CxcAnticipoPendienteTemp.MovID
CxcAnticipoPendienteTemp.MovID=CxcAnticipoPendienteTemp.FechaEmision
CxcAnticipoPendienteTemp.FechaEmision=CxcAnticipoPendienteTemp.Referencia
CxcAnticipoPendienteTemp.Referencia=CxcAnticipoPendienteTemp.Concepto
CxcAnticipoPendienteTemp.Concepto=CxcAnticipoPendienteTemp.AnticipoSaldo
CxcAnticipoPendienteTemp.AnticipoSaldo=CxcAnticipoPendienteTemp.Moneda
CxcAnticipoPendienteTemp.Moneda=CxcAnticipoPendienteTemp.AnticipoAplicar
CxcAnticipoPendienteTemp.AnticipoAplicar=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Lista2
Lista2=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
