
[Forma]
Clave=VentaRefacturarTemp
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=VentaRefacturarTemp
CarpetaPrincipal=VentaRefacturarTemp
PosicionInicialIzquierda=212
PosicionInicialArriba=35
PosicionInicialAlturaCliente=615
PosicionInicialAncho=855
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Cliente
Nombre=Refacturar Notas
ExpresionesAlMostrar=Asigna(Info.MovGenerar,SQL(<T>SELECT TOP 1 Mov FROM MovTipo WHERE Modulo = :tModulo AND Clave = :tClave<T>,<T>VTAS<T>,<T>VTAS.N<T>))<BR>Asigna(Info.Cliente,Nulo)<BR>Asigna(Info.MovID,Nulo)<BR>EjecutarSQL(<T>spPOSBorrarVentaRefacturarTemp :nEstacion<T>,EstacionTrabajo)
[VentaRefacturarTemp]
Estilo=Hoja
Clave=VentaRefacturarTemp
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaRefacturarTemp
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Alm
FiltroAplicaEn1=VentaRefacturar.Almacen
FiltroTodo=S
PestanaOtroNombre=S
PestanaNombre=Refacturar Notas
FiltroGeneral=VentaRefacturarTemp.Estacion ={EstacionTrabajo}
[VentaRefacturarTemp.VentaRefacturarTemp.Mov]
Carpeta=VentaRefacturarTemp
Clave=VentaRefacturarTemp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[VentaRefacturarTemp.VentaRefacturarTemp.MovID]
Carpeta=VentaRefacturarTemp
Clave=VentaRefacturarTemp.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[VentaRefacturarTemp.Columnas]
Mov=124
MovID=124
Importe=64
Impuestos=64


ID=64

Cliente_1=64
FechaEmision=94
[Acciones.EspecificarCliente.EspecificarCliente]
Nombre=EspecificarCliente
Boton=0
TipoAccion=Formas
ClaveAccion=EspecificarCliente
Activo=S
Visible=S

[Acciones.EspecificarCliente.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.EspecificarCliente.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S


[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S






GuardarAntes=S
[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S




EspacioPrevio=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=Expresion
Antes=S
DespuesGuardar=S
[Acciones.EspecificarCliente.ListaAccionesMultiples]
(Inicio)=EspecificarCliente
EspecificarCliente=Variables Asignar
Variables Asignar=Actualizar Forma
Actualizar Forma=(Fin)


























[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107
Mov=198



















































[VentaRefacturarTemp.VentaRefacturar.Cliente]
Carpeta=VentaRefacturarTemp
Clave=VentaRefacturar.Cliente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[VentaRefacturarTemp.VentaRefacturar.FechaEmision]
Carpeta=VentaRefacturarTemp
Clave=VentaRefacturar.FechaEmision
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaRefacturarTemp.VentaRefacturar.Importe]
Carpeta=VentaRefacturarTemp
Clave=VentaRefacturar.Importe
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[VentaRefacturarTemp.VentaRefacturar.Impuestos]
Carpeta=VentaRefacturarTemp
Clave=VentaRefacturar.Impuestos
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[VentaRefacturar.Columnas]
0=-2
1=59
2=176
3=77
4=95




































[Acciones.Generar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=FormaModal(<T>EspecificarReprocesarVenta<T>)<BR>ActualizarForma
[Acciones.Generar.ListaAccionesMultiples]
(Inicio)=EspecificarReprocesarVenta
EspecificarReprocesarVenta=Expresion
Expresion=(Fin)

































[Acciones.Asignar]
Nombre=Asignar
Boton=18
NombreDesplegar=Asignar Selección
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S









NombreEnBoton=S



































EspacioPrevio=S
Expresion=FormaModal(<T>VentaRefacturarLista<T>)<BR>ActualizarForma
[VentaRefacturarTemp.ListaEnCaptura]
(Inicio)=VentaRefacturarTemp.Mov
VentaRefacturarTemp.Mov=VentaRefacturarTemp.MovID
VentaRefacturarTemp.MovID=VentaRefacturar.Cliente
VentaRefacturar.Cliente=VentaRefacturar.FechaEmision
VentaRefacturar.FechaEmision=VentaRefacturar.Importe
VentaRefacturar.Importe=VentaRefacturar.Impuestos
VentaRefacturar.Impuestos=(Fin)



















































































































































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Generar
Generar=Asignar
Asignar=(Fin)
