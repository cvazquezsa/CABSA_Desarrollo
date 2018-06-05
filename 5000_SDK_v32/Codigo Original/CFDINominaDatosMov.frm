
[Forma]
Clave=CFDINominaDatosMov
Icono=0
Modulos=(Todos)
MovModulo=NOM
Nombre=Editar Datos

ListaCarpetas=Lista
CarpetaPrincipal=Lista
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=419
PosicionInicialArriba=127
PosicionInicialAlturaCliente=408
PosicionInicialAncho=444
BarraHerramientas=S
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDINominaDatosMov
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
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
FiltroGeneral=CFDINominaDatosMov.Estacion =  {EstacionTrabajo}
[Lista.Nomina.Mov]
Carpeta=Lista
Clave=Nomina.Mov
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Lista.Nomina.MovID]
Carpeta=Lista
Clave=Nomina.MovID
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Lista.CFDINominaDatosMov.FechaPago]
Carpeta=Lista
Clave=CFDINominaDatosMov.FechaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=127
NombreEnBoton=S
NombreDesplegar=&Timbrar
GuardarAntes=S
EnBarraHerramientas=S
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Lista.Columnas]
Mov=155
MovID=98
FechaPago=151











[Lista.ListaEnCaptura]
(Inicio)=Nomina.Mov
Nomina.Mov=Nomina.MovID
Nomina.MovID=CFDINominaDatosMov.FechaPago
CFDINominaDatosMov.FechaPago=(Fin)

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=SI SQL(<T>SELECT 1 FROM CFDINominaDatosMov WHERE Estacion = :nEstacion AND FechaPago IS NULL<T>, EstacionTrabajo) = 1<BR>Entonces<BR> Error( <T>Falta Indicar la Fecha de Pago<T> )<BR>Sino<BR>ProcesarSQL(<T>EXEC spCFDINominaGenerar :nEstacionTrabajo, 1, :tUsuario<T>, EstacionTrabajo, Usuario)<BR>Fin                                                                    <BR>ActualizarVista<BR>ActualizarForma
[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreEnBoton=S
NombreDesplegar=Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S



EspacioPrevio=S

















[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Cerrar
Cerrar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
