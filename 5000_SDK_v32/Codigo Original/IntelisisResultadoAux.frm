
[Forma]
Clave=IntelisisResultadoAux
Icono=0
Modulos=(Todos)
Nombre=&Detalle (Aux)
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=IntelisisResultadoAux
CarpetaPrincipal=IntelisisResultadoAux
PosicionInicialIzquierda=1607
PosicionInicialAlturaCliente=259
PosicionInicialAncho=661
BarraHerramientas=S
PosicionInicialArriba=168
BarraAyuda=S
BarraAyudaEsp=S
BarraAyuda1=<T>Almacén: <T> + IntelisisResultadoAux:IntelisisResultadoAux.Almacen
BarraAyuda2=<T>Artículo: <T> + IntelisisResultadoAux:IntelisisResultadoAux.Articulo
BarraAyuda3=<T>SerieLote: <T> + IntelisisResultadoAux:IntelisisResultadoAux.SerieLote
BarraAyuda1Ancho=150
BarraAyuda2Ancho=100
BarraAyuda3Ancho=150
BarraAyuda4Ancho=0

[IntelisisResultadoAux]
Estilo=Hoja
Clave=IntelisisResultadoAux
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=IntelisisResultadoAux
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






[IntelisisResultadoAux.Columnas]
IDRef=64
Sistema=76
Fecha=132
Almacen=101
Articulo=124
SerieLote=151
Cantidad=88


ModuloID=64
Mov=124
MovID_numota=124
[Acciones.Cerrar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Cerrar.ListaAccionesMultiples]
(Inicio)=Info
Info=Cerrar
Cerrar=(Fin)




[(Carpeta Totalizadores)]
Pestana=S
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=a
Totalizadores2=IntelisisResultadoAux:Almacen
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Negro
CarpetaVisible=S




[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
Multiple=S
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Seleccionar/Resultado
ListaAccionesMultiples=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar

[Acciones.Cuadrar MES]
Nombre=Cuadrar MES
Boton=82
NombreEnBoton=S
NombreDesplegar=&Cuadrar Factory desde Intelisis
Multiple=S
EnBarraHerramientas=S
Activo=S
Visible=S



EspacioPrevio=S
ListaAccionesMultiples=(Lista)

[Acciones.Cuadrar MES.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=SI Precaucion( <T>¡Precaución!. Este proceso requiere que ningún usuario esté firmado en el sistema. Se harán ajustes automáticos<BR>en el inventario para cuadrar las existencias, está seguro? <T> ,BotonSi , BotonNo )= BotonSi<BR>ENTONCES<BR>ProcesarSQL(<T>EXEC spInforCuadrarExistenciaMES :tUsuario,:tEmpresa, :nSucursal, :tArticulo, :tSerieLote, :tAlmacen<T>,Usuario, Empresa, Info.Sucursal, Info.Articulo, Info.SerieLote, Info.Almacen)<BR>FIN
[Acciones.Cuadrar MES.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Cuadrar Intelisis.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=SI Precaucion( <T>¡Precaución!. Este proceso requiere que ningún usuario esté firmado en el sistema. Se harán ajustes automáticos<BR>en el inventario para cuadrar las existencias, está seguro? <T> ,BotonSi , BotonNo )= BotonSi<BR>ENTONCES<BR>ProcesarSQL(<T>spInforCuadrarExistenciaIntelisis :tEmpresa,:tUsuario,:nSucursal,:nEstacion,:tArticulo,:tAlmacen,:tSerieLote<T>,Empresa,Usuario,Sucursal, EstacionTrabajo, Info.Articulo, Info.Almacen, Info.SerieLote)<BR>ActualizarForma<BR>FIN
Activo=S
Visible=S

[Acciones.Cuadrar Intelisis]
Nombre=Cuadrar Intelisis
Boton=82
NombreEnBoton=S
NombreDesplegar=&Cuadrar Intelisis desde Factory
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=Expresion
Activo=S
Visible=S








[Acciones.Cuadrar MES.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)



[IntelisisResultadoAux.IntelisisResultadoAux.ModuloID]
Carpeta=IntelisisResultadoAux
Clave=IntelisisResultadoAux.ModuloID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[IntelisisResultadoAux.IntelisisResultadoAux.Mov]
Carpeta=IntelisisResultadoAux
Clave=IntelisisResultadoAux.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[IntelisisResultadoAux.IntelisisResultadoAux.MovID_numota]
Carpeta=IntelisisResultadoAux
Clave=IntelisisResultadoAux.MovID_numota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[IntelisisResultadoAux.IntelisisResultadoAux.Sistema]
Carpeta=IntelisisResultadoAux
Clave=IntelisisResultadoAux.Sistema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[IntelisisResultadoAux.IntelisisResultadoAux.Fecha]
Carpeta=IntelisisResultadoAux
Clave=IntelisisResultadoAux.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[IntelisisResultadoAux.IntelisisResultadoAux.Cantidad]
Carpeta=IntelisisResultadoAux
Clave=IntelisisResultadoAux.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[IntelisisResultadoAux.ListaEnCaptura]
(Inicio)=IntelisisResultadoAux.Sistema
IntelisisResultadoAux.Sistema=IntelisisResultadoAux.Fecha
IntelisisResultadoAux.Fecha=IntelisisResultadoAux.Cantidad
IntelisisResultadoAux.Cantidad=IntelisisResultadoAux.ModuloID
IntelisisResultadoAux.ModuloID=IntelisisResultadoAux.Mov
IntelisisResultadoAux.Mov=IntelisisResultadoAux.MovID_numota
IntelisisResultadoAux.MovID_numota=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cuadrar MES
Cuadrar MES=Cuadrar Intelisis
Cuadrar Intelisis=(Fin)
